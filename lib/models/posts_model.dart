import 'package:cloud_firestore/cloud_firestore.dart';

import 'comment_model.dart';

class PostsModel{
  final String postId;
  final String title;
  final String? linkPdf;
  final String? linkImage;
  final Timestamp? time;
  final List? likedId;
  final List<CommentModel>? comments;

  PostsModel(
      {required this.postId,
      required this.title,
      this.linkPdf,
      this.linkImage,
      this.time,
      this.likedId,
      this.comments});
  factory PostsModel.fromJson(Map<String,dynamic>json)=>PostsModel(
    title: json["title"],
    postId: json["postId"],
    linkPdf: json["linkPdf"],
    linkImage: json["linkImage"],
    likedId: json["likedId"],
    time: json["time"],
    comments: List<CommentModel>.generate(json['comments'].length, (index) =>CommentModel.fromJson (json['comments'][index]))
  );
  Map <String,dynamic>toMap()=>{
    "title":title,
    "postId":postId,
    "linkPdf":linkPdf,
    "linkImage":linkImage,
    "likedId":likedId,
    "time":time,
    "comments":[],
  };

}