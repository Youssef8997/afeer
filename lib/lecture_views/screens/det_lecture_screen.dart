import 'package:afeer/home_view/home_layout.dart';
import 'package:afeer/lecture_views/screens/video_screen.dart';
import 'package:afeer/pdf_view.dart';
import 'package:afeer/utls/extension.dart';
import 'package:afeer/utls/manger/assets_manger.dart';
import 'package:afeer/utls/manger/color_manger.dart';
import 'package:afeer/utls/manger/font_manger.dart';
import 'package:afeer/utls/widget/base_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../chat_view/screens/chat_screen.dart';
import '../../models/lecture_model.dart';
import '../../news_view/screen/news_screen.dart';

class LectureDetScreen extends StatefulWidget {
  final String subjectName;
  final LectureModel lecture;

  const LectureDetScreen(
      {super.key, required this.subjectName, required this.lecture});

  @override
  State<LectureDetScreen> createState() => _LectureDetScreenState();
}

class _LectureDetScreenState extends State<LectureDetScreen> {
  bool isExpanded=false;
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
          Container(
            height: 80,
            decoration:
                BoxDecoration(color: const Color(0xffFCFCFE), boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(.16),
                  offset: const Offset(0, 3),
                  blurRadius: 6)
            ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 0, right: 20, top: 15, left: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                          child: const Icon(CupertinoIcons.house_alt),
                          onTap: () => navigatorWid(
                              page: const HomeScreen(),
                              returnPage: true,
                              context: context)),
                      const SizedBox(
                        width: 5,
                      ),
                      InkWell(
                          child: SvgPicture.asset(
                            "assets/image/Notification---3.svg",
                            width: 10,
                            height: 30,
                            fit: BoxFit.cover,
                          ),
                          onTap: () => navigatorWid(
                              page: const NewsScreen(),
                              returnPage: true,
                              context: context)),
                      const SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        child: SvgPicture.asset(
                          "assets/image/Message---4.svg",
                          width: 10,
                          height: 30,
                          fit: BoxFit.cover,
                        ),
                        onTap: () => navigatorWid(
                            page: const ChatScreen(),
                            context: context,
                            returnPage: true),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Image.asset(
                    AssetsManger.logo2,
                    width: 100,
                  ),
                )
              ],
            ),
          ),
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
                  child: Text(widget.subjectName,
                      style: FontsManger.largeFont(context)
                          ?.copyWith(color: ColorsManger.pColor)),
                ),
                const SizedBox(
                  height: 10,
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
            if(isExpanded==false)
            IconButton(onPressed: (){
              setState(() {
                isExpanded=true;
              });
            }, icon:Icon(Icons.arrow_drop_down) ),
                if(isExpanded==true)

Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Container(
      width: 4,
      height: 30,
      margin:  const EdgeInsets.only(right: 20),
      color: const Color(0xffE5E5E5),
    ),
    InkWell(
onTap: ()=>navigatorWid(page: PdfView(pdfLink: widget.lecture.pdfLinks[0]),returnPage: true,context: context),
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
                child: Image.asset("assets/image/open-book.png",
                    width: 10, height: 10, fit: BoxFit.cover)),
          ),
          const SizedBox(
            width: 10,
          ),
          Text("المادة العلمية",
              style: FontsManger.largeFont(context)
                  ?.copyWith(fontSize: 10)),
        ],
      ),
    ),
    Container(
      width: 4,
      height: 20,
      margin: const EdgeInsets.only(right: 20),
      color: const Color(0xffE5E5E5),
    ),
    InkWell(
      onTap: ()=>navigatorWid(page: VideoScreen(videoId: widget.lecture.videoLink,),context: context,returnPage: true),
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
            child: Image.asset("assets/image/video-camera.png",
                width: 30, height: 30, fit: BoxFit.cover),
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
    Container(
      width: 4,
      height: 20,
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
    Container(
      width: 4,
      height: 20,
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

      height: 20,
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
    ),
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
