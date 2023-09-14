class HomeModel{
  final String courseDates;
  final String studySchedules;
  final String videoLink;
  final List sliders;
  final List university;

  HomeModel(
      {required this.courseDates, required this.studySchedules, required this.videoLink, required this.sliders,required this.university, });

factory HomeModel.fromJson(Map<String,dynamic>json)=>HomeModel(
  sliders: List.generate(json["sliders"].length, (index) => json["sliders"][index]),
  courseDates: json["courseDates"],
  studySchedules: json["studySchedules"],
  videoLink: json["videoLink"],
  university: json["university"],
);
}

