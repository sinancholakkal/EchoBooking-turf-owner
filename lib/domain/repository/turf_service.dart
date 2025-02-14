import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echo_booking_owner/domain/models/turf_model.dart';
import 'package:echo_booking_owner/feature/presentation/pages/screen_home/widgets/image_add_part_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:dio/dio.dart';

class TurfService {
  final ownerId = FirebaseAuth.instance;
  Future<void> addTurf(TurfModel turfModel) async {
    turfModel.images = await uploadImagesToCloudinary(images.value);
    await FirebaseFirestore.instance
        .collection("owner")
        .doc(ownerId.currentUser!.uid)
        .collection("turfs")
        .doc(turfModel.turfId)
        .set({
      "turfname": turfModel.turfName,
      "phone": turfModel.phone,
      "email": turfModel.email,
      "price": turfModel.price,
      "state": turfModel.state,
      "country": turfModel.country,
      "latitude": turfModel.latitude,
      "longitude": turfModel.longitude,
      "catogery": turfModel.catogery,
      "includes": turfModel.includes,
      "landmark": turfModel.landmark,
      "images": turfModel.images,
      "turfid": turfModel.turfId,
    });
    turfModel.timeSlots.forEach((key, value) async {
      await FirebaseFirestore.instance
          .collection("owner")
          .doc(ownerId.currentUser!.uid)
          .collection("turfs")
          .doc(turfModel.turfId)
          .collection("timeSlotes")
          .doc(key)
          .set({"time_slot": value});
    });
  }

  Future<void> updateTurf(TurfModel turfModel) async {
    // Upload images first
    turfModel.images = await uploadImagesToCloudinary(images.value);

    // Reference Firestore
    final firestore = FirebaseFirestore.instance;
    final ownerDoc =
        firestore.collection("owner").doc(ownerId.currentUser!.uid);
    final turfDoc = ownerDoc.collection("turfs").doc(turfModel.turfId);

    // Use batch write for efficiency
    WriteBatch batch = firestore.batch();

    // Update turf details
    batch.update(turfDoc, {
      "turfname": turfModel.turfName,
      "phone": turfModel.phone,
      "email": turfModel.email,
      "price": turfModel.price,
      "state": turfModel.state,
      "country": turfModel.country,
      "latitude": turfModel.latitude,
      "longitude": turfModel.longitude,
      "catogery": turfModel.catogery,
      "includes": turfModel.includes,
      "landmark": turfModel.landmark,
      "images": turfModel.images,
      "turfid": turfModel.turfId,
    });

    // Update time slots
    turfModel.timeSlots.forEach((key, value) {
      DocumentReference timeSlotDoc = turfDoc.collection("timeSlotes").doc(key);
      batch.set(timeSlotDoc, {"time_slot": value});
    });

    // Commit all updates at once
    await batch.commit();
  }

  // Future<void>updateTurf(TurfModel turfModel)async{
  //   turfModel.images = await uploadImagesToCloudinary(images.value);
  //   await FirebaseFirestore.instance
  //       .collection("owner")
  //       .doc(ownerId.currentUser!.uid)
  //       .collection("turfs")
  //       .doc(turfModel.turfId)
  //       .update({
  //     "turfname": turfModel.turfName,
  //     "phone": turfModel.phone,
  //     "email": turfModel.email,
  //     "price": turfModel.price,
  //     "state": turfModel.state,
  //     "country": turfModel.country,
  //     "latitude": turfModel.latitude,
  //     "longitude": turfModel.longitude,
  //     "catogery": turfModel.catogery,
  //     "includes": turfModel.includes,
  //     "landmark": turfModel.landmark,
  //     "images": turfModel.images,
  //     "turfid": turfModel.turfId,
  //   });
  //   turfModel.timeSlots.forEach((key, value) async {
  //     await FirebaseFirestore.instance
  //         .collection("owner")
  //         .doc(ownerId.currentUser!.uid)
  //         .collection("turfs")
  //         .doc(turfModel.turfId)
  //         .collection("timeSlotes")
  //         .doc(key)
  //         .set({"time_slot": value});
  //   });
  // }

