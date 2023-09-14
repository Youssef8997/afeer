import 'package:afeer/models/user_model.dart';
import 'package:afeer/utls/extension.dart';
import 'package:afeer/utls/widget/base_widget.dart';
import 'package:flutter/material.dart';

import '../../utls/manger/assets_manger.dart';
import '../../utls/manger/color_manger.dart';
import '../../utls/manger/font_manger.dart';
import '../../utls/widget/text_form.dart';
import 'end_sign_up_screen.dart';

class CompleteInfoScreen extends StatefulWidget {
  final String phone;
  final String token;
  const CompleteInfoScreen({super.key, required this.phone, required this.token});

  @override
  State<CompleteInfoScreen> createState() => _CompleteInfoScreenState();
}

class _CompleteInfoScreenState extends State<CompleteInfoScreen> {
  late TextEditingController name;
  late TextEditingController email;
  late TextEditingController phone;
  int team=1;
  String type="كلية";
  String eg="مصري";
  List teem=[
    "الفرقه الاولي",
    "الفرقه الثانيه",
  "الفرقه الثالثه",
    "الفرقه الرابعة"
  ];
  @override
  void initState() {
    name=TextEditingController();
    email=TextEditingController();
    phone=TextEditingController(text: widget.phone);
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
                  label: Text(type)),
              items:[
                DropdownMenuItem(
                  value: "كلية",
                  child:Text("كلية",style: FontsManger.mediumFont(context)),

                ),
                DropdownMenuItem(
                  value: "معهد",
                  child:Text("معهد",style: FontsManger.mediumFont(context)),

                ),
                DropdownMenuItem(
                  value: "دبلوم",
                  child:Text("دبلوم",style: FontsManger.mediumFont(context)),

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
          ElevatedButton(onPressed: (){
            UserModel user=UserModel(name: email.text, image: "", phone: widget.phone, team: team.toString(), typeStudy: type, token: widget.token, university: "university", eg: eg=="مصري"?true:false);
            context.appCuibt.createAccount(user,context);
          }, child:Text("إستمرار",style: FontsManger.mediumFont(context)?.copyWith(fontSize: 16,color: Colors.white),))

        ]));
  }
}
