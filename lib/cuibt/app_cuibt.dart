// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:afeer/cuibt/app_state.dart';
import 'package:afeer/data/local_data.dart';
import 'package:afeer/models/home_model.dart';
import 'package:afeer/models/user_model.dart';
import 'package:afeer/utls/widget/base_widget.dart';
import 'package:app_popup_menu/app_popup_menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';

import '../auth_views/screens/auth_home_screen.dart';
import '../auth_views/screens/complete_screen.dart';
import '../auth_views/screens/end_sign_up_screen.dart';
import '../home_view/home_layout.dart';
import '../models/academic_year_model.dart';
import '../models/lecture_model.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);
  late HomeModel home;
  late UserModel user;
  XFile? file;
  int pos = 0;
List<AcademicYear>subjectList=[];
List<LectureModel>lectureList=[];
  void changePos(value) {
    pos = value;
    emit(ChangePos());
  }

  void createAccount(UserModel userNew, BuildContext context) {
    FirebaseFirestore.instance
        .collection("Users")
        .doc(userNew.token)
        .set(userNew.toMap())
        .then((value) {
      print(userNew.toMap());
      navigatorWid(
          page: const EndSignUpScreen(), returnPage: false, context: context);

      user = userNew;
      SharedPreference.setDate(key: "token", value: userNew.token);
    }).catchError((error) {
      print(error);
    });
  }

  void uploadProfilePhoto() {
    FirebaseStorage.instance
        .ref()
        .child('profilePhoto/${user.token}')
        .putFile(File(file!.path))
        .then((value) {
      value.ref.getDownloadURL().then((value) {});
    });
  }

  Future<void> getInfo(uid) async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(uid)
        .get()
        .then((value) {
      user = UserModel.fromJson(value.data()!);
      getSubject();
      emit(GetInfo());
      return user;
    });
  }

  void signOut(context) {
    FirebaseAuth.instance.signOut().then((value) {
      navigatorWid(
          context: context, page: const AuthHomeScreen(), returnPage: false);
      SharedPreference.removeDate(key: "token");
    });
  }

  String codeSent = "";

  void verifyPhoneNumber({
    required BuildContext context,
    required String phone,
  }) async {
    int? forceResendingToken;
    await FirebaseAuth.instance.verifyPhoneNumber(
        forceResendingToken: forceResendingToken,
        phoneNumber: "+2$phone",
        verificationCompleted: (credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.additionalUserInfo!.isNewUser) {
              navigatorWid(
                context: context,
                page: CompleteInfoScreen(
                  phone: phone,
                  token: value.user!.uid,
                ),
                returnPage: false,
              );
            } else {
              SharedPreference.setDate(key: "token", value: value.user!.uid);
              getInfo(
                value.user!.uid,
              );
              navigatorWid(
                context: context,
                page: const HomeScreen(),
                returnPage: false,
              );
            }
          }).catchError((e) {
            MotionToast.error(
              description: Text(e.toString()),
              title: const Text("error"),
            ).show(context);
          });
        },
        verificationFailed: (verificationFailed) {
          MotionToast.error(
            description: Text(verificationFailed.toString()),
            title: const Text("error"),
          ).show(context);
        },
        codeSent: (verificationId, resendingToken) {
          codeSent = verificationId;
          forceResendingToken = resendingToken;
        },
        codeAutoRetrievalTimeout: (codeAutoRetrievalTimeout) {
          codeSent = codeAutoRetrievalTimeout;
        },
        timeout: const Duration(seconds: 60));
  }

  Future<void> signInWithPhone(
    BuildContext context,
    String otp,
    String phoneNumber,
  ) async {
    try {
      await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
        verificationId: AppCubit.get(context).codeSent,
        smsCode: otp,
      ))
          .then((value) async {
        if (value.additionalUserInfo!.isNewUser) {
          SharedPreference.setDate(key: "token", value: value.user!.uid);
          navigatorWid(
            context: context,
            page: CompleteInfoScreen(
              phone: phoneNumber,
              token: value.user!.uid,
            ),
            returnPage: false,
          );
        } else {
          SharedPreference.setDate(key: "token", value: value.user!.uid);
          getInfo(
            value.user!.uid,
          );
          navigatorWid(
            context: context,
            page: const HomeScreen(),
            returnPage: false,
          );
        }
      });
    } catch (e) {
      MotionToast.error(
        description: Text(e.toString()),
        title: const Text("error"),
      ).show(context);
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {

      final googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount;
      final googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        googleSignInAccount = googleUser;
        final googleAuth = await googleSignInAccount.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) async {
          if (value.additionalUserInfo!.isNewUser) {
            navigatorWid(
              context: context,
              page: CompleteInfoScreen(
                phone: "",
                token: value.user!.uid,
              ),
              returnPage: false,
            );
          } else {
            SharedPreference.setDate(key: "token", value: value.user!.uid);
            await getInfo(
              value.user!.uid,
            );
            navigatorWid(
              context: context,
              page: const HomeScreen(),
              returnPage: false,
            );
          }
        });
      }
    }


  Future getHomeData() async {
    FirebaseFirestore.instance
        .collection("AppSettings")
        .doc("home")
        .get()
        .then((value) {
      home = HomeModel.fromJson(value.data()!);
    });
  }
Future getSubject()async{
  FirebaseFirestore.instance
      .collection("Academic year")
      .doc(user.team).collection("1")
      .get()
      .then((value) {
    subjectList = List.generate(value.docs.length, (index) => AcademicYear.fromJson(value.docs[index].data()));
  });
}
Future getLecture({required String nameSubject,required BuildContext context})async{
  showLoading(context);
return await FirebaseFirestore.instance
      .collection("Academic year")
      .doc(user.team).collection("1").doc(nameSubject).collection("lecture")
      .get()
      .then((value) {
        Navigator.pop(context);
    lectureList = List.generate(value.docs.length, (index) => LectureModel.fromJson(value.docs[index].data()));
  });
}
}
