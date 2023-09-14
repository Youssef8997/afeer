import 'package:cloud_firestore/cloud_firestore.dart';

class LectureModel{
  final int ranking;
  final String alerts;
  final String details;
  final String name;
  final String videoLink;
  final Timestamp time;
  final List<String>pdfLinks;

  LectureModel( {required this.ranking,required this.time, required this.alerts, required this.videoLink, required this.pdfLinks,required this.name,required this.details,});
  factory LectureModel.fromJson(Map<String,dynamic>json)=>LectureModel(
    name: json["name"],
    alerts: json["alerts"],
    pdfLinks: List.generate(json["pdfLinks"].length, (index) => json["pdfLinks"][index]),
    ranking: json["Ranking"],
    videoLink: json["videoLink"],
    details: json["details"],
    time: json["time"],

  );
}