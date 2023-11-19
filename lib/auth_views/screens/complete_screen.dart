import 'package:afeer/models/user_model.dart';
import 'package:afeer/utls/extension.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../utls/manger/assets_manger.dart';
import '../../utls/manger/color_manger.dart';
import '../../utls/manger/font_manger.dart';
import '../../utls/widget/text_form.dart';

class CompleteInfoScreen extends StatefulWidget {
  final String phone;
  const CompleteInfoScreen({super.key, required this.phone,});

  @override
  State<CompleteInfoScreen> createState() => _CompleteInfoScreenState();
}

class _CompleteInfoScreenState extends State<CompleteInfoScreen> {
  late TextEditingController name;
  late TextEditingController name2;
  late TextEditingController email;
  late TextEditingController pass;
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
    getData();
    name = TextEditingController();
    email = TextEditingController();
    pass = TextEditingController();
    phone = TextEditingController(text: widget.phone);
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
    phone.dispose();
    email.dispose();
    pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 50,
          leading: TextButton(
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
        body: ListView(padding: const EdgeInsets.all(20), children: [
          Image.asset(
            AssetsManger.logo2,
            width: context.width * .5,
            height: context.height * .07,
          ),
          SizedBox(
            height: context.height * .05,
          ),
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
            "لإتمام تسجيل دخولك يرجى إستكمال بياناتك",
            style: FontsManger.mediumFont(context)
                ?.copyWith(fontSize: 14, color: const Color(0xff1C1C1C)),
          )),
          const SizedBox(
            height: 30,
          ),
           TextFormWidget(
             controller: name,
            label: 'إسمك باللغة العربية',
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
             active: widget.phone==""?true:false,
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
          ElevatedButton(onPressed: () {
                UserModel user = UserModel(
                    name: name.text,
                    image: "",
                    phone: phone.text,
                    team: team.toString(),
                    typeStudy: type,
                    token: const Uuid().v4(),
                    university: university,
                    eg: eg == "مصري" ? true : false,
                    field: field,
                    email: email.text,
                    pass: pass.text);
                context.appCuibt.signupEmailPassword(user1: user,pass: pass.text,email: email.text,context:  context);
              }, child:Text("إستمرار",style: FontsManger.mediumFont(context)?.copyWith(fontSize: 16,color: Colors.white),))

        ]));
  }
}
