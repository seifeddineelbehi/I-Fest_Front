import 'dart:convert';

import 'package:flutter_template/model/planing_model.dart';

EventsModel eventsModelFromJson(String str) =>
    EventsModel.fromJson(json.decode(str));

String eventsModelToJson(EventsModel data) => json.encode(data.toJson());

class EventsModel {
  EventsModel({
    required this.id,
    required this.eventName,
    required this.eventLocation,
    required this.eventPrice,
    required this.eventDate,
    required this.eventStartTime,
    required this.eventEndTime,
    required this.eventAbout,
    required this.planing,
    required this.image,
    required this.likes,
    required this.unlikes,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String id;
  String eventName;
  String eventLocation;
  int eventPrice;
  DateTime eventDate;
  String eventStartTime;
  String eventEndTime;
  String eventAbout;
  List<PlaningModel> planing;
  String image;
  DateTime createdAt;
  DateTime updatedAt;
  List<String> likes;
  List<String> unlikes;
  int v;

  factory EventsModel.fromJson(Map<String, dynamic> json) => EventsModel(
        id: json["_id"],
        eventName: json["eventName"],
        eventLocation: json["eventLocation"],
        eventPrice: json["eventPrice"],
        eventDate: DateTime.parse(json["eventDate"]),
        eventStartTime: json["eventStartTime"],
        eventEndTime: json["eventEndTime"],
        eventAbout: json["eventAbout"],
        planing: List<PlaningModel>.from(
            json["planing"].map((x) => PlaningModel.fromJson(x))),
        likes: List<String>.from(json["likes"].map((x) => x)),
        unlikes: List<String>.from(json["unlikes"].map((x) => x)),
        /*likes: List<UserModel>.from(
            json["likes"].map((x) => UserModel.fromJson(x))),
        unlikes: List<UserModel>.from(
            json["unlikes"].map((x) => UserModel.fromJson(x))),*/
        image: json["image"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "eventName": eventName,
        "eventLocation": eventLocation,
        "eventPrice": eventPrice,
        "eventDate": eventDate,
        "eventStartTime": eventStartTime,
        "eventEndTime": eventEndTime,
        "eventAbout": eventAbout,
        "planing": List<dynamic>.from(planing.map((x) => x.toJson())),
        "image": image,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
