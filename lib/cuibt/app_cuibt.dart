// ignore_for_file: use_build_context_synchronously, invalid_return_type_for_catch_error, empty_catches, deprecated_member_use

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:afeer/cuibt/app_state.dart';
import 'package:afeer/data/local_data.dart';
import 'package:afeer/models/comment_model.dart';
import 'package:afeer/models/fun_model.dart';
import 'package:afeer/models/home_model.dart';
import 'package:afeer/models/order_id_model.dart';
import 'package:afeer/models/q_model.dart';
import 'package:afeer/models/user_model.dart';
import 'package:afeer/utls/widget/base_widget.dart';
import 'package:afeer/views/home_layout/home_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../models/academic_year_model.dart';
import '../models/additional_subject_model.dart';
import '../models/chat_list_model.dart';
import '../models/chat_model.dart';
import '../models/exam_model.dart';
import '../models/final_token_model.dart';
import '../models/lecture_model.dart';
import '../models/m3hd_model.dart';
import '../models/notification_model.dart';
import '../models/posts_model.dart';
import '../models/sub_model.dart';
import '../models/token_model.dart';
import '../update_screen.dart';
import '../utls/crypto_helpear.dart';
import '../utls/dio.dart';
import '../utls/manger/assets_manger.dart';
import '../utls/manger/font_manger.dart';
import '../views/auth_views/screens/auth_home_screen.dart';
import '../views/auth_views/screens/complete_screen.dart';
import '../views/auth_views/screens/end_sign_up_screen.dart';
import '../views/home_view/home_layout.dart';
import '../views/lecture_views/screens/video_offline_screen.dart';
import '../views/settings_views/screen/settings_screen.dart';
import '../views/subscribtion_views/screens/succses_page.dart';
import 'package:excel/excel.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);
  late HomeModel home;
  CollageModel? collage;
  UserModel? user;
  XFile? file;
  int pos = 0;
  List<AcademicYear> subjectList = [];
  List<Widget> body = [HomeScreen(), SettingsScreen()];
  PageController page = PageController();
  int indexScaffold = 0;
  List<AcademicYear> rev = [];
  List<LectureModel> lectureList = [];
  List<FunModel> fun = [];
  List<Map> newAdd = [];
  List<String> doctorList = [];
  List<AdditionalSubject> additionalList = [];
  List<LectureModel> lectureAdditionalList = [];
  List<SubModel> subList = [];
  List<ChatListModel> listChat = [];
  int index = 1;
  int correctAnswer = 0;
  List<PostsModel> posts = [];
  PageController pageController = PageController();
  bool isVisitor = false;
  bool isLoading = false;

  void changePos(value) {
    pos = value;
    emit(ChangePos());
  }

  void changeIndex(value) {
    index = value;
    emit(ChangePos());
  }

  void changeIndexS(value) {
    indexScaffold = value;
    page.animateToPage(value,
        duration: Duration(milliseconds: 600), curve: Curves.easeIn);
    emit(ChangePos());
  }

  void createAccount(UserModel userNew, BuildContext context) {
    FirebaseFirestore.instance
        .collection("Users")
        .doc(userNew.token)
        .set(userNew.toMap())
        .then((value) async {
      navigatorWid(
          page: const EndSignUpScreen(), returnPage: false, context: context);
      user = userNew;
      String topic =
          await translate("${user?.field}-${user?.university}-${user?.team}");

      FirebaseMessaging.instance.subscribeToTopic(topic.replaceAll(" ", "-"));

      SharedPreference.setDate(key: "token", value: userNew.token);
    }).catchError((error) {
      print(error);
    });
  }

  void editUser(UserModel userNew, BuildContext context) {
    FirebaseFirestore.instance
        .collection("Users")
        .doc(userNew.token)
        .update(userNew.toMap())
        .then((value) async {
      Navigator.pop(context);
      indexScaffold = 0;
      navigatorWid(
          page: const HomeLayout(), returnPage: false, context: context);

      user = userNew;
      String topic =
          await translate("${user?.field}-${user?.university}-${user?.team}");

      FirebaseMessaging.instance.subscribeToTopic(topic.replaceAll(" ", "-"));
      SharedPreference.setDate(key: "token", value: userNew.token);
    }).catchError((error) {});
  }

  Future<String> uploadProfilePhoto() {
    if (file != null) {
      return FirebaseStorage.instance
          .ref()
          .child('profilePhoto/${user?.token}')
          .putFile(File(file!.path))
          .then((value) {
        return value.ref.getDownloadURL().then((value) {
          return value;
        });
      });
    } else {
      return Future(() => "");
    }
  }

  Future<String> uploadExcel() async {
    Directory? directory = await getDownloadsDirectory();

    File saveLocation = File("${directory!.path}/yoyo.xlsx");

    print("start");
    return FirebaseStorage.instance
        .ref()
        .child('profilePhoto/yoyo')
        .putFile(saveLocation)
        .then((value) {
      print("procc");

      return value.ref.getDownloadURL().then((value) {
        print(value);
        return value;
      });
    });
  }

  Future pickerPhoto(context) async {
    file = await ImagePicker()
        .pickImage(source: ImageSource.gallery)
        .catchError((onError) => MotionToast.error(
                description: Text(
              onError.toString(),
              style: FontsManger.largeFont(context),
            )).show(context));
    emit(PickPhoto());
  }

  Future<UserModel> getInfo(uid, BuildContext context) async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(uid)
        .get()
        .then((value) {
      if (value.data()!["profileUrl"] != null) {
        navigatorWid(
            page: CompleteInfoScreen(
              email: value.data()!["phone"],
            ),
            context: context,
            returnPage: false);
      } else {
        user = UserModel.fromJson(value.data()!);
        print(user!.toMap());
        getSubject();
        getRev();
      }
      emit(GetInfo());
      return UserModel.fromJson(value.data()!);
    });
  }

  Future<UserModel> getInfoById(uid, BuildContext context) async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(uid)
        .get()
        .then((value) {
      return UserModel.fromJson(value.data()!);
    });
  }

  void signOut(context) {
    FirebaseAuth.instance.signOut().then((value) {
      user = null;
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
          // await FirebaseAuth.instance
          //     .signInWithCredential(credential)
          //     .then((value) async {
          //   if (value.additionalUserInfo!.isNewUser) {
          //     navigatorWid(
          //       context: context,
          //       page: CompleteInfoScreen(
          //         phone: phone,
          //         token: value.user?!.uid,
          //       ),
          //       returnPage: false,
          //     );
          //   } else {
          //     SharedPreference.setDate(key: "token", value: value.user?!.uid);
          //     await getInfo(value.user?!.uid, context)
          //         .then((value) {
          //           if(value!=null){
          //             navigatorWid(
          //               context: context,
          //               page: const HomeScreen(),
          //               returnPage: false,
          //             );
          //           }else {
          //             navigatorWid(
          //                 page: CompleteInfoScreen(phone: phone, token: value.user?!.uid),
          //                 context: context,
          //                 returnPage: false);
          //           }
          //
          //     });
          //   }
          // }).catchError((e) {
          //   MotionToast.error(
          //     description: Text(e.toString()),
          //     title: const Text("error"),
          //   ).show(context);
          // });
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

  void signEmailPassword({
    required BuildContext context,
    required String email,
    required String pass,
  }) async {
    isLoading = true;
    emit(LoadingState());
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((value) async {
      indexScaffold = 0;
      getInfo(value.user?.uid, context).then((e) async {
        if (e.tokenDevice ==
            await SharedPreference.getDate(key: "tokenDevice")) {
          SharedPreference.setDate(key: "token", value: value.user!.uid);

          navigatorWid(
            context: context,
            page: const HomeLayout(),
            returnPage: false,
          );
        } else if (e.tokenDevice == "") {
          String? token = await FirebaseMessaging.instance.getToken();
          FirebaseFirestore.instance
              .collection("Users")
              .doc(e.token)
              .update({"tokenDevice": token}).then((v) {
            SharedPreference.setDate(key: "tokenDevice", value: token);
            SharedPreference.setDate(key: "token", value: value.user!.uid);
            navigatorWid(
              context: context,
              page: const HomeLayout(),
              returnPage: false,
            );
          });
        } else {
          SnackBar snackBar = SnackBar(
            content: Text(
                "عفوا انت لست مسجل في هذا الحساب من فضلك توجه الي خدمه العملاء",
                style: FontsManger.largeFont(context)
                    ?.copyWith(color: Colors.white)),
            backgroundColor: Colors.red,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      });
      isLoading = false;
      emit(LoadingState());
    }).catchError((onError) {
      isLoading = false;
      emit(LoadingState());
      MotionToast.error(description: Text(onError.toString())).show(context);
    });
  }

  Future<bool> getIsHavaAccount(String phoneNumber) {
    return FirebaseFirestore.instance
        .collection("Users")
        .where("phone", isEqualTo: phoneNumber)
        .get()
        .then((value) {
      if (value.docs.length == 1) {
        UserModel newUser = UserModel.fromJson(value.docs[0].data());
        if (newUser.subscription != null) {
          user = newUser;
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    });
  }

  void signupEmailPassword({
    required BuildContext context,
    required String email,
    required String pass,
    required UserModel user1,
  }) async {
    isLoading = true;
    emit(LoadingState());
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pass)
          .then((value) async {
        String? token = await FirebaseMessaging.instance.getToken();

        UserModel? user2;
        await getIsHavaAccount(user1.phone).then((v) async {
          if (v == true) {
            user2 = UserModel(
                name: user!.name,
                image: user!.image,
                phone: user!.phone,
                email: email,
                tokenDevice: token,
                pass: pass,
                team: user!.team,
                field: user!.field,
                typeStudy: user!.typeStudy,
                token: value.user!.uid,
                university: user!.university,
                addSubject: user!.addSubject,
                subscription: user!.subscription,
                eg: user!.eg);
            SharedPreference.setDate(key: "tokenDevice", value: token);
          } else {
            user2 = UserModel(
                name: user1.name,
                image: user1.image,
                phone: user1.phone,
                tokenDevice: token,
                email: email,
                pass: pass,
                team: user1.team,
                field: user1.field,
                typeStudy: user1.typeStudy,
                token: value.user!.uid,
                university: user1.university,
                eg: user1.eg);
            SharedPreference.setDate(key: "tokenDevice", value: token);
          }
        });
        createAccount(user2!, context);
        isLoading = false;
        emit(LoadingState());
      });
    } catch (E) {
      isLoading = false;
      emit(LoadingState());
      MotionToast.error(description: Text("هذا البريد موجود بالفعل"))
          .show(context);
    }
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
              email: phoneNumber,
            ),
            returnPage: false,
          );
        } else {
          SharedPreference.setDate(key: "token", value: value.user!.uid);
          getInfo(value.user?.uid, context).then((value) {
            if (value == null) {
              navigatorWid(
                context: context,
                page: const HomeLayout(),
                returnPage: false,
              );
            } else {}
          });
        }
      });
    } catch (e) {
      MotionToast.error(
        description: Text(e.toString()),
        title: const Text("error"),
      ).show(context);
    }
  }

  Future signInWithFacebook(BuildContext context) async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential)
        .then((user) {
      if (user.additionalUserInfo!.isNewUser) {
        navigatorWid(
          context: context,
          page: CompleteInfoScreen(
            email: user.user!.email!,
          ),
          returnPage: false,
        );
      } else {
        getInfo(user.user?.uid, context).then((value) async {
          SharedPreference.setDate(key: "token", value: user.user!.uid);

          navigatorWid(
            context: context,
            page: const HomeLayout(),
            returnPage: false,
          );
        });
      }
    });
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
          .then((user) async {
        if (user.additionalUserInfo!.isNewUser) {
          navigatorWid(
            context: context,
            page: CompleteInfoScreen(
              email: user.user!.email!,
            ),
            returnPage: false,
          );
        } else {
          getInfo(user.user?.uid, context).then((e) async {
            if (e.tokenDevice ==
                await SharedPreference.getDate(key: "tokenDevice")) {
              SharedPreference.setDate(key: "token", value: user.user!.uid);

              navigatorWid(
                context: context,
                page: const HomeLayout(),
                returnPage: false,
              );
            } else if (e.tokenDevice == "") {
              String? token = await FirebaseMessaging.instance.getToken();
              FirebaseFirestore.instance
                  .collection("Users")
                  .doc(e.token)
                  .update({"tokenDevice": token}).then((v) {
                SharedPreference.setDate(key: "tokenDevice", value: token);
                SharedPreference.setDate(key: "token", value: user.user!.uid);
                navigatorWid(
                  context: context,
                  page: const HomeLayout(),
                  returnPage: false,
                );
              });
            } else {
              SnackBar snackBar = SnackBar(
                content: Text(
                    "عفوا انت لست مسجل في هذا الحساب من فضلك توجه الي خدمه العملاء",
                    style: FontsManger.largeFont(context)
                        ?.copyWith(color: Colors.white)),
                backgroundColor: Colors.red,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          });
        }
      });
    }
  }

  Future<UserModel?> getInfoUser(uid) async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(uid)
        .get()
        .then((value) {
      value.data() != null ? UserModel.fromJson(value.data()!) : null;
      emit(GetInfo());
      if (value.exists) {
        return UserModel.fromJson(value.data()!);
      } else {
        return null;
      }
    });
  }

  Future getHomeData(context) async {
    FirebaseFirestore.instance
        .collection("AppSettings")
        .doc("home")
        .get()
        .then((value) async {
      home = HomeModel.fromJson(value.data()!);
      await getCollage();
      await getFun();

      if (home.version != version) {
        navigatorWid(
            page: const UpdateScreen(), context: context, returnPage: false);
      }
    });
  }

  Future getCollage() async {
    try {
      FirebaseFirestore.instance
          .collection(user!.field)
          .doc(user?.university)
          .collection("home")
          .doc("home")
          .get()
          .then((value) {
        collage = CollageModel.fromJson(value.data()!);
        emit(GetCollage());
        return 0;
      });
    } catch (e) {}
  }

  Future getSubject() async {
    lectureList = [];
    FirebaseFirestore.instance
        .collection(user!.field)
        .doc(user?.university)
        .collection("teams")
        .doc(user?.team)
        .collection(home.term)
        .where("isRev", isNotEqualTo: true)
        .get()
        .then((value) async {
      subjectList = List.generate(value.docs.length,
          (index) => AcademicYear.fromJson(value.docs[index].data()));
      for (var element in subjectList) {
        Map map = await getLastLecture(subjectName: element.name);
        newAdd.add({
          "value": map["Lecture"],
          "doctor": map["doc"],
          "image": element.image,
          "name": element.name,
        });
      }
      emit(GetSubject());
    });
  }

  Future<Map> getLastLecture({required String subjectName}) async {
    return FirebaseFirestore.instance
        .collection(user!.field)
        .doc(user?.university)
        .collection("teams")
        .doc(user?.team)
        .collection(home.term)
        .doc(subjectName)
        .collection("doctor")
        .get()
        .then((value) async {
      return await FirebaseFirestore.instance
          .collection(user!.field)
          .doc(user?.university)
          .collection("teams")
          .doc(user?.team)
          .collection(home.term)
          .doc(subjectName)
          .collection("doctor")
          .doc(value.docs.first.get("name"))
          .collection("lecture")
          .orderBy(
            "time",
          )
          .limitToLast(2)
          .get()
          .then((e) {
        return {
          "Lecture": LectureModel.fromJson(e.docs[0].data()),
          "doc": value.docs[0].get("name")
        };
      });
    });
  }

  Future getRev() async {
    FirebaseFirestore.instance
        .collection(user!.field)
        .doc(user?.university)
        .collection("teams")
        .doc(user?.team)
        .collection(home.term)
        .where("isRev", isEqualTo: true)
        .get()
        .then((value) {
      rev = List.generate(value.docs.length,
          (index) => AcademicYear.fromJson(value.docs[index].data()));
      emit(GetSubject());
    });
  }

  Future getSubjectV() async {
    print("test");
    FirebaseFirestore.instance
        .collection("كلية التجارة")
        .doc("جامعة القاهرة")
        .collection("teams")
        .doc("1")
        .collection(home.term)
        .get()
        .then((value) {
      subjectList = List.generate(value.docs.length,
          (index) => AcademicYear.fromJson(value.docs[index].data()));
      FirebaseFirestore.instance
          .collection("كلية التجارة")
          .doc("جامعة القاهرة")
          .collection("home")
          .doc("home")
          .get()
          .then((value) {
        collage = CollageModel.fromJson(value.data()!);
        emit(GetCollage());
      });
      emit(GetSubject());
    });
  }

  Future getSubjectDoctor({required String subjectName}) async {
    FirebaseFirestore.instance
        .collection(user!.field)
        .doc(user?.university)
        .collection("teams")
        .doc(user?.team)
        .collection(home.term)
        .doc(subjectName)
        .collection("doctor")
        .get()
        .then((value) {
      doctorList = List.generate(
          value.docs.length, (index) => value.docs[index].get("name"));
      emit(GetSubjectDoctor());
    });
  }

  Future getSubjectDoctorV({required String subjectName}) async {
    FirebaseFirestore.instance
        .collection("كلية التجارة")
        .doc("جامعة القاهرة")
        .collection("teams")
        .doc("1")
        .collection(home.term)
        .doc(subjectName)
        .collection("doctor")
        .limit(1)
        .get()
        .then((value) {
      doctorList = List.generate(
          value.docs.length, (index) => value.docs[index].get("name"));
      emit(GetSubjectDoctor());
    });
  }

  Future getAddSubjectDoctor({required String subjectName, year}) async {
    FirebaseFirestore.instance
        .collection(user!.field)
        .doc(user?.university)
        .collection("teams")
        .doc(year)
        .collection(home.term)
        .doc(subjectName)
        .collection("doctor")
        .get()
        .then((value) {
      doctorList = List.generate(
          value.docs.length, (index) => value.docs[index].get("name"));
      emit(GetSubjectDoctor());
    });
  }

  Future getLectures(
      {required String subjectName, required String doctor}) async {
    return await FirebaseFirestore.instance
        .collection(user!.field)
        .doc(user?.university)
        .collection("teams")
        .doc(user?.team)
        .collection(home.term)
        .doc(subjectName)
        .collection("doctor")
        .doc(doctor)
        .collection("lecture")
        .orderBy(
          "time",
        )
        .get()
        .then((value) {
      lectureList = List.generate(value.docs.length,
          (index) => LectureModel.fromJson(value.docs[index].data()));
      emit(GetLecture());
    });
  }

  Future getLecturesV(
      {required String subjectName, required String doctor}) async {
    return await FirebaseFirestore.instance
        .collection("كلية التجارة")
        .doc("جامعة القاهرة")
        .collection("teams")
        .doc("1")
        .collection(home.term)
        .doc(subjectName)
        .collection("doctor")
        .doc(doctor)
        .collection("lecture")
        .orderBy(
          "time",
        )
        .limit(1)
        .get()
        .then((value) {
      lectureList = List.generate(value.docs.length,
          (index) => LectureModel.fromJson(value.docs[index].data()));
      emit(GetLecture());
    });
  }

  Future getAddLectures(
      {required String subjectName, required String doctor, year}) async {
    return await FirebaseFirestore.instance
        .collection(user!.field)
        .doc(user?.university)
        .collection("teams")
        .doc(year)
        .collection(home.term)
        .doc(subjectName)
        .collection("doctor")
        .doc(doctor)
        .collection("lecture")
        .orderBy(
          "time",
        )
        .get()
        .then((value) {
      lectureList = List.generate(value.docs.length,
          (index) => LectureModel.fromJson(value.docs[index].data()));
      emit(GetLecture());
    });
  }

  Future getExamLecture({
    required String subjectName,
    required String doctor,
    required BuildContext context,
    required LectureModel lecture,
  }) async {
    return await FirebaseFirestore.instance
        .collection(user!.field)
        .doc(user?.university)
        .collection("teams")
        .doc(user?.team)
        .collection(home.term)
        .doc(subjectName)
        .collection("doctor")
        .doc(doctor)
        .collection("lecture")
        .doc(lecture.name)
        .collection("exam")
        .get()
        .then((value) {
      return List.generate(value.docs.length,
          (index) => ExamModel.fromJson(value.docs[index].data()));
    });
  }

  Future getAddExamLecture({
    required String subjectName,
    required String doctor,
    required String year,
    required BuildContext context,
    required LectureModel lecture,
  }) async {
    return await FirebaseFirestore.instance
        .collection(user!.field)
        .doc(user?.university)
        .collection("teams")
        .doc(year)
        .collection(home.term)
        .doc(subjectName)
        .collection("doctor")
        .doc(doctor)
        .collection("lecture")
        .doc(lecture.name)
        .collection("exam")
        .get()
        .then((value) {
      return List.generate(value.docs.length,
          (index) => ExamModel.fromJson(value.docs[index].data()));
    });
  }

  Future getAdditionalSubject() async {
    return FirebaseFirestore.instance
        .collection("additional")
        .get()
        .then((value) {
      additionalList = List.generate(value.docs.length,
          (index) => AdditionalSubject.fromJson(value.docs[index].data()));
      emit(GetAdditionalSubject());
    });
  }

  Future getLecturesAdditional(name) async {
    return FirebaseFirestore.instance
        .collection("additional")
        .doc(name)
        .collection("Lecture")
        .get()
        .then((value) {
      lectureAdditionalList = List.generate(value.docs.length,
          (index) => LectureModel.fromJson(value.docs[index].data()));
      emit(GetAdditionalSubject());
    });
  }

  Future getM3hdSubject(String collection) async {
    return FirebaseFirestore.instance
        .collection(collection)
        .get()
        .then((value) {
      additionalList = List.generate(
          value.docs.length, (index) => value.docs[index].get("name"));
      emit(GetAdditionalSubject());
    });
  }

  Future getLecturesM3dh(name, collection) async {
    return FirebaseFirestore.instance
        .collection(collection)
        .doc(name)
        .collection("Lecture")
        .get()
        .then((value) {
      lectureAdditionalList = List.generate(value.docs.length,
          (index) => LectureModel.fromJson(value.docs[index].data()));
      emit(GetAdditionalSubject());
    });
  }

  Future getSubscription() async {
    FirebaseFirestore.instance.collection("Subscription").get().then((value) {
      subList = List.generate(value.docs.length,
          (index) => SubModel.fromJson(value.docs[index].data()));
      emit(GetSubscription());
    });
  }

  Future sendChatCallCanter(MassageModel massage, String chatId) async {
    FirebaseFirestore.instance
        .collection("CallCanter")
        .doc(chatId)
        .collection("massage")
        .add(massage.toMap());
  }

  Future getChatCallCanter() async {
    FirebaseFirestore.instance
        .collection("CallCanter")
        .where("idUser1", isEqualTo: user?.token)
        .get()
        .then((value) {
      listChat = List.generate(value.docs.length,
          (index) => ChatListModel.fromJson(value.docs[index].data()));
      emit(GetChatCallCanter());
    });
  }

  Future createChatCallCanter(massage) async {
    ChatListModel chat = ChatListModel(
        isGroup: false,
        chatId: const Uuid().v4(),
        idUser1: user!.token,
        idUser2: "replayed",
        isPersonal: false,
        isRead: false,
        lastMassage: massage);
    FirebaseFirestore.instance
        .collection("CallCanter")
        .doc(chat.chatId)
        .set(chat.toMap())
        .then((value) => getChatCallCanter());
    emit(GetChatCallCanter());
  }

  Future<ChatListModel> createChaPersonal(massage, idUser2) async {
    ChatListModel chat = ChatListModel(
        isGroup: false,
        chatId: const Uuid().v4(),
        idUser1: user!.token,
        idUser2: idUser2,
        isPersonal: false,
        isRead: false,
        lastMassage: massage);
    FirebaseFirestore.instance
        .collection("chat")
        .doc(chat.chatId)
        .set(chat.toMap())
        .then((value) => getChatCallCanter());

    emit(GetChatCallCanter());
    return chat;
  }

  Future getChatPersonal() async {
    FirebaseFirestore.instance
        .collection("chat")
        .where("idUser1", isEqualTo: user?.token)
        .get()
        .then((value) {
      listChat = List.generate(value.docs.length,
          (index) => ChatListModel.fromJson(value.docs[index].data()));
      FirebaseFirestore.instance
          .collection("chat")
          .where("idUser2", isEqualTo: user?.token)
          .get()
          .then((value) {
        listChat.addAll(List.generate(value.docs.length,
            (index) => ChatListModel.fromJson(value.docs[index].data())));
      });
    });

    emit(GetChatCallCanter());
  }

  Future sendChatPersonal(MassageModel massage, String chatId) async {
    FirebaseFirestore.instance
        .collection("chat")
        .doc(chatId)
        .collection("massage")
        .add(massage.toMap());
  }

  Future getPosts() async {
    FirebaseFirestore.instance
        .collection("news")
        .orderBy("time", descending: true)
        .get()
        .then((value) {
      posts = List.generate(value.docs.length,
          (index) => PostsModel.fromJson(value.docs[index].data()));
      emit(SendPosts());
    });
  }

  Future addComment(CommentModel comment, PostsModel post) async {
    List<Map> comments = List.generate(
        post.comments?.length ?? 0, (index) => post.comments![index].map());
    comments.add(comment.map());
    FirebaseFirestore.instance
        .collection("news")
        .doc(post.postId)
        .update({"comments": comments}).then((value) => getPosts());
  }

  Future addLike(PostsModel post) async {
    List likedId = post.likedId ?? [];
    if (likedId.contains(user?.token)) {
      likedId.remove(user?.token);
    } else {
      likedId.add(user?.token);
    }

    FirebaseFirestore.instance
        .collection("news")
        .doc(post.postId)
        .update({"likedId": likedId}).then((value) => getPosts());
  }

  Future getGroupChat() async {
    FirebaseFirestore.instance
        .collection("Groups")
        .doc(user?.field)
        .collection(user!.university)
        .get()
        .then((value) {
      listChat = List.generate(value.docs.length,
          (index) => ChatListModel.fromJson(value.docs[index].data()));
      emit(GetChatCallCanter());
    });
  }

  Future sendChatGroup(
      {required MassageModel massage,
      required String chatId,
      university,
      filed}) async {
    FirebaseFirestore.instance
        .collection("Groups")
        .doc(filed)
        .collection(university)
        .doc(chatId)
        .collection("massage")
        .add(massage.toMap());
  }

  Future deleteUser(id) async {
    await FirebaseAuth.instance.currentUser!.delete();
  }

  Future<void> launchUri(url, BuildContext context) async {
    try {
      launch(url);
    } catch (s) {
      MotionToast.error(description: Text(s.toString())).show(context);
    }
  }

  Future<String> translate(String text) async {
    Dio dio = Dio();
    Response response;
    response = await dio
        .post('https://microsoft-translator-text.p.rapidapi.com/translate',
            options: Options(
              headers: {
                'content-type': 'application/json',
                'X-RapidAPI-Key':
                    'f412b115c2msh1280967f6b3c85ap15ddcdjsn140b0a128a6c',
                'X-RapidAPI-Host': 'microsoft-translator-text.p.rapidapi.com',
              },
            ),
            queryParameters: {
          'to[0]': 'en',
          'api-version': '3.0',
          "profanityAction": 'NoAction',
          "textType": 'plain'
        },
            data: [
          {"Text": text}
        ]);
    return response.data[0]["translations"][0]["text"];
  }

  TokenModel? tokenModel;

  OrderIdModel? orderIdModel;

  FinalTokenId? finalTokenId;
  String payMobApi =
      "ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SndjbTltYVd4bFgzQnJJam8zTURneE9EWXNJbTVoYldVaU9pSnBibWwwYVdGc0lpd2lZMnhoYzNNaU9pSk5aWEpqYUdGdWRDSjkuZk5lLTNfekNnQzU4bW9pbzAzQm9aR0ZEMHpaV1d2Y3g3N0xlUWU3ak9KSHBkY1hqeXRvRDBYd1V1WnZsdlFqVV9zdlZnNUNCR19VVVdBY05CMV9OU2c=";
  List<String> subject = [];

