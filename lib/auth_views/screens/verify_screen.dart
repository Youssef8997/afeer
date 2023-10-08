import 'package:afeer/utls/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';

import '../../utls/manger/assets_manger.dart';
import '../../utls/manger/font_manger.dart';

class VerifyScreen extends StatefulWidget {
  final String phone;
  const VerifyScreen({super.key, required this.phone});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  late TextEditingController otp;
@override
  void initState() {
otp=TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
  super.dispose();


  otp.dispose();
  }
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
                "ستصلك رسالة بالكود",
                style: FontsManger.largeFont(context)
                    ?.copyWith(fontSize: 24, color: Colors.black),
              )),
          const SizedBox(
            height: 10,
          ),
          Center(
              child: Text(
                "أنتظر رسالة على رقم الهاتف الذي أدخلته",
                style: FontsManger.mediumFont(context)
                    ?.copyWith(fontSize: 14, color: const Color(0xff1C1C1C)),
              )),
          const SizedBox(
            height: 40,
          ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: context.width,
        height: 50,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 1,color: const Color(0xff707070))
        ),
            child: PinCodeFields(
              controller: otp,
fieldWidth: 20,
                length:6,
                obscureText: true,
                onComplete: (String value) {  },
      ),
          ),
          const SizedBox(height: 20,),
          
          ElevatedButton(onPressed: (){
context.appCuibt.signInWithPhone(context, otp.text, widget.phone);
          }, child:Text("إستمرار",style: FontsManger.mediumFont(context)?.copyWith(fontSize: 16,color: Colors.white),))
     , Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
TextButton(onPressed: (){Navigator.pop(context);}, child:Text("تغيير الرقم",style: FontsManger.mediumFont(context)?.copyWith(fontSize: 14,color: Colors.black),)),
TextButton(onPressed: (){
  context.appCuibt.verifyPhoneNumber(context: context, phone: widget.phone);
}, child:Text("إعادة إرسال الكود",style: FontsManger.mediumFont(context)?.copyWith(fontSize: 14,color: Colors.black),)),
        ],
      )
        ],
      ),
    );
  }
}
