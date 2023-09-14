import 'package:afeer/auth_views/screens/verify_screen.dart';
import 'package:afeer/utls/extension.dart';
import 'package:afeer/utls/widget/base_widget.dart';
import 'package:flutter/material.dart';

import '../../utls/manger/assets_manger.dart';
import '../../utls/manger/color_manger.dart';
import '../../utls/manger/font_manger.dart';
import '../../utls/widget/text_form.dart';

class SignInPhone extends StatefulWidget {
  const SignInPhone({super.key});

  @override
  State<SignInPhone> createState() => _SignInPhoneState();
}

class _SignInPhoneState extends State<SignInPhone> {
  late TextEditingController phone;
  @override
  void initState() {
    phone=TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    phone.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
     leading:           TextButton(
         onPressed: () {
           Navigator.pop(context);
         },
         child: Text(
           "رجوع",
           style: FontsManger.largeFont(context)
               ?.copyWith(color: Colors.black, fontSize: 16),
         )),
        leadingWidth: 100,
      ),

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
                "تسجيل الدخول برقم الهاتف",
                style: FontsManger.largeFont(context)
                    ?.copyWith(fontSize: 24, color: Colors.black),
              )),
          const SizedBox(
            height: 10,
          ),
          Center(
              child: Text(
                "يرجى كتابة رقم الهاتف بطريقة صحيحة",
                style: FontsManger.mediumFont(context)
                    ?.copyWith(fontSize: 14, color: const Color(0xff1C1C1C)),
              )),
          const SizedBox(
            height: 40,
          ),
          TextFormWidget(label: 'أدخل رقم هاتفك',suffix:SizedBox(
            height: 50,
            width: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.keyboard_arrow_down,color: Color(0xff2A2AC0),size: 25,),
                Text( "+20",style: FontsManger.mediumFont(context)?.copyWith(fontSize: 16,color: const Color(0xff707070)))            ]



            ),
          ),prefixActive:  InkWell(child: Icon(Icons.clear,color:  ColorsManger.text3.withOpacity(.20),)),controller: phone, ),
       const SizedBox(height: 20,),
       ElevatedButton(onPressed: (){
         context.appCuibt.verifyPhoneNumber(context: context, phone: phone.text);

         navigatorWid(page:  VerifyScreen(phone:phone.text ),returnPage: true,context: context);
       }, child:Text("تسجيل الدخول",style: FontsManger.mediumFont(context)?.copyWith(fontSize: 16,color: Colors.white),))
        ],
      ),
    );
  }
}
