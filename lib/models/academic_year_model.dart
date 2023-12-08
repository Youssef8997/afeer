class AcademicYear {
  final String image;
  final String name;
  final String type;
  final String year;
  final bool isRev;

  AcademicYear(
      {required this.image,
      required this.name,
      required this.type,
      required this.year,
      this.isRev = false});
  factory AcademicYear.fromJson(Map<String, dynamic> json) => AcademicYear(
        name: json["name"],
        type: json["type"],
        image: json["image"],
        year: json["year"],
        isRev: json["isRev"] ?? false,
      );
  Map<String, dynamic> toMap() => {
        "name": name,
        "type": type,
        "image": image,
        "year": year,
        "isRev": isRev,
      };
}
