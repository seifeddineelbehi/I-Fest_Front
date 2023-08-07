class PlaningModel {
  PlaningModel({
    required this.startTime,
    required this.endTime,
    required this.id,
    required this.description,

  });

  String startTime;
  String endTime;
  String id;
  String description;


  factory PlaningModel.fromJson(Map<String, dynamic> json) =>
      PlaningModel(
        startTime: json["startTime"],
        endTime: json["endTime"],
        id: json["_id"],
        description: json["description"],

      );

  Map<String, dynamic> toJson() =>
      {
        "startTime": startTime,
        "endTime": endTime,
        "_id": id,
        "description": description,

      };
}
