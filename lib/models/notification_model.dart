class NotificationModel {
  final String title;
  final String subTitle;
  final String? image;

  NotificationModel(
      {required this.title, required this.subTitle, required this.image});
  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        image: json["image"],
        subTitle: json["subTitle"],
        title: json["title"],
      );
}
