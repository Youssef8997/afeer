import 'package:afeer/cuibt/app_cuibt.dart';
import 'package:afeer/cuibt/app_state.dart';
import 'package:afeer/models/user_model.dart';
import 'package:afeer/utls/extension.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../utls/manger/assets_manger.dart';
import '../../../utls/manger/color_manger.dart';
import '../../../utls/manger/font_manger.dart';
import '../../../utls/widget/text_form.dart';

class CompleteInfoScreen extends StatefulWidget {
  final String email;

  const CompleteInfoScreen({
    super.key,
    required this.email,
  });

  @override
  State<CompleteInfoScreen> createState() => _CompleteInfoScreenState();
}

class _CompleteInfoScreenState extends State<CompleteInfoScreen> {
  late TextEditingController name;
  late TextEditingController name2;
  late TextEditingController email;
  late TextEditingController pass;
  late TextEditingController confirmPass;
  late TextEditingController phone;
  final formKey = GlobalKey<FormState>();
  bool okay = false;

  int? team;
  String? type;
  String? field;
  String? types;
  String? eg;
  String? university;
  List teem = [
    "الفرقه الاولي",
    "الفرقه الثانيه",
    "الفرقه الثالثه",
    "الفرقه الرابعة"
  ];

  @override
  void initState() {
    //getData();
    name = TextEditingController();
    email = TextEditingController();
    pass = TextEditingController();
    confirmPass = TextEditingController();
    phone = TextEditingController();
    if (widget.email != "") {
      email.text = widget.email;
    }
    super.initState();
  }

  void getData() {
    setState(() {
      field = context.appCuibt.home.fiends[0];
      university = context.appCuibt.home.university[0];
    });
  }

  @override
  void dispose() {
    name.dispose();
    phone.dispose();
    email.dispose();
    pass.dispose();
    super.dispose();
  }

