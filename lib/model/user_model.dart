import 'dart:convert';

import 'package:flutter_template/model/events_model.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.bookmarkedEvents,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.projectId,
    required this.role,
    required this.phoneNumber,
    required this.createdAt,
    required this.updatedAt,
  });

  List<EventsModel> bookmarkedEvents;
  String id;
  String firstName;
  String lastName;
  String email;
  String password;
  String projectId;
  String role;
  int phoneNumber;
  DateTime createdAt;
  DateTime updatedAt;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    bookmarkedEvents: List<EventsModel>.from(json["bookmarkedEvents"].map((x) => EventsModel.fromJson(x))),
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    password: json["password"],
    projectId: json["projectId"],
    role: json["role"],
    phoneNumber: json["phoneNumber"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "bookmarkedEvents": List<dynamic>.from(bookmarkedEvents.map((x) => x.toJson())),
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "password": password,
    "projectId": projectId,
    "role": role,
    "phoneNumber": phoneNumber,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}
