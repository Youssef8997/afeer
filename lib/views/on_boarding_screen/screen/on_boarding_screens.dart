import 'package:afeer/utls/extension.dart';
import 'package:afeer/utls/manger/assets_manger.dart';
import 'package:afeer/utls/manger/color_manger.dart';
import 'package:afeer/utls/manger/font_manger.dart';
import 'package:afeer/utls/widget/base_widget.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import '../../auth_views/screens/auth_home_screen.dart';
import '../widget/on_boarding_widget.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController pageController;
int page=0;
  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        actions: [
          TextButton(
              onPressed: () {
                navigatorWid(page: const AuthHomeScreen(),returnPage: false,context: context);
              },
              child: Text(
                "تخطي",
                style: FontsManger.largeFont(context)
                    ?.copyWith(color: Colors.black, fontSize: 16),
              ))
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: context.height * .01,
          ),
          Image.asset(
            AssetsManger.logo2,
            width: context.width * .5,
            height: context.height * .07,
          ),
          const SizedBox(
            height: 70,
          ),
          Expanded(
            child: PageView(controller: pageController,
                onPageChanged: (value){
              setState(() {
                page=value;
              });
                },
                children: [
              OnBoardingWidget(
                imagePath: AssetsManger.onBoarding1,
                text:
                    "استمتع بجميع حلقات المقرر بأعلى تقنية وأجود شرح شامل حلول إمتحانات ومراجعات كافية لأحدث منهج",
              ),
              OnBoardingWidget(
                imagePath: AssetsManger.onBoarding2,
                text:
                    "مدرسون على أعلى مستوى معاك 24 ساعة للرد على جميع إستفساراتكم من أجلك",
              ),
              OnBoardingWidget(
                imagePath: AssetsManger.onBoarding3,
                text:
                    "درّب نفسك وحل إمتحانات سابقة و حدد مستواك ، و دوّن ملاحظاتك على كل جزئية",
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if(page!=2)
                TextButton(
                    onPressed: () {
                      pageController.animateToPage(page+1, duration: const Duration(milliseconds: 600), curve: Curves.fastLinearToSlowEaseIn);
                    },
                    child: Text(
                      "التالي",
                      style: FontsManger.largeFont(context),
                    )),
                if(page==2)
                  TextButton(
                      onPressed: () {
                        navigatorWid(page: const AuthHomeScreen(),returnPage: false,context: context);

                      },
                      child: Text(
                        "التسجيل",
                        style: FontsManger.largeFont(context),
                      )),

                  DotsIndicator(
                  dotsCount: 3,
                  position: page,
                  decorator: DotsDecorator(
                    color: const Color(0xff707070), // Inactive color
                    activeColor: ColorsManger.pColor,
                  ),
                ),
                TextButton(
                    onPressed: () {
                      pageController.animateToPage(page-1, duration: const Duration(milliseconds: 600), curve: Curves.fastLinearToSlowEaseIn);

                    },
                    child: Text(
                      "السابق",
                      style: FontsManger.largeFont(context),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
  @override
  void dispose() {
pageController.dispose();
super.dispose();
  }
}
