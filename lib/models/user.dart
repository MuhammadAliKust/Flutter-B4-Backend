// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) =>
    json.encode(data.toJson(data.docId.toString()));

class UserModel {
  final String? docId;
  final String? email;
  final String? name;
  final String? address;
  final String? phoneNumber;
  final int? createdAt;

  UserModel({
    this.docId,
    this.email,
    this.name,
    this.address,
    this.phoneNumber,
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        docId: json["docID"],
        email: json["email"],
        name: json["name"],
        address: json["address"],
        phoneNumber: json["phoneNumber"],
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toJson(String userID) => {
        "docID": userID,
        "email": email,
        "name": name,
        "address": address,
        "phoneNumber": phoneNumber,
        "createdAt": createdAt,
      };
}
