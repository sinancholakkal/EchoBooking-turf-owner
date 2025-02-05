import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echo_booking_owner/domain/models/user_model.dart';

class UserService {
    Future<void>userStore(UserModel user)async{
    print("===================================storeddetails called");
    FirebaseFirestore.instance.collection("owner").doc(user.uid).set({
      "uid":user.uid,
      "name":user.name,
      "phone" : user.phone,
      "email":user.email,
    });
  }
}