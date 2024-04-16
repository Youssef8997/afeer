class AcademicYear {
  final String image;
  final String image2;
  final String name;
  final String type;
  final String info;
  final String? time;
  final String year;
  final bool isRev;

  AcademicYear(
      {required this.image,
      required this.name,
      required this.info,
      required this.image2,
      required this.time,
      required this.type,
      required this.year,
      this.isRev = false});
  factory AcademicYear.fromJson(Map<String, dynamic> json) => AcademicYear(
        name: json["name"],
        type: json["type"],
        time: json["time"] ?? "ساعات 0 دقائق 0",
        info: json["info"] ?? json["type"],
        image2: json["image2"] ?? json["image"],
        image: json["image"],
        year: json["year"],
        isRev: json["isRev"] ?? false,
      );
  Map<String, dynamic> toMap() => {
        "name": name,
        "type": type,
        "image": image,
        "time": time,
        "image2": image2,
        "year": year,
        "isRev": isRev,
      };
}
