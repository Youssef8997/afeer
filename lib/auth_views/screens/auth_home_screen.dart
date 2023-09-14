import 'package:afeer/auth_views/screens/sign_in_phone.dart';
import 'package:afeer/utls/extension.dart';
import 'package:afeer/utls/manger/assets_manger.dart';
import 'package:afeer/utls/manger/color_manger.dart';
import 'package:afeer/utls/manger/font_manger.dart';
import 'package:afeer/utls/widget/base_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
            height: context.height * .12,
          ),
          Image.asset(
            AssetsManger.logo2,
            width: context.width * .5,
            height: context.height * .07,
          ),
          SizedBox(
            height: context.height * .1,
          ),
          Center(
              child: Text(
            "مرحباً بك",
            style: FontsManger.largeFont(context)
                ?.copyWith(fontSize: 24, color: Colors.black),
          )),
          const SizedBox(
            height: 10,
          ),
          Center(
              child: Text(
            "أختر طريقة تسجيل دخولك",
            style: FontsManger.mediumFont(context)
                ?.copyWith(fontSize: 14, color: const Color(0xff1C1C1C)),
          )),
          const SizedBox(
            height: 40,
          ),
          ElevatedButton.icon(
            
            style: Theme.of(context).elevatedButtonTheme.style?.copyWith(backgroundColor: const MaterialStatePropertyAll(Color(0xff181461))),
              onPressed: () {context.appCuibt.signInWithGoogle(context);},
              icon: SvgPicture.asset(AssetsManger.googleIcon),
              label: Text("تسجيل الدخول باستخدام البريد الإلكتروني",style: FontsManger.mediumFont(context)?.copyWith(fontSize: 16,color: ColorsManger.white),)),
          const SizedBox(height: 10,),
          Center(child: Text("أو",style: FontsManger.mediumFont(context)?.copyWith(fontSize: 14,color: ColorsManger.text3),)),
          const SizedBox(height: 10,),
          ElevatedButton.icon(

              style: Theme.of(context).elevatedButtonTheme.style?.copyWith(backgroundColor: const MaterialStatePropertyAll(Color(0xff3A559F))),
              onPressed: () {},
              icon: SvgPicture.asset(AssetsManger.faceBookIcon),
              label: Text("تسجيل الدخول باستخدام الفيسبوك",style: FontsManger.mediumFont(context)?.copyWith(fontSize: 16,color: ColorsManger.white),)),
          const SizedBox(height: 10,),
          Center(child: Text("أو",style: FontsManger.mediumFont(context)?.copyWith(fontSize: 14,color: ColorsManger.text3),)),
          const SizedBox(height: 10,),
          ElevatedButton.icon(

              style: Theme.of(context).elevatedButtonTheme.style?.copyWith(backgroundColor: const MaterialStatePropertyAll(Color(0xff2AC052))),
              onPressed: () {
                navigatorWid(page: const SignInPhone(),context: context,returnPage: true);
              },
              icon: const Icon(Icons.phone,color: Colors.white),
              label: Text("تسجيل الدخول برقم الهاتف",style: FontsManger.mediumFont(context)?.copyWith(fontSize: 16,color: ColorsManger.white),)),

        ],
      ),
    );
  }
}
