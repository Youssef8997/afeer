import 'package:afeer/utls/extension.dart';
import 'package:afeer/utls/manger/assets_manger.dart';
import 'package:afeer/utls/manger/color_manger.dart';
import 'package:afeer/utls/manger/font_manger.dart';
import 'package:afeer/utls/widget/base_widget.dart';
import 'package:afeer/views/auth_views/screens/sign_in_phone.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../home_view/home_layout.dart';
import 'complete_screen.dart';

class AuthHomeScreen extends StatefulWidget {
  const AuthHomeScreen({super.key});

  @override
  State<AuthHomeScreen> createState() => _AuthHomeScreenState();
}

class _AuthHomeScreenState extends State<AuthHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          SizedBox(
            height: context.height * .3,
          ),
          Center(
            child: Text(
              "منصة عافر التعليمية",
              style: FontsManger.largeFont(context)?.copyWith(fontSize: 25),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              "مرحبًا بك في خطوتك الصحيحة لتفوقك",
              style: FontsManger.mediumFont(context)
                  ?.copyWith(fontSize: 16, color: const Color(0xff242126)),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          ElevatedButton(
            style: Theme.of(context).elevatedButtonTheme.style,
            onPressed: () {
              navigatorWid(
                  page: const SignInPhone(),
                  context: context,
                  returnPage: true);
            },
            child: Text(
              "تسجيل الدخول",
              style: FontsManger.mediumFont(context)
                  ?.copyWith(fontSize: 16, color: ColorsManger.white),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          ElevatedButton(
            style: Theme.of(context).elevatedButtonTheme.style,
            onPressed: () {
              navigatorWid(
                  page: const CompleteInfoScreen(
                    email: '',
                  ),
                  context: context,
                  returnPage: true);
            },
            child: Text(
              "إنشاء حساب جديد",
              style: FontsManger.mediumFont(context)
                  ?.copyWith(fontSize: 16, color: ColorsManger.white),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          ElevatedButton(
              onPressed: () {
                context.appCuibt.isVisitor = true;
                navigatorWid(
                    page: const HomeScreen(),
                    context: context,
                    returnPage: true);
              },
              child: Text(
                "دخول كضيف",
                style: FontsManger.mediumFont(context)
                    ?.copyWith(fontSize: 16, color: ColorsManger.white),
              )),
        ],
      ),
    );
  }
}