  bool firstOpacity = false;
  bool secondOpacity = true;

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
        body: ListView(padding: const EdgeInsets.all(20), children: [
          Text(
            "إنشاء حساب جديد",
            style: FontsManger.largeFont(context)
                ?.copyWith(color: const Color(0xff212621), fontSize: 24),
          ),
          const SizedBox(
            height: 5,
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 700),
            height: firstOpacity ? 0 : context.height,
            width: firstOpacity ? 0 : context.width,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 700),
              opacity: firstOpacity ? 0 : 1,
              child: Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      "من فضلك أدخل بيانات الدراسة",
                      style: FontsManger.mediumFont(context)?.copyWith(
                          color: const Color(0xff212121).withOpacity(.5),
                          fontSize: 12),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DropdownButtonFormField(
                    hint: const Text("إختر مؤهل الدراسة"),
                    decoration: InputDecoration(
                      hintText: "إختر مؤهل الدراسة",
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                              width: 1, color: Colors.transparent)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                              width: 1, color: Colors.transparent)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                              width: 1, color: Colors.transparent)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                              width: 1, color: Colors.transparent)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              width: 1, color: Colors.red.withOpacity(.4))),
                      filled: true,
                      fillColor: const Color(0xffEFEFEF),
                    ),
                    icon: Icon(Icons.arrow_drop_down_circle_outlined,
                        color: ColorsManger.text3.withOpacity(.30)),
                    items: [
                      DropdownMenuItem(
                        value: "Academic year",
                        child: Text("كلية",
                            style: FontsManger.mediumFont(context)),
                        onTap: () {
                          setState(() {
                            types = "كلية";
                          });
                        },
                      ),
                      DropdownMenuItem(
                        value: "m3hd",
                        child: Text("معهد",
                            style: FontsManger.mediumFont(context)),
                        onTap: () {
                          setState(() {
                            types = "معهد";
                          });
                        },
                      ),
                      DropdownMenuItem(
                        value: "diploma",
                        child: Text("دبلوم",
                            style: FontsManger.mediumFont(context)),
                        onTap: () {
                          setState(() {
                            types = "دبلوم";
                          });
                        },
                      ),
                    ],
                    value: type,
                    onChanged: (String? value) {
                      setState(() {
                        type = value!;
                      });
                    },
                  ),
                  if (type == "Academic year")
                    const SizedBox(
                      height: 10,
                    ),
                  if (type == "Academic year")
                    DropdownButtonFormField(
                      hint: const Text("إختر الكلية"),
                      decoration: InputDecoration(
                        isDense: true,
                        isCollapsed: false,
                        suffix: Icon(Icons.arrow_drop_down_circle_outlined,
                            color: ColorsManger.text3.withOpacity(.30)),
                        hintText: "إختر الكلية",
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                                width: 1, color: Colors.transparent)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                                width: 1, color: Colors.transparent)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                                width: 1, color: Colors.transparent)),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                                width: 1, color: Colors.transparent)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                width: 1, color: Colors.red.withOpacity(.4))),
                        filled: true,
                        fillColor: const Color(0xffEFEFEF),
                      ),
                      icon: const SizedBox(),
                      isDense: true,
                      items: List.generate(
                        context.appCuibt.home.fiends.length,
                        (index) => DropdownMenuItem(
                          value: context.appCuibt.home.fiends[index],
                          child: Text(context.appCuibt.home.fiends[index],
                              style: FontsManger.mediumFont(context)),
                        ),
                      ),
                      value: field,
                      onChanged: (value) {
                        setState(() {
                          field = value.toString();
                        });
                      },
                    ),
                  if (type == "Academic year")
                    const SizedBox(
                      height: 10,
                    ),
                  if (type == "Academic year")
                    DropdownButtonFormField(
                      padding: EdgeInsets.zero,
                      hint: const Text("إختر الجامعة"),
                      decoration: InputDecoration(
                        hintText: "إختر الجامعة",
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                                width: 1, color: Colors.transparent)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                                width: 1, color: Colors.transparent)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                                width: 1, color: Colors.transparent)),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                                width: 1, color: Colors.transparent)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                width: 1, color: Colors.red.withOpacity(.4))),
                        filled: true,
                        fillColor: const Color(0xffEFEFEF),
                      ),
                      icon: Icon(Icons.arrow_drop_down_circle_outlined,
                          color: ColorsManger.text3.withOpacity(.30)),
                      items: List.generate(
                        context.appCuibt.home.university.length,
                        (index) => DropdownMenuItem(
                          value: context.appCuibt.home.university[index],
                          child: Text(context.appCuibt.home.university[index],
                              style: FontsManger.mediumFont(context)
                                  ?.copyWith(fontSize: 13)),
                        ),
                      ),
                      value: university,
                      onChanged: (value) {
                        setState(() {
                          university = value.toString();
                        });
                      },
                    ),
                  if (type == "Academic year")
                    const SizedBox(
                      height: 10,
                    ),
                  if (type == "Academic year")
                    DropdownButtonFormField(
                      hint: const Text("إختر الفرقة"),
                      decoration: InputDecoration(
                        hintText: "إختر الفرقة",
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                                width: 1, color: Colors.transparent)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                                width: 1, color: Colors.transparent)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                                width: 1, color: Colors.transparent)),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                                width: 1, color: Colors.transparent)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                width: 1, color: Colors.red.withOpacity(.4))),
                        filled: true,
                        fillColor: const Color(0xffEFEFEF),
                      ),
                      icon: Icon(Icons.arrow_drop_down_circle_outlined,
                          color: ColorsManger.text3.withOpacity(.30)),
                      items: [
                        DropdownMenuItem(
                          value: 1,
                          child: Text("الفرقه الاولي",
                              style: FontsManger.mediumFont(context)),
                        ),
                        DropdownMenuItem(
                          value: 2,
                          child: Text("الفرقه الثانيه",
                              style: FontsManger.mediumFont(context)),
                        ),
                        DropdownMenuItem(
                          value: 3,
                          child: Text(" الفرقه الثالثه",
                              style: FontsManger.mediumFont(context)),
                        ),
                        DropdownMenuItem(
                          value: 4,
                          child: Text("الفرقه الرابعة",
                              style: FontsManger.mediumFont(context)),
                        ),
                      ],
                      value: team,
                      onChanged: (int? value) {
                        setState(() {
                          team = value!;
                        });
                      },
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      style: Theme.of(context)
                          .elevatedButtonTheme
                          .style
                          ?.copyWith(
                              backgroundColor:
                                  const MaterialStatePropertyAll(Colors.white),
                              side: MaterialStatePropertyAll(BorderSide(
                                  color: ColorsManger.pColor, width: 1)),
                              shape: const MaterialStatePropertyAll(
                                  StadiumBorder()),
                              foregroundColor: MaterialStatePropertyAll(
                                  ColorsManger.pColor)),
                      onPressed: () {
                        /*     int? team;
                        String? type;
                        String? field;
                        String? types;
                        String? eg;
                        String? university;*/
                        if (team != null &&
                            type != null &&
                            field != null &&
                            types != null &&
                            university != null) {
                          setState(() {
                            firstOpacity = true;
                            secondOpacity = false;
                          });
                        } else {
                          SnackBar snakBar = const SnackBar(
                            content: Text(
                                "عفوا لايمكنك الوصول للخطوة التاليه الا عند استكمال كل بياناتك"),
                            backgroundColor: Colors.red,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snakBar);
                        }
                      },
                      child: Text(
                        "التالي",
                        style: FontsManger.mediumFont(context)?.copyWith(
                            fontSize: 16, color: ColorsManger.pColor),
                      )),
                ],
              ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 700),
            height: !firstOpacity ? 0 : context.height,
            width: !firstOpacity ? 0 : context.width,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 600),
              opacity: secondOpacity ? 0 : 1,
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        "من فضلك أدخل بيانات الدخول",
                        style: FontsManger.mediumFont(context)?.copyWith(
                            color: const Color(0xff212121).withOpacity(.5),
                            fontSize: 12),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormWidget(
                      controller: name,
                      label: 'الإسم ثنائي (يفضل باللغة العربية)',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormWidget(
                      active: widget.email == "" ? true : false,
                      controller: phone,
                      label: 'رقم الهاتف',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormWidget(
                      controller: email,
                      label: 'البريد الالكتروني',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormWidget(
                      controller: pass,
                      label: 'كلمه المرور',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormWidget(
                      controller: confirmPass,
                      label: 'تاكيد كلمه المرور',
                      validator: (string) {
                        if (string != pass.text) {
                          return "لا يتطابق مع كلمه المرور";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        activeColor: ColorsManger.pColor,
                        checkboxShape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(
                              color: const Color(0xffE4E4E4).withOpacity(.5),
                              width: 1,
                            )),
                        side: const BorderSide(
                          color: Color(0xffE4E4E4),
                          width: 1,
                        ),
                        value: okay,
                        onChanged: (value) {
                          setState(() {
                            if (value != null) {
                              okay = value;
                            }
                          });
                        },
                        title: Text(
                          "أوافق على الشروط والأحكام وقوانين الخصوصية",
                          style: FontsManger.smallFont(context)?.copyWith(
                              fontSize: 12, color: ColorsManger.pColor),
                        )),
                    BlocBuilder<AppCubit, AppState>(builder: (context, state) {
                      return ElevatedButton(
                          style: Theme.of(context)
                              .elevatedButtonTheme
                              .style
                              ?.copyWith(
                                  backgroundColor:
                                      const MaterialStatePropertyAll(
                                          Colors.white),
                                  side: MaterialStatePropertyAll(BorderSide(
                                      color: ColorsManger.pColor,
                                      width: 1)),
                                  shape: const MaterialStatePropertyAll(
                                      StadiumBorder()),
                                  foregroundColor: MaterialStatePropertyAll(
                                      ColorsManger.pColor)),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              UserModel user = UserModel(
                                  name: name.text,
                                  image: "",
                                  phone: phone.text,
                                  team: team.toString(),
                                  typeStudy: type!,
                                  token: const Uuid().v4(),
                                  university: university!,
                                  eg: eg == "مصري" ? true : false,
                                  field: field!,
                                  tokenDevice: await FirebaseMessaging.instance
                                      .getToken(),
                                  email: email.text,
                                  pass: pass.text);
                              context.appCuibt.signupEmailPassword(
                                  user1: user,
                                  pass: pass.text,
                                  email: email.text,
                                  context: context);
                            }
                          },
                          child: context.appCuibt.isLoading
                              ? CircularProgressIndicator(
                                  color: ColorsManger.pColor,
                                )
                              : Text(
                                  "التالي",
                                  style: FontsManger.mediumFont(context)
                                      ?.copyWith(
                                          fontSize: 16,
                                          color: ColorsManger.pColor),
                                ));
                    }),
                  ],
                ),
              ),
            ),
          )
        ]));
  }
}
