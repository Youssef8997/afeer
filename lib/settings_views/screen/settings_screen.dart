import 'package:afeer/pdf_view.dart';
import 'package:afeer/utls/extension.dart';
import 'package:afeer/utls/manger/color_manger.dart';
import 'package:afeer/utls/manger/font_manger.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:share_plus/share_plus.dart';

import '../../auth_views/screens/auth_home_screen.dart';
import '../../chat_view/screens/chat_screen.dart';
import '../../news_view/screen/news_screen.dart';
import '../../utls/manger/assets_manger.dart';
import '../../utls/widget/base_widget.dart';
import 'edit_user.dart';

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
                      CupertinoIcons.house_alt,
                      size: 27,
                    ),
                    onTap: () => Navigator.pop(context)),
                const SizedBox(
                  width: 5,
                ),
                InkWell(child: SvgPicture.asset("assets/image/Notification---3.svg",width: 10,height: 30,fit: BoxFit.cover,),onTap: ()=>navigatorWid(page: const NewsScreen(),returnPage: true,context: context)),


                const SizedBox(
                  width: 5,
                ),
                InkWell(child: SvgPicture.asset("assets/image/Message---4.svg",width: 10,height: 30,fit: BoxFit.cover,),
                  onTap: () =>context.appCuibt.isVisitor?navigatorWid(
                      page: const AuthHomeScreen(),
                      context: context,
                      returnPage: true): navigatorWid(
                      page: const ChatScreen(),
                      context: context,
                      returnPage: true),                ),
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
      imageUrl: context.appCuibt.user?.image??"",

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
      errorWidget: (context,i,_)=>Container(
        height: 135,
        width: 135,
        decoration: BoxDecoration(
            image: const DecorationImage(
                image: NetworkImage("https://cdn-icons-png.flaticon.com/512/3135/3135715.png"),
                fit: BoxFit.contain
            ),
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xffE1E1E1),width: 6)
        ),
      ),
    ),
    const SizedBox(height: 5,),
    Center(child: Text( context.appCuibt.user?.name??"",style: FontsManger.largeFont(context)?.copyWith(color: ColorsManger.pColor),)),
    Center(child: Text(" الفرقه ${context.appCuibt.user?.team??0}",style: FontsManger.mediumFont(context)?.copyWith(color: ColorsManger.text3.withOpacity(.4)),)),
    Center(
      child: Container(
        height: 32,
        width: context.width * .9,
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
            color: const Color(0xffF0F2F5),
            borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(context.appCuibt.user?.token??"",
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
          child: InkWell(
              onTap: (){
                Clipboard.setData(ClipboardData(text: context.appCuibt.user?.token??""));
                MotionToast.success(description: const Text("تم النسخ بنجاح ")).show(context);
              },
              child: Text("أضغط لنسخ الكود",style: FontsManger.mediumFont(context)?.copyWith(color: ColorsManger.text3),))),
    ),
ListTile(
  onTap: ()=>context.appCuibt.isVisitor?          navigatorWid(page: const AuthHomeScreen(),context: context,returnPage: false)
    :navigatorWid(page: const EditUser(),returnPage: true,context: context),
  leading: SvgPicture.asset("assets/image/user-avatar.svg"),
  title: Text("تعديل البيانات الشخصية",style: FontsManger.largeFont(context)?.copyWith(fontSize: 14)),
),
ListTile(
  onTap:()=>context.appCuibt.isVisitor?          navigatorWid(page: const AuthHomeScreen(),context: context,returnPage: false)
      : context.appCuibt.collage?.studySchedules!=null?navigatorWid(page: PdfView(pdfLink: context.appCuibt.collage!.studySchedules),returnPage: true,context: context):MotionToast.error(description: const Text("يوجد مشكله ف عرض هذا الملف")).show(context) ,
  leading: Image.asset("assets/image/homework.png",width: 20,height: 20),
  title: Text("الجداول الدراسية",style: FontsManger.largeFont(context)?.copyWith(fontSize: 14)),
),
ListTile(
  onTap:()=>context.appCuibt.isVisitor?          navigatorWid(page: const AuthHomeScreen(),context: context,returnPage: false)
      :context.appCuibt.collage?.courseDates!=null?navigatorWid(page: PdfView(pdfLink: context.appCuibt.collage!.courseDates),returnPage: true,context: context) :MotionToast.error(description: const Text("يوجد مشكله ف عرض هذا الملف")).show(context),

  leading: SvgPicture.asset("assets/image/calendar.svg"),
  title: Text("مواعيد الكورسات الحضورية",style: FontsManger.largeFont(context)?.copyWith(fontSize: 14)),
),

ListTile(
  onTap: () async {
    await Share.share(
      "https://play.google.com/store/apps/details?id=afer.yoyo.com.afeer",
      subject: "درّب نفسك وحل إمتحانات سابقة و حدد مستواك ، و دوّن ملاحظاتك على كل جزئية",
    );

  },
  leading: const Icon(Icons.share,),
  title: Text("مشاركة التطبيق",style: FontsManger.largeFont(context)?.copyWith(fontSize: 14)),
),


    ListTile(
      onTap: ()=>context.appCuibt.isVisitor?          navigatorWid(page: const AuthHomeScreen(),context: context,returnPage: false)
          :context.appCuibt.signOut(context),
      leading:  const Icon(Icons.logout,),
      title: Text("تسجيل الخروج",style: FontsManger.largeFont(context)?.copyWith(fontSize: 14)),
    ),

  ],
),
    );
  }
}
