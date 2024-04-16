class AdditionalSubject {
  final String name;
  final String? image;

  AdditionalSubject({required this.name, required this.image});
  factory AdditionalSubject.fromJson(Map<String, dynamic> json) =>
      AdditionalSubject(
          image: json["image"] ??
              "https://firebasestorage.googleapis.com/v0/b/afeer-2ea3a.appspot.com/o/subjectPhoto%2F%D8%B3%D9%84%D9%88%D9%83.jpg%7D?alt=media&token=95f7168d-d4c5-4e48-b40a-134d7d83c046",
          name: json["name"]);
}
