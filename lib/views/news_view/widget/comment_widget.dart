import 'package:afeer/models/comment_model.dart';
import 'package:afeer/models/user_model.dart';
import 'package:afeer/utls/extension.dart';
import 'package:afeer/utls/manger/font_manger.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CommentWidget extends StatefulWidget {
  final CommentModel comment;
  const CommentWidget({super.key, required this.comment});

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  UserModel? user;
  getData() async {
    user = await context.appCuibt.getInfoUser(widget.comment.idUser);
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            height: 60,
            width: 45,
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xff374AE0), width: 2)),
            child: CachedNetworkImage(
              fit: BoxFit.fill,
              height: 54,
              width: 40,
              imageUrl: user?.image ?? "",
              imageBuilder: (context, i) => Container(
                height: 54,
                width: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(image: i, fit: BoxFit.fill)),
              ),
              errorWidget: (context, i, _) => Container(
                height: 54,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.person),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
              width: context.width * .5,
              decoration: BoxDecoration(
                  color: const Color(0xffDFDFDF),
                  borderRadius: BorderRadius.circular(15)),
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      width: context.width * .5,
                      child: Text(
                        user?.name ?? "",
                        style: FontsManger.largeFont(context)?.copyWith(
                            fontSize: 12, color: const Color(0xff343434)),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      )),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.comment.comment,
                    style: FontsManger.largeFont(context)
                        ?.copyWith(fontSize: 13, color: Colors.black),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
