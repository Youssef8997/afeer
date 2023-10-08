// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:afeer/cuibt/app_cuibt.dart';
import 'package:afeer/cuibt/app_state.dart';
import 'package:afeer/models/user_model.dart';
import 'package:afeer/utls/extension.dart';
import 'package:afeer/utls/widget/base_app_Bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utls/manger/color_manger.dart';
import '../../utls/manger/font_manger.dart';
import '../../utls/widget/text_form.dart';

class EditUser extends StatefulWidget {

  const EditUser({super.key});

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  late TextEditingController name;
  late TextEditingController email;
  late TextEditingController phone;
  int team=1;
  String type="Academic year";
  String field="";
  String types="كلية";
  String eg="مصري";
  String university="";
  List teem=[
    "الفرقه الاولي",
    "الفرقه الثانيه",
    "الفرقه الثالثه",
    "الفرقه الرابعة"
  ];

  @override
  void initState() {
    getData();
    name=TextEditingController(text: context.appCuibt.user?.name??"");
    email=TextEditingController();
    phone=TextEditingController(text: context.appCuibt.user?.phone??"");
    super.initState();
  }
  void getData(){
    setState(() {
      field=context.appCuibt.home.fiends[0];
      university=context.appCuibt.home.university[0];

    });

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
              const AppBarWidget(),
              Expanded(
                child: ListView(padding: const EdgeInsets.all(20), children: [

                  Center(
                      child: Text(
                        "أدخل بياناتك",
                        style: FontsManger.largeFont(context)
                            ?.copyWith(fontSize: 24, color: Colors.black),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                      child: Text(
                        " تعديل البيانات",
                        style: FontsManger.mediumFont(context)
                            ?.copyWith(fontSize: 14, color: const Color(0xff1C1C1C)),
                      )),
                  BlocBuilder<AppCubit,AppState>(
                    builder: (context,state) {
                      return Center(
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            if(context.appCuibt.file!=null)
                              Container(
                                height: 135,
                                width: 135,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: FileImage(File(context.appCuibt.file!.path)),
                                        fit: BoxFit.contain
                                    ),
                                    shape: BoxShape.circle,
                                    border: Border.all(color: const Color(0xffE1E1E1),width: 6)
                                ),
                              ),
                            if(context.appCuibt.file==null)
                              SizedBox(
                              width: context.width*.4,
                              child: CachedNetworkImage(
                                height: 135,
                                width: 135,
                                fit: BoxFit.contain,
                                imageUrl: context.appCuibt.user?.image??"",
                                imageBuilder:(context,i)=> Container(
                                  height: 135,
                                  width: 135,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: i,
                                          fit: BoxFit.contain
                                      ),
                                      shape: BoxShape.circle,
                                      border: Border.all(color: const Color(0xffE1E1E1),width: 6)
                                  ),
                                ),
                                errorWidget: (context,i,_)=>Container(
                                  height: 135,
                                  width: 135,
                                  decoration: BoxDecoration(
                                      image: const DecorationImage(
                                          image: NetworkImage("https://cdn-icons-png.flaticon.com/512/3135/3135715.png"),
                                          fit: BoxFit.contain
                                      ),
                                      shape: BoxShape.circle,
                                      border: Border.all(color: const Color(0xffE1E1E1),width: 6)
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
right: 40,
                                bottom: 10,
                                child: Container(
                                  height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: InkWell(onTap: (){
                                      context.appCuibt.pickerPhoto(context);
                                    }, child: const Icon(Icons.camera_alt))))

                          ],
                        ),
                      );
                    }
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                  TextFormWidget(
                    controller: email,
                    label: 'إسمك باللغة العربية',

                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    width: context.width,
                    height: 43,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(width: 1,color: const Color(0xff707070))
                    ),
                    child: DropdownButtonFormField(
                      decoration:  InputDecoration(
                          border: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          filled: true,
                          fillColor: ColorsManger.white,
                          label: Text(types)),
                      items:[
                        DropdownMenuItem(
                          value: "Academic year",
                          child:Text("كلية",style: FontsManger.mediumFont(context)),
                          onTap: (){
                            setState(() {
                              types="كلية";
                            });
                          },
                        ),
                        DropdownMenuItem(
                          value: "m3hd",
                          child:Text("معهد",style: FontsManger.mediumFont(context)),
                          onTap: (){
                            setState(() {
                              types="معهد";
                            });
                          },
                        ),
                        DropdownMenuItem(
                          value: "diploma",
                          child:Text("دبلوم",style: FontsManger.mediumFont(context)),
                          onTap: (){
                            setState(() {
                              types="دبلوم";
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
                  ),
                  if(type=="Academic year")
                    const SizedBox(
                      height: 10,
                    ),
                  if(type=="Academic year")

                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      width: context.width,
                      height: 43,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(width: 1,color: const Color(0xff707070))
                      ),
                      child: DropdownButtonFormField(
                        decoration:  InputDecoration(
                            border: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                            filled: true,
                            fillColor: ColorsManger.white,
                            label: Text(field)),
                        items:List.generate(context.appCuibt.home.fiends.length, (index) =>   DropdownMenuItem(
                          value: context.appCuibt.home.fiends[index],
                          child:Text(context.appCuibt.home.fiends[index],style: FontsManger.mediumFont(context)),

                        ),),
                        value: field,
                        onChanged: ( value) {
                          setState(() {
                            field = value.toString();

                          });
                        },
                      ),
                    ),
                  if(type=="Academic year")
                    const SizedBox(
                      height: 10,
                    ),
                  if(type=="Academic year")

                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      width: context.width,
                      height: 43,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(width: 1,color: const Color(0xff707070))
                      ),
                      child: DropdownButtonFormField(
                        decoration:  InputDecoration(
                            border: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                            filled: true,
                            fillColor: ColorsManger.white,
                            label: Text(university)),
                        items:List.generate(context.appCuibt.home.university.length, (index) =>   DropdownMenuItem(
                          value: context.appCuibt.home.university[index],
                          child:Text(context.appCuibt.home.university[index],style: FontsManger.mediumFont(context)),

                        ),),
                        value: university,
                        onChanged: ( value) {
                          setState(() {
                            university = value.toString();

                          });
                        },
                      ),
                    ),
                  if(type=="Academic year")

                    const SizedBox(
                      height: 10,
                    ),
                  if(type=="Academic year")

                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      width: context.width,
                      height: 43,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(width: 1,color: const Color(0xff707070))
                      ),
                      child: DropdownButtonFormField(
                        decoration:  InputDecoration(
                            border: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                            filled: true,
                            fillColor: ColorsManger.white,
                            label: Text(teem[team-1])),
                        items:[
                          DropdownMenuItem(
                            value: 1,
                            child:Text("الفرقه الاولي",style: FontsManger.mediumFont(context)),

                          ),
                          DropdownMenuItem(
                            value: 2,
                            child:Text("الفرقه الثانيه",style: FontsManger.mediumFont(context)),

                          ),
                          DropdownMenuItem(
                            value: 3,
                            child:Text("الفرقه الثالثه",style: FontsManger.mediumFont(context)),

                          ),
                          DropdownMenuItem(
                            value: 4,
                            child:Text("الفرقه الرابعة",style: FontsManger.mediumFont(context)),

                          ),
                        ],
                        value: team,
                        onChanged: (int? value) {
                          setState(() {
                            team = value!;

                          });
                        },
                      ),
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

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    width: context.width,
                    height: 43,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(width: 1,color: const Color(0xff707070))
                    ),
                    child: DropdownButtonFormField(
                      decoration:  InputDecoration(
                          border: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          filled: true,
                          fillColor: ColorsManger.white,
                          label: Text(eg)),
                      items:[
                        DropdownMenuItem(
                          value: "مصري",
                          child:Text("مصري",style: FontsManger.mediumFont(context)),

                        ),
                        DropdownMenuItem(
                          value: "وافد",
                          child:Text("وافد",style: FontsManger.mediumFont(context)),

                        ),

                      ],
                      value: eg,
                      onChanged: (String? value) {
                        setState(() {
                          eg = value!;

                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(onPressed: () async {
                    UserModel user=UserModel(name: email.text, image: await context.appCuibt.uploadProfilePhoto(), phone: phone.text, team: team.toString(), typeStudy: type, token: context.appCuibt.user!.token, university: university, eg: eg=="مصري"?true:false,field: field);
                    context.appCuibt.editUser(user,context);
                  }, child:Text("إستمرار",style: FontsManger.mediumFont(context)?.copyWith(fontSize: 16,color: Colors.white),))

                ]),
              ),
            ],
          ),
        ));
  }
}
