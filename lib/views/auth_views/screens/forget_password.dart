import 'package:afeer/cuibt/app_cuibt.dart';
import 'package:afeer/cuibt/app_state.dart';
import 'package:afeer/utls/extension.dart';
import 'package:afeer/utls/widget/base_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:motion_toast/motion_toast.dart';

import '../../../utls/manger/assets_manger.dart';
import '../../../utls/manger/color_manger.dart';
import '../../../utls/manger/font_manger.dart';
import '../../../utls/widget/text_form.dart';
import 'complete_screen.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  late TextEditingController phone;

  @override
  void initState() {
    phone = TextEditingController();
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
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: Color(0xff65256E),
              ))
        ],
        leading: const SizedBox(),
        leadingWidth: 100,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            "تغير كلمه المرور",
            style: FontsManger.largeFont(context)
                ?.copyWith(fontSize: 24, color: const Color(0xff212621)),
          ),
          const SizedBox(
            height: 22,
          ),
          Text(
            "يرجى كتابة البريد الالكتروني الخاص بكم والتوجه الي البريد الالكتروني الخاص بكم لتغير كلمه المرور عن طريق الرايط المرسل اليكم",
            style: FontsManger.mediumFont(context)?.copyWith(
                fontSize: 14, color: const Color(0xff1C1C1C), height: 1.5),
          ),
          const SizedBox(
            height: 10,
          ),
          Image(
            image: AssetImage("assets/image/forget_icon.png"),
          ),
          TextFormWidget(
            label: 'البريد الإلكتروني',
            prefixActive: Icon(
              CupertinoIcons.mail_solid,
              size: 16,
              color: ColorsManger.text3.withOpacity(.60),
            ),
            controller: phone,
          ),
          const SizedBox(
            height: 35,
          ),
          BlocBuilder<AppCubit, AppState>(builder: (context, state) {
            return ElevatedButton(
                style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                    backgroundColor:
                        const MaterialStatePropertyAll(Colors.white),
                    side: MaterialStatePropertyAll(
                        BorderSide(color: ColorsManger.pColor, width: 1)),
                    shape: const MaterialStatePropertyAll(StadiumBorder()),
                    foregroundColor:
                        MaterialStatePropertyAll(ColorsManger.pColor)),
                onPressed: () {
                  FirebaseAuth.instance
                      .sendPasswordResetEmail(email: phone.text)
                      .then((value) {
                    MotionToast.success(
                      description: Text("تم ارسال الرايط بنجاح"),
                      onClose: () {
                        Navigator.pop(context);
                      },
                    ).show(context);
                  }).catchError((onError) {
                    MotionToast.error(
                      description: Text("هذا البريد غير مسجل لدينا"),
                      onClose: () {
                        Navigator.pop(context);
                      },
                    ).show(context);
                  });
                },
                child: context.appCuibt.isLoading
                    ? CircularProgressIndicator(
                        color: ColorsManger.pColor,
                      )
                    : Text(
                        "ارسال الرايط",
                        style: FontsManger.mediumFont(context)?.copyWith(
                            fontSize: 16, color: ColorsManger.pColor),
                      ));
          }),
        ],
      ),
    );
  }
}
