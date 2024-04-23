import 'package:afeer/models/m3hd_model.dart';
import 'package:afeer/pdf_view.dart';
import 'package:afeer/utls/extension.dart';
import 'package:afeer/utls/manger/color_manger.dart';
import 'package:afeer/utls/manger/font_manger.dart';
import 'package:afeer/utls/widget/base_app_Bar.dart';
import 'package:afeer/utls/widget/base_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/lecture_model.dart';
import '../lecture_views/screens/alert_screen.dart';
import '../lecture_views/screens/video_screen.dart';

class LectureDetDiffScreen extends StatefulWidget {
  final String subjectName;

  final LectureModel lecture;
  final String collection;

  const LectureDetDiffScreen({
    super.key,
    required this.subjectName,
    required this.lecture,
    required this.collection,
  });

  @override
  State<LectureDetDiffScreen> createState() => _LectureDetDiffScreenState();
}

class _LectureDetDiffScreenState extends State<LectureDetDiffScreen> {
  bool isExpanded = false;
  bool isVideo = false;
  bool isPdf = false;
  void getData() {
    setState(() {
      if (context.appCuibt.user?.subscription?.isAllAvailable == true) {
        isVideo = true;
        isPdf = true;
      } else {
        if (context.appCuibt.user?.subscription?.notAvailable?.contains("v") ==
            true) {
          isVideo = false;
          isPdf = true;
        } else {
          isVideo = true;
          isPdf = false;
        }
      }
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

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
                Container(
                  height: 30,
                  width: context.width,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xffDFDFDF).withOpacity(.44),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Text(widget.lecture.name,
                      style: FontsManger.largeFont(context)
                          ?.copyWith(color: ColorsManger.pColor)),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () => navigatorWid(
                      page: AlertsScreens(
                        alerts: widget.lecture.alerts ?? "",
                      ),
                      context: context,
                      returnPage: true),
                  child: Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Color(0xffE5E5E5),
                          shape: BoxShape.circle,
                        ),
                        child: SizedBox(
                            width: 10,
                            height: 10,
                            child: Image.asset("assets/image/warning.png",
                                width: 10, height: 10, fit: BoxFit.cover)),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text("تنبيهات المدرج",
                          style: FontsManger.largeFont(context)
                              ?.copyWith(fontSize: 10)),
                    ],
                  ),
                ),
                if (isExpanded == false)
                  IconButton(
                      onPressed: () {
                        setState(() {
                          isExpanded = true;
                        });
                      },
                      icon: const Icon(Icons.arrow_drop_down)),
                if (isExpanded == true)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isPdf)
                        SizedBox(
                            height: context.height *
                                .1 *
                                (widget.lecture.pdfLinks != null
                                    ? widget.lecture.pdfLinks!.length
                                    : 0),
                            child: ListView.builder(
                              itemBuilder: (context, i) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 4,
                                    height: 15,
                                    margin: const EdgeInsets.only(right: 20),
                                    color: const Color(0xffE5E5E5),
                                  ),
                                  InkWell(
                                    onTap: () => navigatorWid(
                                        page: PdfView(
                                            pdfLink:
                                                widget.lecture.pdfLinks![i]),
                                        returnPage: true,
                                        context: context),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 50,
                                          width: 50,
                                          padding: const EdgeInsets.all(10),
                                          decoration: const BoxDecoration(
                                            color: Color(0xffE5E5E5),
                                            shape: BoxShape.circle,
                                          ),
                                          child: SizedBox(
                                              width: 10,
                                              height: 10,
                                              child: Image.asset(
                                                  "assets/image/open-book.png",
                                                  width: 10,
                                                  height: 10,
                                                  fit: BoxFit.cover)),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text("المادة العلمية",
                                            style:
                                                FontsManger.largeFont(context)
                                                    ?.copyWith(fontSize: 10)),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 4,
                                    height: 15,
                                    margin: const EdgeInsets.only(right: 20),
                                    color: const Color(0xffE5E5E5),
                                  ),
                                ],
                              ),
                              itemCount: widget.lecture.pdfLinks != null
                                  ? widget.lecture.pdfLinks!.length
                                  : 0,
                            )),
                      Container(
                        width: 4,
                        height: 15,
                        margin: const EdgeInsets.only(right: 20),
                        color: const Color(0xffE5E5E5),
                      ),
                      if (isVideo)
                        InkWell(
                          onTap: () => navigatorWid(
                              page: VideoScreen(
                                videoId: widget.lecture.videoLink![""],
                                subjectName: widget.subjectName,
                                lectureName: widget.lecture.name,
                                doctorName: widget.collection,
                              ),
                              context: context,
                              returnPage: true),
                          child: Row(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                padding: const EdgeInsets.all(10),
                                alignment: Alignment.bottomCenter,
                                decoration: const BoxDecoration(
                                  color: Color(0xffE5E5E5),
                                  shape: BoxShape.circle,
                                ),
                                child: Image.asset(
                                    "assets/image/video-camera.png",
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.cover),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text("الفيديو",
                                  style: FontsManger.largeFont(context)
                                      ?.copyWith(fontSize: 10)),
                            ],
                          ),
                        ),
/*
                      Container(
                        width: 4,
                        height: 15,
                        margin: const EdgeInsets.only(right: 20),

                        color: const Color(0xffE5E5E5),
                      ),
*/
                      /*   InkWell(
                        onTap: ()=>navigatorWid(page: ShowExamsScreen(subjectName: widget.subjectName,doctor: widget.doctor,lecture: widget.lecture),returnPage: true,context: context),
                        child: Row(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                color: Color(0xffE5E5E5),
                                shape: BoxShape.circle,
                              ),
                              child: SizedBox(
                                  width: 10,
                                  height: 10,
                                  child: Image.asset("assets/image/edit.png",
                                      width: 10, height: 10, fit: BoxFit.cover)),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text("تدريبات",
                                style: FontsManger.largeFont(context)
                                    ?.copyWith(fontSize: 10)),
                          ],
                        ),
                      ),
                      Container(
                        width: 4,
                        height: 15,
                        margin: const EdgeInsets.only(right: 20),

                        color: const Color(0xffE5E5E5),
                      ),
                      Row(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Color(0xffE5E5E5),
                              shape: BoxShape.circle,
                            ),
                            child: SizedBox(
                                width: 10,
                                height: 10,
                                child: Image.asset("assets/image/notebook.png",
                                    width: 10, height: 10, fit: BoxFit.cover)),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text("ملاحظاتك",
                              style: FontsManger.largeFont(context)
                                  ?.copyWith(fontSize: 10)),
                        ],
                      ),
                      Container(
                        width: 4,
                        margin: const EdgeInsets.only(right: 20),

                        height: 15,
                        color: const Color(0xffE5E5E5),
                      ),
                      Row(
                        children: [
                          Container(

                            height: 50,
                            width: 50,
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Color(0xffE5E5E5),
                              shape: BoxShape.circle,
                            ),
                            child: SizedBox(
                                width: 10,
                                height: 10,
                                child: Image.asset("assets/image/question-mark.png",
                                    width: 10, height: 10, fit: BoxFit.cover)),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text("إطرح سؤالك",
                              style: FontsManger.largeFont(context)
                                  ?.copyWith(fontSize: 10)),
                        ],
                      ),*/
                    ],
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}
