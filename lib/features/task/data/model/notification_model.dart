class NotificationModel {
  String? title;
  String? body;
  String? payload;
  NotificationModel({this.title, this.body, this.payload});

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      title: json['title'],
      body: json['body'],
      payload: json['payload'],
    );
  }
}