//payment function
  Future getFirstToken(
      double money, BuildContext context, SubModel subs) async {
    try {
      await DioHelper.postData(
          url: "https://accept.paymob.com/api/auth/tokens",
          data: {"api_key": payMobApi}).then((value) {
        tokenModel = TokenModel.fromJson(value.data);
        getIdOrder(money, context, tokenModel!.token, subs);
      });
    } catch (E) {
      print(E);
      print("getFirstToken");
    }
  }

  Future getIdOrder(
      double money, BuildContext context, String token, SubModel subs) async {
    try {
      await DioHelper.postData(
          url: "https://accept.paymob.com/api/ecommerce/orders",
          data: {
            "auth_token": token,
            "delivery_needed": "false",
            "amount_cents": (money * 100).toString(),
            "currency": "EGP",
            "items": [],
          }).then((value) {
        orderIdModel = OrderIdModel.fromJson(value.data);
      }).catchError((e) {
        print(e);
        print("getIdOrder");
      }).whenComplete(() =>
          getFinalTokenId(money, context, token, orderIdModel!.orderId, subs));
    } catch (e) {
      print(e);
      print("getIdOrder");
    }
  }

  Future getFinalTokenId(double money, BuildContext context, String token,
      orderId, SubModel subs) async {
    try {
      DioHelper.postData(
          url: "https://accept.paymob.com/api/acceptance/payment_keys",
          data: {
            "auth_token": token,
            "amount_cents": (money * 100).toString(),
            "expiration": 60000,
            "order_id": orderId,
            "billing_data": {
              "apartment": "NA",
              "email": user?.email ?? "youssefahmed11@gmail.com",
              "floor": "Na",
              "first_name": user?.name,
              "street": "NA",
              "building": "NA",
              "phone_number": user?.phone,
              "shipping_method": "NA",
              "postal_code": "NA",
              "city": "EGYPT",
              "country": "PortSaid",
              "last_name": user?.name,
              "state": "Utah"
            },
            "currency": "EGP",
            "integration_id": "3494897",
            "lock_order_when_paid": "false"
          }).then((value) {
        WebViewController controller = WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setBackgroundColor(const Color(0x00000000))
          ..setNavigationDelegate(
            NavigationDelegate(
              onProgress: (int progress) {
                // Update loading bar.
              },
              onPageStarted: (url) =>
                  context.read<AppCubit>().getVisaSuccess(url, context, subs),
              onPageFinished: (String url) {},
              onWebResourceError: (WebResourceError error) {},
            ),
          )
          ..loadRequest(Uri.parse(
            "https://accept.paymob.com/api/acceptance/iframes/736701?payment_token=${context.read<AppCubit>().finalTokenId!.token}",
          ));
        finalTokenId = FinalTokenId.fromJson(value.data);
        Navigator.pop(context);
        showModalBottomSheet(
          context: context,
          builder: (context) => Column(
            children: [
              TextButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                label: Text(
                  "الرجوع",
                ),
                icon: Icon(Icons.arrow_back_outlined),
              ),
              Expanded(
                  child: WebViewWidget(
                controller: controller,
              )),
            ],
          ),
          isScrollControlled: true,
          useSafeArea: true,
          enableDrag: false,
          shape: const RoundedRectangleBorder(),
        );
      }).catchError((e) {
        print(e);
        print("getFinalTokenId");
      });
    } catch (e) {
      print(e);
      print("getFinalTokenId");
    }
  }

  String? fb;
  bool isOnline = false;

  Future<bool> getVisaSuccess(
      String url, BuildContext context, SubModel subs) async {
    if (url.contains(
        "https://accept.paymobsolutions.com/api/acceptance/post_pay")) {
      var response = url.split("&").toSet();
      for (var element in response) {
        if (element.contains("success")) {
          var paymentReference = element.split("=")[1];
          if (paymentReference == "true") {
            navigatorWid(
                page: SuccsesPage(sub: subs),
                context: context,
                returnPage: false);
          } else {
            Navigator.pop(context);
            Navigator.pop(context);
            MotionToast.error(
              description:
                  const Text("يوجد خطا ف عملية الدفع برجاء المحاوله مره اخري"),
            ).show(context);
          }
        }
      }
    }
    return false;
  }

  Future addSubscribeTUser(
      SubModel sub, UserModel user, BuildContext context) async {
    FirebaseFirestore.instance
        .collection("Users")
        .doc(user.token)
        .update({"subscription": sub.toMap(sub.id, subject)}).then((value) {
      getInfo(user.token, context);
    });
  }

  List<Map> notes = [];

  Future addNotes(
      {required String subjectName,
      required String doctorName,
      required String lectureName,
      required String notes}) async {
    FirebaseFirestore.instance
        .collection(user!.field)
        .doc(user?.university)
        .collection("teams")
        .doc(user?.team)
        .collection(home.term)
        .doc(subjectName)
        .collection("doctor")
        .doc(doctorName)
        .collection("lecture")
        .doc(lectureName)
        .collection("notes")
        .add({
      "notes": notes,
      "userId": user!.token,
      "time": Timestamp.now(),
    });
  }

  Future deleteNotes(
      {required String subjectName,
      required String doctorName,
      required String lectureName,
      required String id}) async {
    FirebaseFirestore.instance
        .collection(user!.field)
        .doc(user?.university)
        .collection("teams")
        .doc(user?.team)
        .collection(home.term)
        .doc(subjectName)
        .collection("doctor")
        .doc(doctorName)
        .collection("lecture")
        .doc(lectureName)
        .collection("notes")
        .doc(id)
        .delete();
  }

  Future editNotes(
      {required String subjectName,
      required String doctorName,
      required String lectureName,
      required String id,
      required String note}) async {
    FirebaseFirestore.instance
        .collection(user!.field)
        .doc(user?.university)
        .collection("teams")
        .doc(user?.team)
        .collection(home.term)
        .doc(subjectName)
        .collection("doctor")
        .doc(doctorName)
        .collection("lecture")
        .doc(lectureName)
        .collection("notes")
        .doc(id)
        .update({"notes": note});
  }

  Future getNotes({
    required String subjectName,
    required String doctorName,
    required String lectureName,
  }) async {
    notes = [];
    FirebaseFirestore.instance
        .collection(user!.field)
        .doc(user?.university)
        .collection("teams")
        .doc(user?.team)
        .collection(home.term)
        .doc(subjectName)
        .collection("doctor")
        .doc(doctorName)
        .collection("lecture")
        .doc(lectureName)
        .collection("notes")
        .where("userId", isEqualTo: user!.token)
        .orderBy("time", descending: true)
        .get()
        .then((value) {
      notes = List<Map>.generate(
          value.docs.length,
          (index) => {
                "text": value.docs[index].get("notes"),
                "id": value.docs[index].id
              });
      emit(GetNote());
    });
  }

  List<NotificationModel> notification = [];

  Future getNotification(topic) async {
    await FirebaseFirestore.instance
        .collection("AppSettings")
        .doc("notification")
        .collection(topic)
        .orderBy("date", descending: true)
        .get()
        .then((value) {
      print(value.docs.length);
      notification = List.generate(value.docs.length,
          (index) => NotificationModel.fromJson(value.docs[index].data()));
      emit(GetNotification());
    });
  }

  Future getFun() async {
    FirebaseFirestore.instance.collection("fun").get().then((value) {
      fun = List.generate(value.docs.length,
          (index) => FunModel.fromJson(value.docs[index].data()));
      emit(GetFun());
    });
  }

  void change() {
    emit(GetFun());
  }

  Future addQ(
      {required String subjectName,
      required String doctorName,
      required String lectureName,
      required String q,
      required int min}) async {
    QModel qe = QModel(
        id: Uuid().v4(),
        userId: user!.token,
        user: Future(() => user!),
        q: q,
        min: min,
        likedId: [],
        comments: []);
    FirebaseFirestore.instance
        .collection(user!.field)
        .doc(user?.university)
        .collection("teams")
        .doc(user?.team)
        .collection(home.term)
        .doc(subjectName)
        .collection("doctor")
        .doc(doctorName)
        .collection("lecture")
        .doc(lectureName)
        .collection("q")
        .doc(qe.id)
        .set(qe.toMap());
  }

  Future deleteQ({
    required String subjectName,
    required String doctorName,
    required String lectureName,
    required String qId,
  }) async {
    FirebaseFirestore.instance
        .collection(user!.field)
        .doc(user?.university)
        .collection("teams")
        .doc(user?.team)
        .collection(home.term)
        .doc(subjectName)
        .collection("doctor")
        .doc(doctorName)
        .collection("lecture")
        .doc(lectureName)
        .collection("q")
        .doc(qId)
        .delete();
  }

  List<QModel> q = [];

  Future getQ(
      {required String subjectName,
      required String doctorName,
      required String lectureName,
      required BuildContext context}) async {
    FirebaseFirestore.instance
        .collection(user!.field)
        .doc(user?.university)
        .collection("teams")
        .doc(user?.team)
        .collection(home.term)
        .doc(subjectName)
        .collection("doctor")
        .doc(doctorName)
        .collection("lecture")
        .doc(lectureName)
        .collection("q")
        .orderBy("min", descending: true)
        .get()
        .then((value) {
      q = List.generate(value.docs.length,
          (index) => QModel.fromJson(value.docs[index].data(), context));
      emit(GetQ());
    });
  }

  Future addCommentQ({
    required String subjectName,
    required String doctorName,
    required String lectureName,
    required BuildContext context,
    required CommentModel comment,
    required QModel q,
  }) async {
    List<CommentModel> c = q.comments;
    c.add(comment);
    FirebaseFirestore.instance
        .collection(user!.field)
        .doc(user?.university)
        .collection("teams")
        .doc(user?.team)
        .collection(home.term)
        .doc(subjectName)
        .collection("doctor")
        .doc(doctorName)
        .collection("lecture")
        .doc(lectureName)
        .collection("q")
        .doc(q.id)
        .update({
      "comments": List<Map>.generate(c.length, (index) => c[index].map())
    }).then((value) => getQ(
            subjectName: subjectName,
            doctorName: doctorName,
            lectureName: lectureName,
            context: context));
  }

  Future addLikeQ({
    required String subjectName,
    required String doctorName,
    required String lectureName,
    required BuildContext context,
    required QModel q,
  }) async {
    List c = q.likedId;
    if (c.contains(user!.token)) {
      c.remove(user!.token);
    } else {
      c.add(user!.token);
    }
    FirebaseFirestore.instance
        .collection(user!.field)
        .doc(user?.university)
        .collection("teams")
        .doc(user?.team)
        .collection(home.term)
        .doc(subjectName)
        .collection("doctor")
        .doc(doctorName)
        .collection("lecture")
        .doc(lectureName)
        .collection("q")
        .doc(q.id)
        .update({"likedId": c}).then((value) => getQ(
            subjectName: subjectName,
            doctorName: doctorName,
            lectureName: lectureName,
            context: context));
  }

  Future downloadVideo(String url, context) async {
    isLoading = true;
    emit(GetCollage());
    var ytExplode = YoutubeExplode();
    var video = await ytExplode.videos.get(url);

    var manifest = await ytExplode.videos.streamsClient.getManifest(video.url);

    var streamInfo = manifest.audioOnly.first;
    var videoStream = manifest.video.first;

    var audioStream = ytExplode.videos.streamsClient.get(streamInfo);
    var stream = await ytExplode.videos.streamsClient.get(videoStream);

    Directory directory = await getApplicationCacheDirectory();

    File saveLocation = File("${directory.path}/${video.id.value}.mp4");

    var fileStream = saveLocation.openWrite();

    // Pipe all the content of the stream into the file.
    await stream.pipe(fileStream);

    // Close teh file.
    await fileStream.flush();
    await fileStream.close();
    await CryptoHelper().encrypt(
        inputPath: saveLocation.path,
        key: "Youssefahmed116",
        ivw: "Youssefahmed116",
        outputPath: saveLocation.path.replaceFirst(".mp4", ".aes"));
    //  Map map=json.decode(SharedPreference.getDate(key: "listVideo"));
    // print(map);

    isLoading = false;
    emit(GetCollage());

    MotionToast.success(description: Text("تم التحميل بنجاح")).show(context);

    // Implement file saving logic here
  }

  Future<int> deVideo(url, BuildContext context, map) async {
    Directory directory = await getApplicationCacheDirectory();

    File saveLocation = File("${directory.path}/$url.aes");
    if (await File(saveLocation.path.replaceFirst(".aes", ".mp4")).exists()) {
      print("fileIsHere");
    } else {
      print("ur good dev");
    }
    await CryptoHelper().decrypt(
        inputPath: saveLocation.path,
        key: "Youssefahmed116",
        ivw: "Youssefahmed116",
        outputPath: saveLocation.path.replaceFirst(".aes", ".mp4"));
    Navigator.pop(context);
    navigatorWid(
        page: VideoOffline(
          map: map,
        ),
        returnPage: true,
        context: context);

    return 1;
  }

  void save(videoId, subjectName, lectureName) {
    var box = Hive.box('my videos');

    box.put(box.length,
        {"videoId": videoId, "title": subjectName, "lectureName": lectureName});
  }

  List myVideos = [];

  void getBox() {
    var box = Hive.box('my videos');
    for (var i = 0; i < box.length; i++) {
      print(i);
      myVideos.add(box.getAt(i));
    }
  }

  void getmoneyData() {
    FirebaseFirestore.instance
        .collection("Users")
        .where("subscription", isNull: false)
        .get()
        .then((value) async {
      List<UserModel> user = [];
      user = List.generate(value.docs.length,
          (index) => UserModel.fromJson(value.docs[index].data()));
      var excel = Excel.createExcel();
      final Sheet sheet = excel[excel.getDefaultSheet()!];
      for (var row = 0; row < user.length; row++) {
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row))
            .value = TextCellValue(user[row].token);

        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: row))
            .value = TextCellValue(user[row].subscription!.name);
      }
      var fileBytes = excel.save();

      Directory? directory = await getDownloadsDirectory();

      File saveLocation = File("${directory!.path}/yoyo.xlsx");
      await saveLocation.create();
      await saveLocation.writeAsBytes(fileBytes!);
      print("done");
    });
  }
}
