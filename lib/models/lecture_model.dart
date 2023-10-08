import 'package:cloud_firestore/cloud_firestore.dart';

class LectureModel{
  final int ?ranking;
  final String? alerts;
  final String details;
  final String name;
  final String? videoLink;
  final List<String>?pdfLinks;
  final Timestamp time;

  LectureModel(  { this.ranking, required this.time, this.alerts,  this.videoLink,  this.pdfLinks,required this.name,required this.details,});
  factory LectureModel.fromJson(Map<String,dynamic>json)=>LectureModel(
    name: json["name"],
    alerts: json["alerts"],
    pdfLinks: List.generate(json["pdfLinks"]!=null?json["pdfLinks"].length:0, (index) => json["pdfLinks"][index]),
    ranking: json["Ranking"],
    videoLink: json["videoLink"],
      details: json["details"],
    time: json["time"],

  );
  Map<String,dynamic>toMap()=>{
    "name":name,
    "details":details,
    "time":time,
  };
}