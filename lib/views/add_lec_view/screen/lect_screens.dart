import 'package:afeer/utls/extension.dart';
import 'package:afeer/utls/manger/color_manger.dart';
import 'package:afeer/utls/manger/font_manger.dart';
import 'package:afeer/utls/widget/base_app_Bar.dart';
import 'package:afeer/utls/widget/base_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'det_add_lec_screen.dart';

class LectureAddScreens extends StatefulWidget {
  final String subjectName;
  const LectureAddScreens({
    super.key,
    required this.subjectName,
  });

  @override
  State<LectureAddScreens> createState() => _LectureAddScreensState();
}

class _LectureAddScreensState extends State<LectureAddScreens> {
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
                if (context.appCuibt.lectureAdditionalList.isNotEmpty)
                  SizedBox(
                      height: context.height * .8,
                      width: context.width,
                      child: ListView.separated(
                          itemBuilder: (context, i) => ListTile(
                                // onTap: ()=>navigatorWid(page: LectureDetAddScreen(subjectName: widget.subjectName,lecture:context.appCuibt.lectureAdditionalList[i] ,doctorName: widget),context: context,returnPage: true),
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
                                    context
                                        .appCuibt.lectureAdditionalList[i].name,
                                    style: FontsManger.largeFont(context)),
                              ),
                          separatorBuilder: (context, i) => const Divider(
                                color: Color(0xffDFDFDF),
                                thickness: 1,
                              ),
                          itemCount:
                              context.appCuibt.lectureAdditionalList.length)),
                if (context.appCuibt.lectureAdditionalList.isEmpty)
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
}
