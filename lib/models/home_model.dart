class HomeModel{
  final String videoLink;
  final String term;
  final List fiends;
  final List university;
  final List pay;
final String? googleLink;
final int version;
final String? iosLink;
  HomeModel(
      { required this.videoLink, required this.term,required this.fiends,required this.university,required this.pay,required this.version, required this.googleLink, required this.iosLink, });

factory HomeModel.fromJson(Map<String,dynamic>json)=>HomeModel(

   version: json["version"],
  iosLink: json["iosLink"],
  googleLink: json["googleLink"],
  videoLink: json["videoLink"],
  term: json["term"],
  fiends: json["fiends"],
  university: json["university"],
  pay: json["pay"],
);
}
class CollageModel{
  final String courseDates;
  final String studySchedules;
  final List sliders;


  CollageModel({
    required this.courseDates,
    required this.studySchedules,
    required this.sliders,
  });

  factory CollageModel.fromJson(Map<String,dynamic>json)=>CollageModel(
    sliders: List.generate(json["sliders"].length, (index) => json["sliders"][index]),
    courseDates: json["courseDates"],
    studySchedules: json["studySchedules"],

  );
}

