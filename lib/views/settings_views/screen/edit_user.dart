// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:afeer/cuibt/app_cuibt.dart';
import 'package:afeer/cuibt/app_state.dart';
import 'package:afeer/models/user_model.dart';
import 'package:afeer/utls/extension.dart';
import 'package:afeer/utls/widget/base_app_Bar.dart';
import 'package:afeer/utls/widget/base_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utls/manger/color_manger.dart';
import '../../../utls/manger/font_manger.dart';
import '../../../utls/widget/text_form.dart';

class EditUser extends StatefulWidget {
  const EditUser({super.key});

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  late TextEditingController name;
  late TextEditingController email;
  late TextEditingController phone;
  int team = 1;
  String type = "Academic year";
  String field = "";
  String types = "كلية";
  String eg = "مصري";
  String university = "";
  List teem = [
    "الفرقه الاولي",
    "الفرقه الثانيه",
    "الفرقه الثالثه",
    "الفرقه الرابعة"
  ];

  @override
  void initState() {
    name = TextEditingController(text: context.appCuibt.user?.name ?? "");
    email = TextEditingController();
    phone = TextEditingController(text: context.appCuibt.user?.phone ?? "");
    name.text = context.appCuibt.user?.name ?? "";
    email.text = context.appCuibt.user?.email ?? "";
    team = int.parse(context.appCuibt.user!.team);
    field = context.appCuibt.user!.field;
    types = context.appCuibt.user!.typeStudy;
    university = context.appCuibt.user!.university;
    super.initState();
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Expanded(
            child: ListView(padding: const EdgeInsets.all(20), children: [
              Text(
                "تعديل البيانات الشخصية",
                style: FontsManger.largeFont(context)
                    ?.copyWith(color: const Color(0xff212621), fontSize: 24),
              ),
              const SizedBox(
                height: 5,
              ),
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  "من فضلك أدخل بياناتك بعناية",
                  style: FontsManger.mediumFont(context)?.copyWith(
                      color: const Color(0xff212121).withOpacity(.5),
                      fontSize: 12),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              BlocBuilder<AppCubit, AppState>(builder: (context, state) {
                return Center(
                  child: Container(
                    height: 214,
                    width: 214,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xffF9F9F9),
                        border: Border.all(
                            color: const Color(0xff7189FF), width: 2),
                        image: context.appCuibt.file != null
                            ? DecorationImage(
                                image: FileImage(
                                    File(context.appCuibt.file!.path)),
                                fit: BoxFit.fill)
                            : null),
                  ),
                );
              }),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: InkWell(
                  onTap: () async {
                    context.appCuibt.pickerPhoto(context);
                    setState(() {});
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.camera_alt,
                        color: Color(0xff707070),
                        size: 36,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "إضافة صورة",
                        style: FontsManger.smallFont(context)?.copyWith(
                            fontSize: 15,
                            color: const Color(0xff212121).withOpacity(.5)),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              DropdownButtonFormField(
                hint: const Text("إختر مؤهل الدراسة"),
                decoration: InputDecoration(
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
                    child: Text("كلية", style: FontsManger.mediumFont(context)),
                    onTap: () {
                      setState(() {
                        types = "كلية";
                      });
                    },
                  ),
                  DropdownMenuItem(
                    value: "m3hd",
                    child: Text("معهد", style: FontsManger.mediumFont(context)),
                    onTap: () {
                      setState(() {
                        types = "معهد";
                      });
                    },
                  ),
                  DropdownMenuItem(
                    value: "diploma",
                    child:
                        Text("دبلوم", style: FontsManger.mediumFont(context)),
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
                  hint: const Text("إختر مؤهل الدراسة"),
                  decoration: InputDecoration(
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
                  hint: const Text("إختر مؤهل الدراسة"),
                  decoration: InputDecoration(
                    isDense: true,
                    isCollapsed: false,
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
                  isDense: true,
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
                  hint: const Text("إختر مؤهل الدراسة"),
                  decoration: InputDecoration(
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
                      child: Text("الفرقه الثالثه",
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
              TextFormWidget(
                controller: name,
                label: 'إسمك باللغة العربية',
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormWidget(
                controller: phone,
                label: 'رقم الهاتف',
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormWidget(
                active: false,
                controller: email,
                label: 'البريد الالكتروني',
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                      backgroundColor:
                          const MaterialStatePropertyAll(Colors.white),
                      side: MaterialStatePropertyAll(
                          BorderSide(color: ColorsManger.pColor, width: 1)),
                      shape: const MaterialStatePropertyAll(StadiumBorder()),
                      foregroundColor:
                          MaterialStatePropertyAll(ColorsManger.pColor)),
                  onPressed: () async {
                    showLoading(context);
                    UserModel user = UserModel(
                        name: name.text,
                        image: await context.appCuibt.uploadProfilePhoto(),
                        phone: phone.text,
                        team: team.toString(),
                        typeStudy: type,
                        token: context.appCuibt.user!.token,
                        university: university,
                        eg: eg == "مصري" ? true : false,
                        field: field,
                        pass: context.appCuibt.user!.pass,
                        subscription: context.appCuibt.user!.subscription,
                        addSubject: context.appCuibt.user!.addSubject,
                        subscriptionRev: context.appCuibt.user!.subscriptionRev,
                        tokenDevice: context.appCuibt.user!.tokenDevice,
                        email: context.appCuibt.user!.email);
                    context.appCuibt.editUser(user, context);
                  },
                  child: Text(
                    "إستمرار",
                    style: FontsManger.mediumFont(context)
                        ?.copyWith(fontSize: 16, color: ColorsManger.pColor),
                  ))
            ]),
          ),
        ],
      ),
    ));
  }
}
