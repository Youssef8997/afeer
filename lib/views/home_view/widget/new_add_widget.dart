import 'package:afeer/models/lecture_model.dart';
import 'package:afeer/utls/extension.dart';
import 'package:afeer/utls/manger/font_manger.dart';
import 'package:afeer/utls/widget/base_widget.dart';
import 'package:afeer/views/lecture_views/screens/doctor_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../utls/manger/color_manger.dart';

class NewAddWidget extends StatefulWidget {
  final LectureModel lecture;
  final String image;
  final String name;

  const NewAddWidget({
    super.key,
    required this.lecture,
    required this.image,
    required this.name,
  });

  @override
  State<NewAddWidget> createState() => _NewAddWidgetState();
}

class _NewAddWidgetState extends State<NewAddWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (context.appCuibt.user?.subscription != null) {
          if (context.appCuibt.user?.subscription!.isASingleSubject == true) {
            if (context.appCuibt.user?.subscription!.singleSubject!
                    .contains(widget.name) ==
                true) {
              context.appCuibt
                  .getSubjectDoctor(
                    subjectName: widget.name,
                  )
                  .then((value) => navigatorWid(
                      page: DoctorScreen(
                        subjectName: widget.name,
                        imagePath: widget.image,
                        time: "",
                        info: "",
                      ),
                      context: context,
                      returnPage: true));
            } else {
              final snackBar = SnackBar(
                backgroundColor: Colors.red,
                content: Text('انت غير مشترك برجاء التواصل مع خدمه العملاء',
                    style: FontsManger.largeFont(context)
                        ?.copyWith(color: ColorsManger.white)),
                showCloseIcon: true,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          } else {
            context.appCuibt
                .getSubjectDoctor(
                  subjectName: widget.name,
                )
                .then((value) => navigatorWid(
                    page: DoctorScreen(
                      subjectName: widget.name,
                      imagePath: widget.image,
                      time: "",
                      info: "",
                    ),
                    context: context,
                    returnPage: true));
          }
        } else {
          final snackBar = SnackBar(
            backgroundColor: Colors.red,
            content: Text('انت غير مشترك برجاء التواصل مع خدمه العملاء',
                style: FontsManger.largeFont(context)
                    ?.copyWith(color: ColorsManger.white)),
            showCloseIcon: true,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
/*        context.appCuibt
            .getSubjectDoctor(
              subjectName: widget.name,
            )
            .then((value) => navigatorWid(
                page: DoctorScreen(
                  subjectName: widget.name,
                  imagePath: widget.image,
                  time: "",
                  info: "",
                ),
                context: context,
                returnPage: true));*/
      },
      child: Container(
        height: 95,
        width: 132,
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
            color: const Color(0xffECECEC).withOpacity(.6),
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.16),
                spreadRadius: 1,
                offset: const Offset(0, 1),
                blurRadius: 2,
              )
            ]),
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 8),
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: widget.image,
              width: 112,
              height: 46,
              fit: BoxFit.fill,
              cacheKey: widget.image,
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              widget.name,
              style: FontsManger.largeFont(context)
                  ?.copyWith(color: const Color(0xff242126), fontSize: 11),
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              widget.lecture.name,
              style: FontsManger.mediumFont(context)?.copyWith(
                  color: const Color(0xff242126).withOpacity(.65), fontSize: 8),
            ),
          ],
        ),
      ),
    );
  }
}
