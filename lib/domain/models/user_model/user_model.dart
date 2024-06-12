import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  UserModel({
    this.firstName,
    this.lastName,
    this.dob,
    this.status = false,
  });

  final String? lastName;
  final String? firstName;
  final bool status;
  final DateTime? dob;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json["first_name"],
      lastName: json["last_name"],
      status: json["status"] ?? false,
      dob: (json["dob"] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "dob": Timestamp.fromDate(dob!),
      "last_name": lastName,
      "first_name": firstName,
      "status": status
    };
  }
}
