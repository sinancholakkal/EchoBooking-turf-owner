import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echo_booking_owner/domain/models/booking_turf_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookingService {
  final ownerId = FirebaseAuth.instance;
  Future<List<BookingTurfmodel>> fetchBookigsTurf() async {
    List<BookingTurfmodel> turfList = [];
    final snapshot = await FirebaseFirestore.instance
        .collection('owner')
        .doc(ownerId.currentUser!.uid)
        .collection('bookings')
        .get();
    for (var turf in snapshot.docs) {
      final data = turf.data();
      final BookingTurfmodel bookingTurfmodel = BookingTurfmodel(
        price: data['price'],
        paymentId: data['paymentid'],
        bookingDate: data['bookingtime'],
        userName: data['username'],
        bookingTime: data['bookingtime'],
        catogery: data['catogery'],
        turfName: data['turfname'],
        userPhone: data['userphone'],
      );
      turfList.add(bookingTurfmodel);
    }
    return turfList;
  }
}
