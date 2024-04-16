class VideoModel {
  final String link;
  final String time;

  VideoModel({required this.link, required this.time});
  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
        time: json["time"],
        link: json["link"],
      );
}
