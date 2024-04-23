import 'dart:io';

import 'package:afeer/utls/extension.dart';
import 'package:afeer/utls/manger/color_manger.dart';
import 'package:afeer/utls/manger/font_manger.dart';
import 'package:afeer/utls/widget/base_app_Bar.dart';
import 'package:afeer/utls/widget/base_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motion_toast/motion_toast.dart';

import 'det_lecture_screen.dart';

class LectureScreens extends StatefulWidget {
  final String subjectName;
  final String doctor;
  final bool? add;
  final String? year;
  final bool isRev;

  const LectureScreens(
      {super.key,
      required this.subjectName,
      required this.doctor,
      this.add,
      this.isRev = false,
      this.year});

  @override
  State<LectureScreens> createState() => _LectureScreensState();
}

class _LectureScreensState extends State<LectureScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: Color(0xffFCFCFE)),
      ),
      body: ListView(
        children: [
          const AppBarWidget(),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.subjectName,
                  style: FontsManger.largeFont(context)
                      ?.copyWith(color: ColorsManger.pColor),
                ),
                Row(
                  children: [
                    Expanded(
                        child: Divider(
                      color: ColorsManger.pColor,
                      thickness: 3,
                    )),
                    const Expanded(
                        flex: 4,
                        child: Divider(
                          color: Color(0xffDFDFDF),
                          thickness: 1,
                        )),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                if (context.appCuibt.lectureList.isNotEmpty)
                  SizedBox(
                      height: context.height * .8,
                      width: context.width,
                      child: ListView.separated(
                          itemBuilder: (context, i) => ListTile(
                                onTap: () {
                                  if (widget.isRev) {
                                    navigatorWid(
                                        page: LectureDetScreen(
                                            subjectName: widget.subjectName,
                                            lecture:
                                                context.appCuibt.lectureList[i],
                                            doctor: widget.doctor),
                                        context: context,
                                        returnPage: true);
                                  } else {
                                    if (context.appCuibt.user?.subscription !=
                                        null) {
                                      if (context.appCuibt.user?.subscription!
                                              .isASingleSubject ==
                                          true) {
                                        if (context.appCuibt.user?.subscription!
                                                .singleSubject!
                                                .contains(widget.subjectName) ==
                                            true) {
                                          navigatorWid(
                                              page: LectureDetScreen(
                                                  subjectName:
                                                      widget.subjectName,
                                                  lecture: context
                                                      .appCuibt.lectureList[i],
                                                  doctor: widget.doctor),
                                              context: context,
                                              returnPage: true);
                                        }
                                      } else {
                                        navigatorWid(
                                            page: LectureDetScreen(
                                                subjectName: widget.subjectName,
                                                lecture: context
                                                    .appCuibt.lectureList[i],
                                                doctor: widget.doctor),
                                            context: context,
                                            returnPage: true);
                                      }
                                    } else {
                                      if (i == 0) {
                                        navigatorWid(
                                            page: LectureDetScreen(
                                                subjectName: widget.subjectName,
                                                lecture: context
                                                    .appCuibt.lectureList[i],
                                                doctor: widget.doctor),
                                            context: context,
                                            returnPage: true);
                                      } else {
                                        MotionToast.error(
                                          description: Text(
                                            "برجاء التواصل مع الدعم الفني",
                                          ),
                                          title: Text(
                                            "انت لست مشترك!",
                                          ),
                                        ).show(context);
                                      }
                                    }
                                  }
                                },
                                trailing: Text.rich(TextSpan(children: [
                                  TextSpan(
                                      style: FontsManger.largeFont(context)
                                          ?.copyWith(
                                              color: ColorsManger.pColor),
                                      text: "المزيد"),
                                  WidgetSpan(
                                      child: Icon(
                                    Icons.arrow_forward_ios,
                                    color: ColorsManger.pColor,
                                    size: 18,
                                  ))
                                ])),
                                title: Text(
                                    context.appCuibt.lectureList[i].name,
                                    style: FontsManger.largeFont(context)),
                                subtitle: Text(
                                    context.appCuibt.lectureList[i].details,
                                    style: FontsManger.mediumFont(context)
                                        ?.copyWith(
                                            color: const Color(0xff1C1C1C)
                                                .withOpacity(0.4))),
                              ),
                          separatorBuilder: (context, i) => const Divider(
                                color: Color(0xffDFDFDF),
                                thickness: 1,
                              ),
                          itemCount: context.appCuibt.lectureList.length)),
                if (context.appCuibt.lectureList.isEmpty)
                  const Center(
                    child: Text("عفوا لا يوجد محاضرات حتي الان"),
                  )
              ],
            ),
          )
        ],
      ),
    );
  }

  bool apple() {
    if (context.appCuibt.home.applePay && Platform.isIOS) {
      return true;
    } else if (Platform.isAndroid) {
      return true;
    } else {
      return false;
    }
  }
}
