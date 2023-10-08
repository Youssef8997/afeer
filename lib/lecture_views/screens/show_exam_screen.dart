
import 'package:afeer/utls/extension.dart';
import 'package:afeer/utls/manger/color_manger.dart';
import 'package:afeer/utls/manger/font_manger.dart';
import 'package:flutter/material.dart';

import '../../../models/exam_model.dart';
import '../../../models/lecture_model.dart';
import '../../utls/widget/base_app_Bar.dart';
import '../widget/exam_widget.dart';

class ShowExamsScreen extends StatefulWidget {
  final String subjectName;
  final LectureModel lecture;


  final String doctor;

  const ShowExamsScreen(
      {super.key,
        required this.subjectName,
        required this.lecture,
        required this.doctor});

  @override
  State<ShowExamsScreen> createState() => _ShowExamsScreenState();
}

class _ShowExamsScreenState extends State<ShowExamsScreen> {
  List<ExamModel> exams = [];
  int page=0;
  void getData() async {
    exams = await context.appCuibt.getExamLecture(
      subjectName: widget.subjectName,
      doctor: widget.doctor,
      context: context,
      lecture: widget.lecture,
    );
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppBarWidget(),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("السؤال ${page+1} من ${exams.length}",style: FontsManger.largeFont(context)?.copyWith(fontSize: 16,color: ColorsManger.pColor)),
          ),
          Expanded(
              child: PageView(
                controller: context.appCuibt.pageController,
                children: List.generate(
                    exams.length,
                        (index) => ExamWidget(
                          exams: exams,
                      exam: exams[index],
                          length:  exams.length ,
                    )),
              )),


        ],
      ),
    );
  }
}
