// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:afeer/utls/extension.dart';
import 'package:afeer/utls/manger/assets_manger.dart';
import 'package:afeer/utls/manger/font_manger.dart';
import 'package:afeer/utls/widget/base_widget.dart';
import 'package:afeer/views/auth_views/screens/auth_home_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:connection_notifier/connection_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../data/local_data.dart';
import '../home_layout/home_layout.dart';
import '../home_view/home_layout.dart';
import '../lecture_views/screens/offline_videos_screen.dart';
import '../on_boarding_screen/screen/on_boarding_screens.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer timer;
  @override
  void initState() {
    if( ConnectionNotifierTools.isConnected){
      getData().then((value) {
        timer = Timer.periodic(const Duration(seconds: 2), (timer) async {
          if (await SharedPreference.getDate(key: "token") != null) {
            navigatorWid(
                page: const HomeLayout(), context: context, returnPage: false);
          } else {
            navigatorWid(
                page: const AuthHomeScreen(),
                context: context,
                returnPage: false);
          }
        });
      });

    }else{timer = Timer.periodic(const Duration(seconds: 2), (timer) async {
      navigatorWid(page: OfflineVVideoScree(),context: context,returnPage: false);

    });
    }
    super.initState();
  }

  Future getData() async {
    await context.appCuibt.getHomeData(context).then((value) async {
      if (await SharedPreference.getDate(key: "token") != null) {
        await context.appCuibt
            .getInfo(await SharedPreference.getDate(key: "token"), context);
      }
    });

    return "hehe";
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.light,
              systemStatusBarContrastEnforced: false),
        ),
        body: Center(
          child: SvgPicture.asset(
            "assets/image/منصة عافر لوجو.svg",
            width: context.width * .6,
            height: context.height * .4,
            fit: BoxFit.fill,
          ),
        ));
  }
}
