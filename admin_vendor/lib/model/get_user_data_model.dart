import 'dart:developer';

class GetUserDataModel {
  String? name;
  String? email;
  String? phoneno;
  String? uid;
  String? storeName;
  String? profileImage;
  String? location;
  int? seats;
  double? rating;

  GetUserDataModel(Map<String, dynamic> userMap) {
    log("STORE NAME: ${userMap['storeName']}");
    name = userMap['name'];
    email = userMap['email'];
    phoneno = userMap['phone number'] ?? "-";
    uid = userMap['uid'];
    profileImage = userMap['profileImg'];
    storeName = userMap['storeName'] ?? '-';
    location = userMap['location'];
    seats = userMap['seats'];
    rating = userMap['rating'] ?? '-';
  }
}
