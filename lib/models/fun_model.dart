class FunModel {
  final String name;
  final String kind;
  final String image;
  final String video;

  FunModel(
      {required this.name,
      required this.kind,
      required this.image,
      required this.video});
  factory FunModel.fromJson(Map<String, dynamic> json) => FunModel(
        name: json["name"],
        kind: json["kind"],
        image: json["image"],
        video: json["video"],
      );
}
