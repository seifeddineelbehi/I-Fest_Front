import 'dart:convert';

import 'package:flutter_template/model/planing_model.dart';

GeneralPlaningModel generalPlaningModelFromJson(String str) =>
    GeneralPlaningModel.fromJson(json.decode(str));

String generalPlaningModelToJson(GeneralPlaningModel data) =>
    json.encode(data.toJson());

class GeneralPlaningModel {
  GeneralPlaningModel({
    required this.success,
    required this.listGeneralPlanning,
  });

  bool success;
  List<ListGeneralPlanning> listGeneralPlanning;

  factory GeneralPlaningModel.fromJson(Map<String, dynamic> json) =>
      GeneralPlaningModel(
        success: json["success"],
        listGeneralPlanning: List<ListGeneralPlanning>.from(
            json["listGeneralPlanning"]
                .map((x) => ListGeneralPlanning.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "listGeneralPlanning":
            List<dynamic>.from(listGeneralPlanning.map((x) => x.toJson())),
      };
}

class ListGeneralPlanning {
  ListGeneralPlanning({
    required this.id,
    required this.date,
    required this.planing,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String id;
  DateTime date;
  List<PlaningModel> planing;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory ListGeneralPlanning.fromJson(Map<String, dynamic> json) =>
      ListGeneralPlanning(
        id: json["_id"],
        date: DateTime.parse(json["date"]),
        planing: List<PlaningModel>.from(
            json["planing"].map((x) => PlaningModel.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "date": date.toIso8601String(),
        "planing": List<dynamic>.from(planing.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
