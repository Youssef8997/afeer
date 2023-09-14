import 'package:afeer/utls/extension.dart';
import 'package:afeer/utls/widget/base_widget.dart';
import 'package:flutter/material.dart';

import '../../home_view/home_layout.dart';
import '../../utls/manger/assets_manger.dart';
import '../../utls/manger/font_manger.dart';

class EndSignUpScreen extends StatefulWidget {
  const EndSignUpScreen({super.key});

  @override
  State<EndSignUpScreen> createState() => _EndSignUpScreenState();
}

class _EndSignUpScreenState extends State<EndSignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: context.height * .2,
          ),
          Image.asset(
            AssetsManger.logo2,
            width: context.width * .5,
            height: context.height * .07,
          ),
          SizedBox(
            height: context.height * .15,
          ),
          SizedBox(
            width: context.width * .8,
            child: Text(
              "شكراً لإستخدامك منصة عافر التعليمية ، نحن سعداء للتعامل",
              style: FontsManger.blackFont(context)
                  ?.copyWith(fontSize: 24, color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
              child: Text(
            "أول خطوة لتفوّقك الدراسي",
            style: FontsManger.mediumFont(context)
                ?.copyWith(fontSize: 14, color: const Color(0xff1C1C1C)),
          )),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
              width: context.width * .3,
              child: ElevatedButton(
                  onPressed: () {
                    navigatorWid(page: const HomeScreen(),context: context,returnPage: false);
                  },
                  child: Text(
                    "هيا لنبدأ",
                    style: FontsManger.mediumFont(context)
                        ?.copyWith(fontSize: 16, color: Colors.white),
                  )))
        ],
      ),
    );
  }
}