  Future<List<TurfModel>> fetchturfs() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("owner")
        .doc(ownerId.currentUser!.uid)
        .collection("turfs")
        .get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = snapshot.docs;
    List<TurfModel> listTurfModel = [];
    for (var doc in docs) {
      Map<String, dynamic> turfData = doc.data();
      QuerySnapshot<Map<String, dynamic>> timeSlotsSnapshot =
          await FirebaseFirestore.instance
              .collection("owner")
              .doc(ownerId.currentUser!.uid)
              .collection("turfs")
              .doc(turfData["turfid"])
              .collection('timeSlotes')
              .get();
      List<QueryDocumentSnapshot<Map<String, dynamic>>> timeSlotes =
          timeSlotsSnapshot.docs;
      Map<String, List<Map<String, dynamic>>> timeSlotsMap = {};

      for (var timeSlot in timeSlotes) {
        String dateKey = timeSlot.id;
        Map<String, dynamic> timeData = timeSlot.data();

        if (!timeSlotsMap.containsKey(dateKey)) {
          timeSlotsMap[dateKey] = [];
        }

        if (timeData.containsKey("time_slot") &&
            timeData["time_slot"] is List) {
          List<dynamic> timeSlotList = timeData["time_slot"];

          for (var slot in timeSlotList) {
            if (slot is Map<String, dynamic>) {
              timeSlotsMap[dateKey]?.add(slot);
            }
          }
        } else {
          timeSlotsMap[dateKey]?.add(timeData);
        }
      }

      log(timeSlotsMap.toString());

      TurfModel turfModel = TurfModel(
        turfId: turfData['turfid'],
        turfName: turfData['turfname'],
        phone: turfData['phone'],
        email: turfData['email'],
        price: turfData["price"],
        state: turfData['state'],
        country: turfData['country'],
        catogery: turfData['catogery'],
        includes: turfData['includes'],
        landmark: turfData['landmark'],
        latitude: turfData['latitude'],
        longitude: turfData['longitude'],
        images: (turfData["images"] as List<dynamic>?)?.cast<String>(),
        timeSlots: timeSlotsMap,
      );
      // log(turfData["images"].runtimeType.toString());
      // log("========================");
      listTurfModel.add(turfModel);
    }
    return listTurfModel;
  }

  Future<List<String>> uploadImagesToCloudinary(List<dynamic> images) async {
    log("called============");
    List<String> uploadedUrls = [];
    String cloudName = "doymuvr4s";
    String uploadPreset = "xzxyhat";

    for (dynamic image in images) {
      if (image is Uint8List) {
        FormData formData = FormData.fromMap({
          "file": MultipartFile.fromBytes(image, filename: "upload.jpg"),
          "upload_preset": uploadPreset,
        });

        try {
          log("try bloc");
          var response = await Dio().post(
            "https://api.cloudinary.com/v1_1/$cloudName/image/upload",
            data: formData,
          );

          if (response.statusCode == 200) {
            String imageUrl = response.data["secure_url"];
            uploadedUrls.add(imageUrl);
          } else {
            print("Upload failed: ${response.statusMessage}");
          }
        } catch (e) {
          print("Error uploading image: $e");
        }
      } else {
        uploadedUrls.add(image);
      }
    }
    log(uploadedUrls.toString());
    return uploadedUrls;
  }
}

// "turfname":turfModel.turfName,
//       "phone":turfModel.phone,
//       "email":turfModel.email,
//       "price":turfModel.price,
//       "state":turfModel.state,
//       "country":turfModel.country,
//       "latitude":turfModel.latitude,
//       "longitude":turfModel.longitude,
//       "catogery":turfModel.catogery,
//       "includes":turfModel.includes,
//       "landmark":turfModel.landmark,
