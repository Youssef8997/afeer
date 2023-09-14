import 'package:afeer/utls/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../news_view/screen/news_screen.dart';
import '../../settings_views/screen/settings_screen.dart';
import '../../utls/manger/assets_manger.dart';
import '../../utls/manger/font_manger.dart';
import '../../utls/widget/base_widget.dart';
import '../widget/chat_list_widget.dart';
import '../widget/tab_bar_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
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
                      bottom: 0, right: 15, top: 15, left: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(child: Image.asset("assets/image/Container.png",width: 20,height: 35,fit: BoxFit.cover,),onTap: ()=>navigatorWid(page: const SettingsScreen(),returnPage: true,context: context)),
                      const SizedBox(
                        width: 5,
                      ),
                      InkWell(child: SvgPicture.asset("assets/image/Notification---3.svg",width: 10,height: 30,fit: BoxFit.cover,),onTap: ()=>navigatorWid(page: const NewsScreen(),returnPage: true,context: context)),


                      const SizedBox(
                        width: 5,
                      ),
                      InkWell(
                          child: const Icon(
                            Icons.home_outlined,
                            size: 30,
                          ),
                          onTap: () => Navigator.pop(context)),
                    ],
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Image.asset(
                    AssetsManger.logo2,
                    width: 100,
                  ),
                )
              ],
            ),
          ),
 Padding(padding: const EdgeInsets.all(20),child: Column(
   crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    const Row(
      children: [
        TabBarWidget(name: "الأصدقاء",index: 1,),
        SizedBox(width: 20,),
        TabBarWidget(name: "المجموعات",index: 2,),
        SizedBox(width: 20,),

        TabBarWidget(name: "الدعم الفني",index: 3,),
      ],
    ),
    const Divider(
      color: Color(0xffE4E6EB),
    ),
    Container(
      height: 32,
      width: context.width ,
      alignment: Alignment.centerRight,
      decoration: BoxDecoration(
          color: const Color(0xffF0F2F5),
          borderRadius: BorderRadius.circular(20)),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("باستحدام الكود إبحث عن صديقك ",
              style: FontsManger.mediumFont(context)
                  ?.copyWith(
                  fontSize: 10,
                  color: const Color(0xff606770))),
          const Icon(Icons.search,size: 15,color:Color(0xff606770) ,)
        ],
      ),
    ),
    const SizedBox(height: 10,),



  ],
),)

        ],
      ),
    );
  }
}
