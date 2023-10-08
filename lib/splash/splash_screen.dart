// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:afeer/utls/extension.dart';
import 'package:afeer/utls/manger/assets_manger.dart';
import 'package:afeer/utls/manger/font_manger.dart';
import 'package:afeer/utls/widget/base_widget.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../data/local_data.dart';
import '../home_view/home_layout.dart';
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
    getData().then((value) {
      timer=Timer.periodic(const Duration(seconds: 2), (timer) async {
        if(await SharedPreference.getDate(key: "token")!=null){
          navigatorWid(page: const HomeScreen(),context: context,returnPage: false);
        }else {
          navigatorWid(page: const OnBoardingScreen(),context: context,returnPage: false);

        }
      });

}) ;   super.initState();
  }
  Future getData()async{
   await  context.appCuibt.getHomeData(context).then((value) async {

     if(await SharedPreference.getDate(key: "token")!=null){
     await  context.appCuibt.getInfo(await SharedPreference.getDate(key: "token"),context);
     }
   });

    return "hehe";
  }
  @override
  void dispose() {
    timer .cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
Center(child: SvgPicture.asset(AssetsManger.logo1,width: context.width,height: context.height*.13,)),
          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'استعد للتعليم',
                style: FontsManger.largeFont(context)?.copyWith(fontSize: 16,color: const Color(0xff707070)),
              ),
              const SizedBox(width: 2,),
              AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [

                  TypewriterAnimatedText(
                    '.....',
                    textStyle: FontsManger.largeFont(context)?.copyWith(fontSize: 16,color: const Color(0xff707070)),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
