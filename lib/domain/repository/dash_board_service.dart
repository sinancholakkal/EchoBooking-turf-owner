import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echo_booking_owner/domain/models/booking_turf_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class DashBoardService {
  Future<Map<String, List<BookingTurfmodel>>> fetchDashBoard() async {
    Map<String, List<BookingTurfmodel>> turfModels = {
      "totalbookings": [],
      'lastyearbookings': [],
      'lastmonthbookings': [],
      'lastsevendaysbookings': [],
      'todaybookings': [],
    };
    final snapshot = await FirebaseFirestore.instance
        .collection('owner')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('bookings')
        .get();
    for (var turf in snapshot.docs) {
      final data = turf.data();
      final BookingTurfmodel bookingTurfmodel = BookingTurfmodel(
        slotDate: data['slotdate'] ?? "Unknown",
        price: data['price'],
        paymentId: data['paymentid'],
        bookingDate: data['bookingdate'] ?? "Unknown",
        userName: data['username'],
        bookingTime: data['bookingtime'],
        catogery: data['catogery'],
        turfName: data['turfname'],
        userPhone: data['userphone'],
      );
      //log(bookingTurfmodel.turfName);
      //bool added = false;
      DateTime now = DateTime.now();
      DateTime lastWeekStart = now.subtract(Duration(days: 7));
      DateTime lastDate = now;
      DateTime slotDate =
          DateFormat("dd-MM-yyyy").parse(bookingTurfmodel.bookingDate);
      // Define last year's range (January 1st to December 31st)
      //Sortng as last 7 days-------
      if (slotDate.isAfter(lastWeekStart) && slotDate.isBefore(lastDate)) {
        turfModels['lastsevendaysbookings']!.add(bookingTurfmodel);
      }
      //Sorting as last year------
      int currentYear = DateTime.now().year;
      int slotYear = int.parse(bookingTurfmodel.bookingDate.split("-")[2]);
      if (slotYear == currentYear) {
        turfModels['lastyearbookings']!.add(bookingTurfmodel);
      }
      //Sorting as last month----
      int currentMonth = DateTime.now().month;
      if (slotYear == currentYear &&
          currentMonth ==
              int.parse(bookingTurfmodel.bookingDate.split("-")[1])) {
        turfModels['lastmonthbookings']!.add(bookingTurfmodel);
      }
      //Sorting as today's bookings
      if (lastDate.day ==
              int.parse(bookingTurfmodel.bookingDate.split("-")[0]) &&
          lastDate.month ==
              int.parse(bookingTurfmodel.bookingDate.split("-")[1])) {
        turfModels['todaybookings']!.add(bookingTurfmodel);
      }
      turfModels['totalbookings']!.add(bookingTurfmodel);
    }

    return turfModels;
  }
  //Fetching revanue based on the date range
  Future<String>fetchRevanueDateRange({required String startD, required String endD})async{
    num revanue = 0;

    final snapshot = await FirebaseFirestore.instance
        .collection('owner')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('bookings')
        .get();

        for(var bookingDoc in snapshot.docs){
          final booking = bookingDoc.data();
          num price = double.parse(booking['price']);
          DateTime date =
          DateFormat("dd-MM-yyyy").parse(booking['bookingdate']);
          DateTime startDate =
          DateFormat("dd-MM-yyyy").parse(startD);
          DateTime endDate =
          DateFormat("dd-MM-yyyy").parse(endD);
          
          if(startDate.isBefore(date) && endDate.isAfter(date) || startDate.isAtSameMomentAs(date) || endDate.isAtSameMomentAs(date)){
            log(date.toString());
            log("======================");
            revanue +=price;
          }


        }

    return revanue.toString();
  }
}
