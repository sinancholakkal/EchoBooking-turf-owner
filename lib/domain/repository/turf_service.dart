import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echo_booking_owner/domain/models/turf_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TurfService {
  final ownerId = FirebaseAuth.instance;
  Future<void> addTurf(TurfModel turfModel) async {
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
    });
    turfModel.timeSlots.forEach((key,value)async{
      await FirebaseFirestore.instance.collection("owner").doc(ownerId.currentUser!.uid).collection("turfs").doc(turfModel.turfId).collection("timeSlotes").doc(key).set({
        "time_slot":value
      });
    });
    
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
