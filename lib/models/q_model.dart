import 'package:afeer/models/comment_model.dart';
import 'package:afeer/models/user_model.dart';
import 'package:afeer/utls/extension.dart';
import 'package:flutter/cupertino.dart';

class QModel {
  final String userId;
  final String id;
  final int min;
  final Future<UserModel?>? user;
  final String q;
  final List likedId;
  final List<CommentModel> comments;

  QModel(
      {required this.userId,
      required this.user,
      required this.id,
      required this.q,
      required this.min,
      required this.likedId,
      required this.comments});
  factory QModel.fromJson(Map<String, dynamic> json, BuildContext context) =>
      QModel(
          q: json["q"],
          userId: json["userId"],
          id: json["id"],
          min: json["min"],
          user: context.appCuibt.getInfoById(json["userId"], context),
          likedId: json["likedId"],
          comments: List.generate(
              json["comments"] != null ? json["comments"].length : 0,
              (index) => CommentModel.fromJson(json["comments"][index])));
  Map<String, dynamic> toMap() => {
        "q": q,
        "userId": userId,
        "id": id,
        "min": min,
        "likedId": likedId,
        "comments": comments
      };
}
