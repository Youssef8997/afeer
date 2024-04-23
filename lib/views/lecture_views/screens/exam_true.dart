import 'package:afeer/utls/extension.dart';
import 'package:afeer/utls/manger/color_manger.dart';
import 'package:afeer/utls/manger/font_manger.dart';
import 'package:afeer/utls/widget/base_app_Bar.dart';
import 'package:afeer/utls/widget/base_widget.dart';
import 'package:flutter/material.dart';

import '../../../models/exam_model.dart';
import '../../home_view/home_layout.dart';

class ExamAnswers extends StatefulWidget {
  final List<ExamModel> exams;
  const ExamAnswers({super.key, required this.exams});

  @override
  State<ExamAnswers> createState() => _ExamAnswersState();
}

class _ExamAnswersState extends State<ExamAnswers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const AppBarWidget(),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                "النتيجة:",
                style: FontsManger.largeFont(context)
                    ?.copyWith(fontSize: 16, color: ColorsManger.pColor),
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                "${context.appCuibt.correctAnswer}/${1}",
                style: FontsManger.largeFont(context)
                    ?.copyWith(color: Colors.black, fontSize: 14),
              )
            ],
          ),
          Expanded(
            child: ListView.separated(
                padding: const EdgeInsets.all(20),
                itemBuilder: (context, i) => Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "س: ",
                              style: FontsManger.mediumFont(context)?.copyWith(
                                  fontSize: 12, color: ColorsManger.text3),
                            ),
                            Text(
                              widget.exams[i].title,
                              style: FontsManger.largeFont(context)?.copyWith(
                                  fontSize: 16, color: ColorsManger.pColor),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              "ج: ",
                              style: FontsManger.mediumFont(context)?.copyWith(
                                  fontSize: 12, color: ColorsManger.text3),
                            ),
                            Text(
                              widget.exams[i].answerText,
                              style: FontsManger.largeFont(context)?.copyWith(
                                  fontSize: 16, color: ColorsManger.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                separatorBuilder: (context, i) => const Divider(
                    color: Colors.black26, thickness: .5, height: 10),
                itemCount: widget.exams.length),
          ),
          ElevatedButton(
              onPressed: () => navigatorWid(
                  page: const HomeScreen(),
                  context: context,
                  returnPage: false),
              child: const Text("الرجوع")),
        ],
      ),
    );
  }
}
