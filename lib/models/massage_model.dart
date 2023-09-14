import 'package:cloud_firestore/cloud_firestore.dart';

class MassageModel{
  final Timestamp time;
  final String massage;
  final String sender;

  MassageModel({required this.time, required this.massage, required this.sender});
  factory MassageModel.fromJson(Map<String,dynamic>json)=>MassageModel(
    time: json["time"],
    massage: json["massage"],
    sender: json["sender"],
  );
}
