import 'package:afeer/cuibt/app_cuibt.dart';
import 'package:afeer/cuibt/app_state.dart';
import 'package:afeer/utls/extension.dart';
import 'package:afeer/utls/manger/color_manger.dart';
import 'package:afeer/utls/manger/font_manger.dart';
import 'package:afeer/utls/widget/base_app_Bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utls/widget/base_widget.dart';
import 'lecture_screens.dart';

class DoctorScreen extends StatefulWidget {
  final String subjectName;
  final String? year;
  final bool? add;
  final bool isRev;

  const DoctorScreen(
      {super.key,
      required this.subjectName,
      this.add,
      this.year,
      this.isRev = false});

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AppCubit, AppState>(
        builder: (context, state) {
          return Column(
            children: [
              const AppBarWidget(),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      "اختر الدكتور !",
                      style: FontsManger.largeFont(context)
                          ?.copyWith(color: ColorsManger.pColor),
                    )),
              ),
              if (context.appCuibt.doctorList.isNotEmpty)
                Expanded(
                  child: ListView.separated(
                      padding: const EdgeInsets.all(10),
                      itemBuilder: (context, i) => ListTile(
                            leading: const SizedBox(
                              height: 30,
                              width: 30,
                              child: Icon(Icons.person),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios,
                                color: ColorsManger.pColor),
                            onTap: () {
                              if (widget.add == true) {
                                context.appCuibt
                                    .getAddLectures(
                                        doctor: context.appCuibt.doctorList[i],
                                        subjectName: widget.subjectName,
                                        year: widget.year)
                                    .then((value) => navigatorWid(
                                        page: LectureScreens(
                                          subjectName: widget.subjectName,
                                          doctor:
                                              context.appCuibt.doctorList[i],
                                          year: widget.year,
                                          add: widget.add,
                                        ),
                                        context: context,
                                        returnPage: true));
                              } else {
                                if (context.appCuibt.isVisitor) {
                                  context.appCuibt
                                      .getLecturesV(
                                          doctor:
                                              context.appCuibt.doctorList[i],
                                          subjectName: widget.subjectName)
                                      .then((value) => navigatorWid(
                                          page: LectureScreens(
                                              subjectName: widget.subjectName,
                                              doctor: context
                                                  .appCuibt.doctorList[i]),
                                          context: context,
                                          returnPage: true));
                                } else {
                                  print("i work");
                                  context.appCuibt
                                      .getLectures(
                                          doctor:
                                              context.appCuibt.doctorList[i],
                                          subjectName: widget.subjectName)
                                      .then((value) => navigatorWid(
                                          page: LectureScreens(
                                              subjectName: widget.subjectName,
                                              doctor: context
                                                  .appCuibt.doctorList[i],
                                              isRev: widget.isRev),
                                          context: context,
                                          returnPage: true));
                                }
                              }
                            },
                            title: Text(context.appCuibt.doctorList[i],
                                style: FontsManger.largeFont(context)
                                    ?.copyWith(color: ColorsManger.pColor)),
                          ),
                      separatorBuilder: (context, i) =>
                          const SizedBox(height: 10),
                      itemCount: context.appCuibt.doctorList.length),
                ),
              if (context.appCuibt.doctorList.isEmpty)
                const Center(
                    heightFactor: 5,
                    child: Text("عفوا لا يوجد حتي الان محاضرات مضافه"))
            ],
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
