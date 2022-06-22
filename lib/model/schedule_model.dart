class ScheduleModel {
  ScheduleModel({
    required this.id,
    required this.current,
    required this.next,
    required this.type,
    required this.time,
  });

  final String id;
  final String next;
  final String current;
  final String type;
  final String time;

  factory ScheduleModel.fromJson(Map<String, dynamic> json) => ScheduleModel(
        id: json["_id"],
        next: json["next"],
        current: json["current"],
        type: json["type"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "next": next,
        "current": current,
        "time": time,
      };
}
