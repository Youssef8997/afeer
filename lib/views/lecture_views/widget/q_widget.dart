import 'package:afeer/models/q_model.dart';
import 'package:afeer/utls/extension.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uuid/uuid.dart';

import '../../../models/comment_model.dart';
import '../../../utls/manger/color_manger.dart';
import '../../../utls/manger/font_manger.dart';
import '../../../utls/widget/base_widget.dart';
import '../../../utls/widget/text_form.dart';
import '../../auth_views/screens/auth_home_screen.dart';
import '../../news_view/widget/comment_widget.dart';

class QWidget extends StatefulWidget {
  final QModel q;
  final String subjectName;
  final String lectureName;
  final String doctorName;
  const QWidget(
      {super.key,
      required this.q,
      required this.subjectName,
      required this.lectureName,
      required this.doctorName});

  @override
  State<QWidget> createState() => _QWidgetState();
}

class _QWidgetState extends State<QWidget> {
  TextEditingController commentController = TextEditingController();
  List<CommentModel> comments = [];
  @override
  void initState() {
    comments = widget.q.comments;
    super.initState();
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              FutureBuilder(
                  future: widget.q.user,
                  builder: (context, snap) {
                    if (snap.hasData) {
                      return Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            image: snap.data?.image != null
                                ? DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                      snap.data!.image,
                                    ))
                                : null,
                            shape: BoxShape.circle,
                            color: const Color(0xffEBE2EC)),
                      );
                    } else {
                      return const SizedBox();
                    }
                  }),
              const SizedBox(
                width: 10,
              ),
              FutureBuilder(
                  future: widget.q.user,
                  builder: (context, snap) {
                    if (snap.hasData) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(snap.data!.name,
                              style: FontsManger.largeFont(context)
                                  ?.copyWith(fontSize: 13)),
                          Text("الفرقة${snap.data!.team}",
                              style: FontsManger.largeFont(context)?.copyWith(
                                  fontSize: 9,
                                  color: const Color(0xff242126)
                                      .withOpacity(.65))),
                        ],
                      );
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("loading",
                              style: FontsManger.largeFont(context)
                                  ?.copyWith(fontSize: 13)),
                        ],
                      );
                    }
                  }),
              Spacer(),
              if (widget.q.userId == context.appCuibt.user!.token)
                InkWell(
                  child: Icon(Icons.delete, color: ColorsManger.newColor),
                  onTap: () {
                    context.appCuibt
                        .deleteQ(
                          subjectName: widget.subjectName,
                          doctorName: widget.doctorName,
                          lectureName: widget.lectureName,
                          qId: widget.q.id,
                        )
                        .then((value) => context.appCuibt.getQ(
                            subjectName: widget.subjectName,
                            doctorName: widget.doctorName,
                            lectureName: widget.lectureName,
                            context: context));
                  },
                )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.q.q,
            style: FontsManger.mediumFont(context)?.copyWith(
              color: const Color(0xff3E3E3E),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  context.appCuibt.addLikeQ(
                      q: widget.q,
                      context: context,
                      subjectName: widget.subjectName,
                      doctorName: widget.doctorName,
                      lectureName: widget.lectureName);
                },
                child: Container(
                  height: 40,
                  width: context.width * .35,
                  color: const Color(0xffF2F2F2).withOpacity(.79),
                  child: Icon(Icons.thumb_up_alt_rounded,
                      color: widget.q.likedId
                              .contains(context.appCuibt.user!.token)
                          ? ColorsManger.pColor
                          : const Color(0xff707070)),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      useRootNavigator: false,
                      builder: (ctx) => AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                          backgroundColor: Colors.white,
                          content: StatefulBuilder(builder:
                              (BuildContext context, StateSetter setState) {
                            return Container(
                              height: context.height * .9,
                              width: context.width,
                              color: Colors.white,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: ListView(
                                      children: [
                                        for (int i = 0;
                                            i < widget.q.comments.length;
                                            i++)
                                          CommentWidget(
                                              comment: widget.q.comments[i]),
                                      ],
                                    ),
                                  ),
                                  TextFormWidget(
                                    controller: commentController,
                                    label: "أكتب تعليقك",
                                    suffix: IconButton(
                                        onPressed: () {
                                          if (context.appCuibt.isVisitor ==
                                              true) {
                                            navigatorWid(
                                                page: const AuthHomeScreen(),
                                                context: context,
                                                returnPage: false);
                                          } else {
                                            if (commentController.text != "") {
                                              CommentModel comment =
                                                  CommentModel(
                                                      idUser: context
                                                          .appCuibt.user!.token,
                                                      idComment:
                                                          const Uuid().v4(),
                                                      comment: commentController
                                                          .text,
                                                      time: Timestamp.now());
                                              context.appCuibt.addCommentQ(
                                                  q: widget.q,
                                                  context: context,
                                                  comment: comment,
                                                  subjectName:
                                                      widget.subjectName,
                                                  doctorName: widget.doctorName,
                                                  lectureName:
                                                      widget.lectureName);
                                              setState(() {
                                                comments.add(comment);
                                              });
                                              commentController.clear();
                                            }
                                          }
                                        },
                                        icon: Icon(
                                          Icons.send,
                                          color: ColorsManger.pColor,
                                        )),
                                  )
                                ],
                              ),
                            );
                          })));
                },
                child: Container(
                  height: 40,
                  width: context.width * .35,
                  color: const Color(0xffF2F2F2).withOpacity(.79),
                  child: SvgPicture.asset("assets/image/chat.svg",
                      fit: BoxFit.none, color: const Color(0xff707070)),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
