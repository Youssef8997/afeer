import 'package:afeer/utls/extension.dart';
import 'package:afeer/utls/widget/base_widget.dart';
import 'package:flutter/material.dart';

import '../../../models/exam_model.dart';
import '../../../utls/manger/color_manger.dart';
import '../../../utls/manger/font_manger.dart';
import '../screens/exam_true.dart';

class ExamWidget extends StatefulWidget {
  final ExamModel exam;
  final List<ExamModel> exams;
  final int length;
  const ExamWidget(
      {super.key,
      required this.exam,
      required this.length,
      required this.exams});

  @override
  State<ExamWidget> createState() => _ExamWidgetState();
}

class _ExamWidgetState extends State<ExamWidget> {
  String answer = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width * .7,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: ColorsManger.scaffoldBackGround,
          boxShadow: const [
            BoxShadow(
                color: Colors.black38, offset: Offset(0, 0), blurRadius: 3)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.exam.title,
            style: FontsManger.blackFont(context)?.copyWith(fontSize: 12),
          ),
          const SizedBox(
            height: 10,
          ),
          RadioListTile.adaptive(
            value: widget.exam.answer[0],
            groupValue: answer,
            onChanged: (value) {
              setState(() {
                answer = widget.exam.answer[0];
                if (answer == widget.exam.answerText) {
                  context.appCuibt.correctAnswer =
                      context.appCuibt.correctAnswer + 1;
                }
                context.appCuibt.pageController.nextPage(
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.fastLinearToSlowEaseIn);
                if (context.appCuibt.pageController.page!.toInt() + 1 ==
                    widget.length) {
                  navigatorWid(
                      page: ExamAnswers(
                        exams: widget.exams,
                      ),
                      returnPage: false,
                      context: context);
                }
              });
            },
            title: Text(widget.exam.answer[0],
                style: FontsManger.largeFont(context)?.copyWith(
                    color: answer == widget.exam.answer[0] &&
                            widget.exam.answer[0] == widget.exam.answerText
                        ? Colors.green
                        : Colors.black)),
          ),
          RadioListTile.adaptive(
            value: widget.exam.answer[1],
            groupValue: answer,
            onChanged: (value) {
              setState(() {
                answer = widget.exam.answer[1];
                if (answer == widget.exam.answerText) {
                  context.appCuibt.correctAnswer =
                      context.appCuibt.correctAnswer + 1;
                }
                context.appCuibt.pageController.nextPage(
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.fastLinearToSlowEaseIn);
                if (context.appCuibt.pageController.page!.toInt() + 1 ==
                    widget.length) {
                  navigatorWid(
                      page: ExamAnswers(
                        exams: widget.exams,
                      ),
                      returnPage: false,
                      context: context);
                }
              });
            },
            title: Text(widget.exam.answer[1],
                style: FontsManger.largeFont(context)?.copyWith(
                    color: answer == widget.exam.answer[1] &&
                            widget.exam.answer[1] == widget.exam.answerText
                        ? Colors.green
                        : Colors.black)),
          ),
          RadioListTile.adaptive(
            value: widget.exam.answer[2],
            groupValue: answer,
            onChanged: (value) {
              setState(() {
                answer = widget.exam.answer[2];
                if (answer == widget.exam.answerText) {
                  context.appCuibt.correctAnswer =
                      context.appCuibt.correctAnswer + 1;
                }

                context.appCuibt.pageController.nextPage(
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.fastLinearToSlowEaseIn);
                if (context.appCuibt.pageController.page!.toInt() + 1 ==
                    widget.length) {
                  navigatorWid(
                      page: ExamAnswers(
                        exams: widget.exams,
                      ),
                      returnPage: false,
                      context: context);
                }
              });
            },
            title: Text(widget.exam.answer[2],
                style: FontsManger.largeFont(context)?.copyWith(
                    color: answer == widget.exam.answer[2] &&
                            widget.exam.answer[2] == widget.exam.answerText
                        ? Colors.green
                        : Colors.black)),
          ),
          RadioListTile.adaptive(
            value: widget.exam.answer[3],
            groupValue: answer,
            onChanged: (value) {
              setState(() {
                answer = widget.exam.answer[3];
                if (answer == widget.exam.answerText) {
                  context.appCuibt.correctAnswer =
                      context.appCuibt.correctAnswer + 1;
                }

                context.appCuibt.pageController.nextPage(
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.fastLinearToSlowEaseIn);
                if (context.appCuibt.pageController.page!.toInt() + 1 ==
                    widget.length) {
                  navigatorWid(
                      page: ExamAnswers(
                        exams: widget.exams,
                      ),
                      returnPage: false,
                      context: context);
                }
              });
            },
            title: Text(widget.exam.answer[3],
                style: FontsManger.largeFont(context)?.copyWith(
                    color: answer == widget.exam.answer[3] &&
                            widget.exam.answer[3] == widget.exam.answerText
                        ? Colors.green
                        : Colors.black)),
          ),
        ],
      ),
    );
  }
}
