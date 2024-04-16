import 'package:afeer/utls/extension.dart';
import 'package:afeer/utls/manger/color_manger.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:motion_toast/motion_toast.dart';

import '../../../cuibt/app_cuibt.dart';
import '../../../cuibt/app_state.dart';
import '../../../pdf_view.dart';
import '../../../utls/manger/font_manger.dart';

class ExamDWidget extends StatefulWidget {
  final String name;
  final String det;
  final String link;
  const ExamDWidget(
      {super.key, required this.name, required this.det, required this.link});

  @override
  State<ExamDWidget> createState() => _ExamDWidgetState();
}

class _ExamDWidgetState extends State<ExamDWidget> {
  double i = 0;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            useRootNavigator: false,
            useSafeArea: false,
            builder: (ctx) =>
                BlocBuilder<AppCubit, AppState>(builder: (context, state) {
                  return OrientationBuilder(
                    builder: (context, o) {
                      if (o == Orientation.landscape) {
                        context.appCuibt.change();
                      }
                      if (o != Orientation.landscape) {
                        context.appCuibt.change();
                      }
                      return Dialog(
                          insetPadding: EdgeInsets.zero,
                          elevation: 5,
                          backgroundColor: Colors.black.withOpacity(.2),
                          child: SizedBox(
                              width: context.width,
                              height: context.height,
                              child: PdfView(pdfLink: widget.link)));
                    },
                  );
                }));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        height: 56,
        width: context.width,
        decoration: const BoxDecoration(color: Color(0xffF2F2F2)),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xffEBE2EC)),
              child:
                  SvgPicture.asset("assets/image/exam.svg", fit: BoxFit.none),
            ),
            const SizedBox(
              width: 5,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.name,
                    style:
                        FontsManger.largeFont(context)?.copyWith(fontSize: 13)),
                Text(widget.det,
                    style: FontsManger.mediumFont(context)?.copyWith(
                        fontSize: 9,
                        color: const Color(0xff242126).withOpacity(.65))),
              ],
            ),
            const Spacer(),
            InkWell(
                onTap: () async {
                  MotionToast.info(
                          toastDuration: Duration(seconds: 5),
                          height: 100,
                          description: Text(
                              "(storage/emulated/0/Download/${widget.link.split("token").last.split("-").last}.pdf)سوف يتم تحميل هذا الملف في "))
                      .show(context);
                  Dio().download(widget.link,
                      "storage/emulated/0/Download/${widget.link.split("token").last.split("-").last}.pdf",
                      onReceiveProgress: (con, total) {
                    setState(() {
                      i = con / total;
                    });
                  }).then((value) {
                    showDialog(
                        context: context,
                        useRootNavigator: false,
                        useSafeArea: false,
                        builder: (ctx) => BlocBuilder<AppCubit, AppState>(
                                builder: (context, state) {
                              return OrientationBuilder(
                                builder: (context, o) {
                                  if (o == Orientation.landscape) {
                                    context.appCuibt.change();
                                  }
                                  if (o != Orientation.landscape) {
                                    context.appCuibt.change();
                                  }
                                  return Dialog(
                                      insetPadding: EdgeInsets.zero,
                                      elevation: 5,
                                      backgroundColor:
                                          Colors.black.withOpacity(.2),
                                      child: SizedBox(
                                          width: context.width,
                                          height: context.height,
                                          child:
                                              PdfView(pdfLink: widget.link)));
                                },
                              );
                            }));
                  });
                },
                child: i != 0 && i != 1
                    ? CircularProgressIndicator(
                        strokeWidth: 1,
                        value: i,
                        backgroundColor: Colors.white,
                        color: ColorsManger.newColor,
                      )
                    : const Icon(
                        Icons.download,
                        color: Colors.black,
                      ))
          ],
        ),
      ),
    );
  }
}
