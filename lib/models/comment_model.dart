import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel{
  final String idUser;
  final String idComment;
  final String comment;
  final Timestamp time;

  CommentModel({required this.idUser, required this.idComment, required this.comment, required this.time});
  factory CommentModel.fromJson(Map<String,dynamic>json)=>CommentModel(
    time: json["time"],
    idComment: json["idComment"],
    comment: json["comment"],
    idUser: json["idUser"],
  );
  Map<String,dynamic>map()=>{
    "time":time,
    "idComment":idComment,
    "comment":comment,
    "idUser":idUser,
  };
}