import 'package:cloud_firestore/cloud_firestore.dart';

class MassageModel{
  final String senderId;
  final String massage;
  final Timestamp time;

  MassageModel({required this.senderId, required this.massage, required this.time});
  factory MassageModel.fromJson(Map<String,dynamic>json)=>MassageModel(
    time: json["time"],
    massage: json["massage"],
    senderId: json["senderId"],
  );
  Map<String,dynamic>toMap()=>{
    'time':time,
    'massage':massage,
    'senderId':senderId,
  };
}