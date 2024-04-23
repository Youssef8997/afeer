import 'dart:io';

import 'package:afeer/models/user_model.dart';
import 'package:afeer/utls/extension.dart';
import 'package:afeer/utls/widget/base_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../cuibt/app_cuibt.dart';
import '../../../cuibt/app_state.dart';
import '../../../utls/manger/assets_manger.dart';
import '../../../utls/manger/color_manger.dart';
import '../../../utls/manger/font_manger.dart';
import '../../home_view/home_layout.dart';

class EndSignUpScreen extends StatefulWidget {
  const EndSignUpScreen({super.key});

  @override
  State<EndSignUpScreen> createState() => _EndSignUpScreenState();
}

class _EndSignUpScreenState extends State<EndSignUpScreen> {
  XFile? file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        minimum: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
            ),
            Text(
              "مرحبا يا ${context.appCuibt.user!.name}",
              style: FontsManger.largeFont(context)?.copyWith(
                color: const Color(0xff212621),
                fontSize: 24,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "أضف صورة شخصية",
              style: FontsManger.smallFont(context)?.copyWith(
                color: const Color(0xff212621).withOpacity(.5),
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Center(
              child: Container(
                height: 214,
                width: 214,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xffF9F9F9),
                    border:
                        Border.all(color: const Color(0xff7189FF), width: 2),
                    image: file != null
                        ? DecorationImage(
                            image: FileImage(File(file!.path)),
                            fit: BoxFit.fill)
                        : null),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: InkWell(
                onTap: () async {
                  file = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);

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
              height: 20,
            ),
            Center(
              child: BlocBuilder<AppCubit, AppState>(builder: (context, state) {
                return ElevatedButton(
                    style: Theme.of(context)
                        .elevatedButtonTheme
                        .style
                        ?.copyWith(
                            backgroundColor:
                                const MaterialStatePropertyAll(Colors.white),
                            side: MaterialStatePropertyAll(BorderSide(
                                color: ColorsManger.pColor, width: 1)),
                            shape:
                                const MaterialStatePropertyAll(StadiumBorder()),
                            foregroundColor:
                                MaterialStatePropertyAll(ColorsManger.pColor)),
                    onPressed: () {
                      FirebaseStorage.instance
                          .ref()
                          .child('profilePhoto/${file!.name}')
                          .putFile(File(file!.path))
                          .then((value) {
                        return value.ref.getDownloadURL().then((value) {
                          UserModel newUser = UserModel(
                              name: context.appCuibt.user!.name,
                              image: value,
                              phone: context.appCuibt.user!.phone,
                              email: context.appCuibt.user!.email,
                              pass: context.appCuibt.user!.pass,
                              team: context.appCuibt.user!.team,
                              field: context.appCuibt.user!.field,
                              typeStudy: context.appCuibt.user!.typeStudy,
                              token: context.appCuibt.user!.token,
                              university: context.appCuibt.user!.university,
                              eg: context.appCuibt.user!.eg);
                          context.appCuibt.editUser(newUser, context);
                        });
                      });
                    },
                    child: context.appCuibt.isLoading
                        ? CircularProgressIndicator(
                            color: ColorsManger.pColor,
                          )
                        : Text(
                            "إكتمال",
                            style: FontsManger.mediumFont(context)?.copyWith(
                                fontSize: 16, color: ColorsManger.pColor),
                          ));
              }),
            ),
          ],
        ),
      ),
    );
  }
}
