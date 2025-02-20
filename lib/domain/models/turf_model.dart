class TurfModel {
  final String turfId;
  final String turfName;
  final String phone;
  final String email;
  final String price;
  final String state;
  final String country;
  final String catogery;
  final String includes;
  final String landmark;
  final String latitude;
  final String longitude;
  final String reviewStatus;
  List<String>?images;
  final Map<String, List<Map<String, dynamic>>> timeSlots;
  TurfModel({
    required this.turfId,
    required this.turfName,
    required this.phone,
    required this.email,
    required this.price,
    required this.state,
    required this.country,
    required this.catogery,
    required this.includes,
    required this.landmark,
    required this.latitude,
    required this.longitude,
    required this.timeSlots,
     this.images,
     required this.reviewStatus
  });
}
