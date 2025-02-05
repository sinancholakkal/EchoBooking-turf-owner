class UserModel {
  String name;
  String phone;
  String email;
  String? password;
  String? uid;
  UserModel({
    required this.name,
    required this.phone,
     this.uid,
    required this.email,
    this.password,
  });
}
