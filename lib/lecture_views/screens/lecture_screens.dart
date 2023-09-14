import 'package:afeer/home_view/home_layout.dart';
import 'package:afeer/settings_views/screen/settings_screen.dart';
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
import '../../news_view/screen/news_screen.dart';
import 'det_lecture_screen.dart';


class LectureScreens extends StatefulWidget {
  final String subjectName;
  const LectureScreens({super.key, required this.subjectName});

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
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.subjectName,style: FontsManger.largeFont(context)?.copyWith(color: ColorsManger.pColor),),
                Row(
                  children: [
                    Expanded(child: Divider(color: ColorsManger.pColor,thickness: 3,)),
                    const Expanded(
                        flex: 4,
                        child: Divider(color: Color(0xffDFDFDF),thickness: 1,)),
                  ],
                ),
const SizedBox(height: 10,),
                SizedBox(
                    height: context.height*.8,
                    width: context.width,
                    child: ListView.separated(itemBuilder: (context,i)=>ListTile(
                      onTap: ()=>navigatorWid(page: LectureDetScreen(subjectName: widget.subjectName,lecture:context.appCuibt.lectureList[i] ),context: context,returnPage: true),
                      trailing: Text.rich(TextSpan(
                        children: [
                          TextSpan(
                            style: FontsManger.largeFont(context)?.copyWith(color: ColorsManger.pColor),
                            text: "المزيد"
                          ),
                          WidgetSpan(child: Icon(Icons.arrow_forward_ios,color: ColorsManger.pColor,size: 18
                            ,))
                        ]
                      )),
                  title: Text(context.appCuibt.lectureList[i].name,style:FontsManger.largeFont(context) ),
                  subtitle: Text(context.appCuibt.lectureList[i].details,style:FontsManger.mediumFont(context)?.copyWith(color: const Color(0xff1C1C1C).withOpacity(0.4)) ),
                ), separatorBuilder: (context,i)=>const Divider(color: Color(0xffDFDFDF),thickness: 1,), itemCount: context.appCuibt.lectureList.length))
              ],
            ),
          )
        ],
      ),
    );
  }
}
