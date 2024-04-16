import 'package:afeer/models/video_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LectureModel {
  final int? ranking;
  final String? alerts;
  final String details;
  final List? exam;
  final String name;
  final Map? videoLink;
  final List<String>? pdfLinks;
  final Timestamp time;

  LectureModel({
    this.ranking,
    required this.time,
    this.alerts,
    this.exam,
    this.videoLink,
    this.pdfLinks,
    required this.name,
    required this.details,
  });
  factory LectureModel.fromJson(Map<String, dynamic> json) => LectureModel(
        name: json["name"],
        alerts: json["alerts"],
        exam: json["exam"],
        pdfLinks: List.generate(
            json["pdfLinks"] != null ? json["pdfLinks"].length : 0,
            (index) => json["pdfLinks"][index]),
        ranking: json["Ranking"],
        videoLink: {"link": json["videoLink"], "time": json["date"] ?? "0"},
        details: json["details"] ?? "",
        time: json["time"] ?? Timestamp.now(),
      );
  Map<String, dynamic> toMap() => {
        "name": name,
        "details": details,
        "time": time,
      };
}
