import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echo_booking_owner/domain/models/booking_turf_model.dart';
import 'package:echo_booking_owner/domain/repository/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class DashBoardService {
  Future<void> fetchDashBoard() async {
    List<List> turfModels = [
      [], //Total bookigs.
      [], //Last year bookings
      [], //Last 30 dayes booking
      [], //Last 7 days booking
      [], //Today Bookings
    ];
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

      if (
          slotDate.isAfter(lastWeekStart) &&
          slotDate.isBefore(lastDate)) {
        turfModels[3].add(bookingTurfmodel);
        turfModels[0].add(bookingTurfmodel);
    
      }
      // DateTime lastYearStart = DateTime(now.year - 1, 1, 1);
      // DateTime lastYearEnd = DateTime(now.year - 1, 12, 31, 23, 59, 59);
      // log(lastYearStart.toString());

      int currentYear = DateTime.now().year;
      int slotYear = int.parse(bookingTurfmodel.bookingDate.split("-")[2]);
      // log(currentYear.toString());
      // log(slotYear.toString());
      if( slotYear==currentYear){
        turfModels[1].add(bookingTurfmodel);
        turfModels[0].add(bookingTurfmodel);
      }
    }
    log(turfModels[1].toString());
  }
}
