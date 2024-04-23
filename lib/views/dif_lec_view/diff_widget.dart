import 'package:afeer/utls/extension.dart';
import 'package:afeer/utls/manger/color_manger.dart';
import 'package:afeer/utls/manger/font_manger.dart';
import 'package:afeer/utls/widget/base_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

import 'lect_screen_dif.dart';

class DiffSubjectWidget extends StatefulWidget {
  final String name;
  final String imagePath;
  final String collection;

  const DiffSubjectWidget(
      {super.key,
      required this.name,
      required this.collection,
      required this.imagePath});

  @override
  State<DiffSubjectWidget> createState() => _DiffSubjectWidgetState();
}

class _DiffSubjectWidgetState extends State<DiffSubjectWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (context.appCuibt.user?.subscription != null) {
          context.appCuibt
              .getLecturesM3dh(widget.name, widget.collection)
              .then((value) {
            navigatorWid(
                page: LectureDiffScreens(
                    subjectName: widget.name, collection: widget.collection),
                context: context,
                returnPage: true);
          });
        } else {
          MotionToast.error(
                  description: const Text("من فضلك قم بالاشتراك اولا!"))
              .show(context);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        width: context.width * .4,
        height: context.height * .35,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
                imageUrl: widget.imagePath,
                height: context.height * .25,
                width: context.width * .33,
                fit: BoxFit.fill,
                imageBuilder: (context, i) => Container(
                      height: context.height * .25,
                      width: context.width * .32,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: i,
                            fit: BoxFit.fill,
                          )),
                    ),
                errorWidget: (context, i, _) => SizedBox(
                      height: context.height * .16,
                      width: context.width * .6,
                      child: const Icon(Icons.school),
                    )),
            SizedBox(
              height: 7,
            ),
            Text(
              widget.name,
              style: FontsManger.largeFont(context)
                  ?.copyWith(fontSize: 13, color: Color(0xff242126)),
            ),
          ],
        ),
      ),
    );
  }
}
