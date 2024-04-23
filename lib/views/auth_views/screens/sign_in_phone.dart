import 'dart:io';

import 'package:afeer/cuibt/app_cuibt.dart';
import 'package:afeer/cuibt/app_state.dart';
import 'package:afeer/utls/extension.dart';
import 'package:afeer/utls/widget/base_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//import 'package:flutter_facebook_keyhash/flutter_facebook_keyhash.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utls/manger/color_manger.dart';
import '../../../utls/manger/font_manger.dart';
import '../../../utls/widget/text_form.dart';
import 'forget_password.dart';

class SignInPhone extends StatefulWidget {
  const SignInPhone({super.key});

  @override
  State<SignInPhone> createState() => _SignInPhoneState();
}

class _SignInPhoneState extends State<SignInPhone> {
  late TextEditingController phone;
  late TextEditingController pass;
  bool isObscure = true;
  bool rememberMe = false;

/*

  void printKeyHash() async {
    String? key = await FlutterFacebookKeyhash.getFaceBookKeyHash ??
        'Unknown platform version';
    print("$key??" "");
  }
*/

  @override
  void initState() {
    phone = TextEditingController();
    pass = TextEditingController();
    //  printKeyHash();
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
            "دخول",
            style: FontsManger.largeFont(context)
                ?.copyWith(fontSize: 24, color: const Color(0xff212621)),
          ),
          const SizedBox(
            height: 22,
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
            height: 20,
          ),
          TextFormWidget(
            isObscure: isObscure,
            label: 'كلمة السر',
            suffix: InkWell(
                onTap: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
                child: Icon(
                  isObscure ? Icons.visibility : Icons.visibility_off,
                  color: ColorsManger.text3.withOpacity(.60),
                )),
            prefixActive: SvgPicture.asset(
              "assets/image/Body.svg",
              fit: BoxFit.none,
              color: ColorsManger.text3.withOpacity(.60),
            ),
            controller: pass,
          ),
          const SizedBox(
            height: 22,
          ),
          Row(
            children: [
              Expanded(
                child: CheckboxListTile.adaptive(
                  controlAffinity: ListTileControlAffinity.leading,
                  checkboxShape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  checkColor: Colors.white,
                  fillColor: rememberMe
                      ? MaterialStatePropertyAll(ColorsManger.pColor)
                      : null,
                  side: BorderSide(
                      color: const Color(0xff000000).withOpacity(.2)),
                  value: rememberMe,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        rememberMe = value;
                      });
                    }
                  },
                  title: Text("البقاء على تسجيل الدخول",
                      style: FontsManger.mediumFont(context)?.copyWith(
                          color: ColorsManger.text2.withOpacity(.5),
                          fontSize: 12)),
                ),
              ),
              InkWell(
                onTap: () {
                  navigatorWid(
                      page: ForgetPassword(),
                      context: context,
                      returnPage: true);
                },
                child: Text("نسيت كلمة المرور",
                    style: FontsManger.mediumFont(context)
                        ?.copyWith(color: ColorsManger.pColor, fontSize: 12)),
              ),
            ],
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
                  context.appCuibt.signEmailPassword(
                      context: context, pass: pass.text, email: phone.text);
                },
                child: context.appCuibt.isLoading
                    ? CircularProgressIndicator(
                        color: ColorsManger.pColor,
                      )
                    : Text(
                        "دخول",
                        style: FontsManger.mediumFont(context)?.copyWith(
                            fontSize: 16, color: ColorsManger.pColor),
                      ));
          }),
          const SizedBox(
            height: 28,
          ),
          if (Platform.isIOS && context.appCuibt.home.applePay)
            Row(
              children: [
                Expanded(
                  child: Container(
                    color: const Color(0xff707070).withOpacity(0.17),
                    height: 1,
                    width: context.width * .4,
                    margin: const EdgeInsets.only(left: 10),
                  ),
                ),
                Text(
                  "تسجيل الدخول باستخدام",
                  style: FontsManger.mediumFont(context)
                      ?.copyWith(color: ColorsManger.text3.withOpacity(0.6)),
                ),
                Expanded(
                  child: Container(
                    color: const Color(0xff707070).withOpacity(0.17),
                    height: 1,
                    width: context.width * .4,
                    margin: const EdgeInsets.only(right: 10),
                  ),
                ),
              ],
            ),
          if (Platform.isAndroid)
            const SizedBox(
              height: 28,
            ),
          if (Platform.isAndroid)
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      style: Theme.of(context)
                          .elevatedButtonTheme
                          .style
                          ?.copyWith(
                              backgroundColor: const MaterialStatePropertyAll(
                                  Color(0xff039BE5)),
                              side: MaterialStatePropertyAll(
                                  BorderSide(
                                      color: ColorsManger.pColor, width: 1)),
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              foregroundColor: MaterialStatePropertyAll(
                                  ColorsManger.pColor)),
                      onPressed: () {
                        context.appCuibt.signInWithFacebook(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.facebook_outlined,
                              color: Colors.white),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Facebook",
                            style: FontsManger.mediumFont(context)?.copyWith(
                                fontSize: 16, color: ColorsManger.white),
                          ),
                        ],
                      )),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: ElevatedButton(
                      style: Theme.of(context)
                          .elevatedButtonTheme
                          .style
                          ?.copyWith(
                            backgroundColor:
                                const MaterialStatePropertyAll(Colors.white),
                            side: const MaterialStatePropertyAll(
                                BorderSide(color: Color(0xff707070), width: 1)),
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                      onPressed: () {
                        context.appCuibt.signInWithGoogle(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset("assets/image/google.svg",
                              fit: BoxFit.none),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Google",
                            style: FontsManger.mediumFont(context)?.copyWith(
                                fontSize: 16, color: ColorsManger.text3),
                          ),
                        ],
                      )),
                ),
              ],
            )
        ],
      ),
    );
  }
}
