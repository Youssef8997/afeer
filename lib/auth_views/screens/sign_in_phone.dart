import 'package:afeer/auth_views/screens/complete_screen.dart';
import 'package:afeer/auth_views/screens/verify_screen.dart';
import 'package:afeer/utls/extension.dart';
import 'package:afeer/utls/widget/base_widget.dart';
import 'package:flutter/material.dart';

import '../../cuibt/app_cuibt.dart';
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
  late TextEditingController pass;
  @override
  void initState() {
    phone=TextEditingController();
    pass=TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    phone.dispose();
    pass.dispose();
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
                "تسجيل الدخول بالبريد الالكتروني",
                style: FontsManger.largeFont(context)
                    ?.copyWith(fontSize: 24, color: Colors.black),
              )),
          const SizedBox(
            height: 10,
          ),
          // Center(
          //     child: Text(
          //       "يرجى كتابة رقم الهاتف بطريقة صحيحة",
          //       style: FontsManger.mediumFont(context)
          //           ?.copyWith(fontSize: 14, color: const Color(0xff1C1C1C)),
          //     )),
          const SizedBox(
            height: 40,
          ),
          TextFormWidget(label: 'أدخل البريد الالكتروني',suffix:const Icon(Icons.email),prefixActive:  InkWell(child: Icon(Icons.clear,color:  ColorsManger.text3.withOpacity(.20),)),controller: phone, ),
          const SizedBox(height: 20,),

          TextFormWidget(label: 'أدخل رقم الباسورد',suffix: const Icon(Icons.password),prefixActive:  InkWell(child: Icon(Icons.clear,color:  ColorsManger.text3.withOpacity(.20),)),controller: pass, ),
       const SizedBox(height: 20,),
       ElevatedButton(onPressed: (){
         context.appCuibt.signEmailPassword(context: context, pass: pass.text, email: phone.text);

       }, child:Text("تسجيل الدخول",style: FontsManger.mediumFont(context)?.copyWith(fontSize: 16,color: Colors.white),)),
          const SizedBox(height: 20,),
          TextButton(onPressed: (){
            navigatorWid(page: const CompleteInfoScreen(phone: '',),context: context,returnPage: true);
          }, child:const Text("تسجيل حساب جديد"))
        ],
      ),
    );
  }
}
