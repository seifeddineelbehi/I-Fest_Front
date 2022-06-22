class TestModel {
  int? id;
  int? userId;
  String? title;
  String? body;

  TestModel({this.id, this.userId, this.title, this.body});
  TestModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    userId = json["userId"];
    title = json["title"];
    body = json["body"];
  }
  Map<String, dynamic> toJSON() {
    return {
      "id": id,
      "userId": userId,
      "title": title,
      "body": body,
    };
  }
}
