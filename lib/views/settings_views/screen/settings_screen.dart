import 'package:afeer/pdf_view.dart';
import 'package:afeer/utls/extension.dart';
import 'package:afeer/utls/manger/color_manger.dart';
import 'package:afeer/utls/manger/font_manger.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../data/local_data.dart';
import '../../../utls/manger/assets_manger.dart';
import '../../../utls/widget/base_widget.dart';
import '../../auth_views/screens/auth_home_screen.dart';
import '../../chat_view/screens/chat_screen.dart';
import '../../news_view/screen/news_screen.dart';

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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              "مرحبًا يا ${context.appCuibt.user!.name}",
              style: FontsManger.largeFont(context)
                  ?.copyWith(color: const Color(0xff212621), fontSize: 24),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          CachedNetworkImage(
            height: 215,
            width: 215,
            fit: BoxFit.contain,
            imageUrl: context.appCuibt.user?.image ?? "",
            imageBuilder: (context, i) => Container(
              height: 215,
              width: 215,
              decoration: BoxDecoration(
                  image: DecorationImage(image: i, fit: BoxFit.fill),
                  shape: BoxShape.circle,
                  border: Border.all(color: ColorsManger.newColor, width: 2)),
            ),
            errorWidget: (context, i, _) => Container(
              height: 135,
              width: 135,
              decoration: BoxDecoration(
                  image: const DecorationImage(
                      image: NetworkImage(
                          "https://cdn-icons-png.flaticon.com/512/3135/3135715.png"),
                      fit: BoxFit.contain),
                  shape: BoxShape.circle,
                  border: Border.all(color: ColorsManger.newColor, width: 2)),
            ),
          ),
          const SizedBox(
            height: 21,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
                style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                    backgroundColor:
                        const MaterialStatePropertyAll(Colors.white),
                    side: const MaterialStatePropertyAll(
                        BorderSide(color: ColorsManger.newColor, width: 1)),
                    shape: const MaterialStatePropertyAll(StadiumBorder()),
                    foregroundColor:
                        MaterialStatePropertyAll(ColorsManger.pColor)),
                onPressed: () => context.appCuibt.isVisitor
                    ? navigatorWid(
                        page: const AuthHomeScreen(),
                        context: context,
                        returnPage: false)
                    : navigatorWid(
                        page: const EditUser(),
                        returnPage: true,
                        context: context),
                child: Text(
                  "تعديل البيانات الشخصية",
                  style: FontsManger.mediumFont(context)
                      ?.copyWith(fontSize: 16, color: ColorsManger.newColor),
                )),
          ),
          ListTile(
            onTap: () {
              showModalBottomSheet(
                  enableDrag: true,
                  isDismissible: true,
                  isScrollControlled: true,
                  constraints: BoxConstraints(
                      minHeight: context.height * .5,
                      maxHeight: context.height * .5),
                  context: context,
                  builder: (context) {
                    return Container(
                      height: context.height,
                      width: context.width,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(36))),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 22, vertical: 10),
                      child: StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          return ListView(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 150),
                                child: Container(
                                    width: 42,
                                    height: 5,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: ColorsManger.newColor)),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "للتواصل مع خدمه العملاء يمكنك التواصل من خلال الارقام التاليه",
                                style: FontsManger.mediumFont(context),
                              ),
                              ListTile(
                                onTap: () {
                                  launchUrlString(
                                      "https://wa.me/+201005778720?text=${Uri.parse("hello")}");
                                },
                                title: Text("01005778720",
                                    style: FontsManger.largeFont(context)
                                        ?.copyWith(
                                            fontSize: 13, color: Colors.black)),
                                trailing: Image.asset(
                                  "assets/image/whats.png",
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                              ListTile(
                                onTap: () {
                                  launchUrlString(
                                      "https://wa.me/+201208618618?text=${Uri.parse("hello")}");
                                },
                                title: Text("01208618618",
                                    style: FontsManger.largeFont(context)
                                        ?.copyWith(
                                            fontSize: 13, color: Colors.black)),
                                trailing: Image.asset(
                                  "assets/image/whats.png",
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                              ListTile(
                                onTap: () {
                                  launchUrlString(
                                      "https://wa.me/+201016844491?text=${Uri.parse("hello")}");
                                },
                                title: Text("01016844491",
                                    style: FontsManger.largeFont(context)
                                        ?.copyWith(
                                            fontSize: 13, color: Colors.black)),
                                trailing: Image.asset(
                                  "assets/image/whats.png",
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                              ListTile(
                                onTap: () {
                                  launchUrlString(
                                      "https://wa.me/+201097115884?text=${Uri.parse("hello")}");
                                },
                                title: Text("01097115884",
                                    style: FontsManger.largeFont(context)
                                        ?.copyWith(
                                            fontSize: 13, color: Colors.black)),
                                trailing: Image.asset(
                                  "assets/image/whats.png",
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  });
            },
            leading: SvgPicture.asset("assets/image/support.svg",
                width: 20, height: 20),
            title: Text("التواصل مع خدمة العملاء",
                style: FontsManger.largeFont(context)?.copyWith(fontSize: 14)),
          ),
          ListTile(
            onTap: () => context.appCuibt.isVisitor
                ? navigatorWid(
                    page: const AuthHomeScreen(),
                    context: context,
                    returnPage: false)
                : context.appCuibt.collage?.studySchedules != null
                    ? navigatorWid(
                        page: PdfView(
                            pdfLink: context.appCuibt.collage!.studySchedules),
                        returnPage: true,
                        context: context)
                    : MotionToast.error(
                            description:
                                const Text("يوجد مشكله ف عرض هذا الملف"))
                        .show(context),
            leading:
                Image.asset("assets/image/homework.png", width: 20, height: 20),
            title: Text("الجداول الدراسية",
                style: FontsManger.largeFont(context)?.copyWith(fontSize: 14)),
          ),
          ListTile(
            onTap: () => context.appCuibt.isVisitor
                ? navigatorWid(
                    page: const AuthHomeScreen(),
                    context: context,
                    returnPage: false)
                : context.appCuibt.collage?.courseDates != null
                    ? navigatorWid(
                        page: PdfView(
                            pdfLink: context.appCuibt.collage!.courseDates),
                        returnPage: true,
                        context: context)
                    : MotionToast.error(
                            description:
                                const Text("يوجد مشكله ف عرض هذا الملف"))
                        .show(context),
            leading: SvgPicture.asset("assets/image/calendar.svg"),
            title: Text("مواعيد الكورسات الحضورية",
                style: FontsManger.largeFont(context)?.copyWith(fontSize: 14)),
          ),
          ListTile(
            onTap: () async {
              await Share.share(
                "https://play.google.com/store/apps/details?id=afer.yoyo.com.afeer",
                subject:
                    "درّب نفسك وحل إمتحانات سابقة و حدد مستواك ، و دوّن ملاحظاتك على كل جزئية",
              );
            },
            leading: const Icon(
              Icons.share,
            ),
            title: Text("مشاركة التطبيق",
                style: FontsManger.largeFont(context)?.copyWith(fontSize: 14)),
          ),
          ListTile(
            onTap: () {
              launchUrl(Uri.parse(
                  "https://play.google.com/store/apps/details?id=afer.yoyo.com.afeer"));
            },
            leading: const Icon(
              Icons.star_border_purple500_outlined,
            ),
            title: Text("تقييم التطبيق",
                style: FontsManger.largeFont(context)?.copyWith(fontSize: 14)),
          ),
          ListTile(
            onTap: () {
              showDialog(
                  context: context,
                  useRootNavigator: false,
                  builder: (ctx) => Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      child: Container(
                        width: context.width * .3,
                        height: context.height * .3,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("تسجيل خروج",
                                style: FontsManger.largeFont(context)),
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                                "هل تريد تسجيل الخروج",
                                style: FontsManger.mediumFont(context)
                                    ?.copyWith(color: ColorsManger.text3)),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                      context.appCuibt.signOut(context);
                                      },
                                      style: Theme.of(context)
                                          .elevatedButtonTheme
                                          .style
                                          ?.copyWith(
                                          backgroundColor:
                                          const MaterialStatePropertyAll(
                                              Colors.red)),
                                      child: const Text("تاكيد"),
                                    )),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      style: Theme.of(context)
                                          .elevatedButtonTheme
                                          .style
                                          ?.copyWith(
                                          backgroundColor:
                                          const MaterialStatePropertyAll(
                                              Colors.green)),
                                      child: const Text("الغاء"),
                                    )),
                              ],
                            )
                          ],
                        ),
                      )));
            },
            leading: const Icon(
              Icons.logout,
            ),
            title: Text("تسجيل الخروج",
                style: FontsManger.largeFont(context)?.copyWith(fontSize: 14)),
          ),
          if (!context.appCuibt.isVisitor)
            ListTile(
              onTap: () {
                showDialog(
                    context: context,
                    useRootNavigator: false,
                    builder: (ctx) => Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                        child: Container(
                          width: context.width * .3,
                          height: context.height * .3,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("حذف الحساب",
                                  style: FontsManger.largeFont(context)),
                              const SizedBox(
                                height: 30,
                              ),
                              Text(
                                  "سوف يتم حذف حسابك وكل المعلومات والاشتراكات الخاصة بك",
                                  style: FontsManger.mediumFont(context)
                                      ?.copyWith(color: ColorsManger.text3)),
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: ElevatedButton(
                                    onPressed: () {
                                      FirebaseAuth.instance.currentUser!
                                          .delete();
                                      SharedPreference.removeDate(key: "token");
                                      context.appCuibt.user = null;
                                      navigatorWid(
                                          page: const AuthHomeScreen(),
                                          context: context,
                                          returnPage: false);
                                    },
                                    style: Theme.of(context)
                                        .elevatedButtonTheme
                                        .style
                                        ?.copyWith(
                                            backgroundColor:
                                                const MaterialStatePropertyAll(
                                                    Colors.red)),
                                    child: const Text("تاكيد"),
                                  )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: Theme.of(context)
                                        .elevatedButtonTheme
                                        .style
                                        ?.copyWith(
                                            backgroundColor:
                                                const MaterialStatePropertyAll(
                                                    Colors.green)),
                                    child: const Text("الغاء"),
                                  )),
                                ],
                              )
                            ],
                          ),
                        )));
              },
              leading: const Icon(
                Icons.delete,
              ),
              title: Text("حذف الحساب",
                  style:
                      FontsManger.largeFont(context)?.copyWith(fontSize: 14)),
            ),
        ],
      ),
    );
  }
}
