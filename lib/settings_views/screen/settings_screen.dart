import 'package:afeer/utls/extension.dart';
import 'package:afeer/utls/manger/color_manger.dart';
import 'package:afeer/utls/manger/font_manger.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../chat_view/screens/chat_screen.dart';
import '../../news_view/screen/news_screen.dart';
import '../../utls/manger/assets_manger.dart';
import '../../utls/widget/base_widget.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
                InkWell(
                    child: const Icon(
                      Icons.home_outlined,
                      size: 30,
                    ),
                    onTap: () => Navigator.pop(context)),
                const SizedBox(
                  width: 5,
                ),
                InkWell(child: SvgPicture.asset("assets/image/Notification---3.svg",width: 10,height: 30,fit: BoxFit.cover,),onTap: ()=>navigatorWid(page: const NewsScreen(),returnPage: true,context: context)),


                const SizedBox(
                  width: 5,
                ),
                InkWell(child: SvgPicture.asset("assets/image/Message---4.svg",width: 10,height: 30,fit: BoxFit.cover,),onTap: ()=>navigatorWid(page: const ChatScreen(),context: context,returnPage: true),),
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
    const SizedBox(height: 20,),
    CachedNetworkImage(
      height: 135,
      width: 135,
      fit: BoxFit.contain,
      imageUrl: "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
      imageBuilder:(context,i)=> Container(
        height: 135,
        width: 135,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: i,
            fit: BoxFit.contain
          ),
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xffE1E1E1),width: 6)
        ),
      ),
    ),
    const SizedBox(height: 5,),
    Center(child: Text("يوسف احمد السيد",style: FontsManger.largeFont(context)?.copyWith(color: ColorsManger.pColor),)),
    Center(child: Text("الفرقة الثانية",style: FontsManger.mediumFont(context)?.copyWith(color: ColorsManger.text3.withOpacity(.4)),)),
    Center(
      child: Container(
        height: 32,
        width: context.width * .9,
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
            color: const Color(0xffF0F2F5),
            borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text("XLC6sgj123rSAFLLLsddsfki487887NMMA sd",
            style: FontsManger.mediumFont(context)
                ?.copyWith(
                fontSize: 12,
                color: const Color(0xff606770))),
      ),
    ),
    Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Align(

       alignment: Alignment.centerLeft,
          child: Text("أضغط لنسخ الكود",style: FontsManger.mediumFont(context)?.copyWith(color: ColorsManger.text3),)),
    ),
ListTile(
  leading: SvgPicture.asset("assets/image/user-avatar.svg"),
  title: Text("تعديل البيانات الشخصية",style: FontsManger.largeFont(context)?.copyWith(fontSize: 14)),
),
ListTile(
  leading: Image.asset("assets/image/homework.png",width: 20,height: 20),
  title: Text("الجداول الدراسية",style: FontsManger.largeFont(context)?.copyWith(fontSize: 14)),
),
ListTile(
  leading: SvgPicture.asset("assets/image/calendar.svg"),
  title: Text("مواعيد الكورسات الحضورية",style: FontsManger.largeFont(context)?.copyWith(fontSize: 14)),
),
ListTile(
  leading: SvgPicture.asset("assets/image/group.svg"),
  title: Text("هيئة تدريس المنصة",style: FontsManger.largeFont(context)?.copyWith(fontSize: 14)),
),
ListTile(
  leading: SvgPicture.asset("assets/image/wallet.svg"),
  title: Text("الإشتراكات والعروض",style: FontsManger.largeFont(context)?.copyWith(fontSize: 14)),
),
ListTile(
  leading: const Icon(Icons.share,),
  title: Text("مشاركة التطبيق",style: FontsManger.largeFont(context)?.copyWith(fontSize: 14)),
),
    ListTile(
      leading: Image.asset("assets/image/arabic.png",height: 20,width: 20),
      title: Text("تغيير لغة التطبيق",style: FontsManger.largeFont(context)?.copyWith(fontSize: 14)),
    ),
    ListTile(
      leading: const Icon(Icons.support_agent_rounded,),
      title: Text("مشاركة التطبيق",style: FontsManger.largeFont(context)?.copyWith(fontSize: 14)),
    ),
    ListTile(
      leading: const Icon(Icons.star_border,),
      title: Text("تقييم التطبيق",style: FontsManger.largeFont(context)?.copyWith(fontSize: 14)),
    ),
    ListTile(
      leading:  const Icon(Icons.logout,),
      title: Text("تسجيل الخروج",style: FontsManger.largeFont(context)?.copyWith(fontSize: 14)),
    ),

  ],
),
    );
  }
}
