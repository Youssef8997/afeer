// ignore_for_file: use_build_context_synchronously, invalid_return_type_for_catch_error, empty_catches, deprecated_member_use

import 'dart:io';

import 'package:afeer/cuibt/app_state.dart';
import 'package:afeer/data/local_data.dart';
import 'package:afeer/models/comment_model.dart';
import 'package:afeer/models/home_model.dart';
import 'package:afeer/models/user_model.dart';
import 'package:afeer/utls/widget/base_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

import '../auth_views/screens/auth_home_screen.dart';
import '../auth_views/screens/complete_screen.dart';
import '../auth_views/screens/end_sign_up_screen.dart';
import '../home_view/home_layout.dart';
import '../models/academic_year_model.dart';
import '../models/chat_list_model.dart';
import '../models/chat_model.dart';
import '../models/exam_model.dart';
import '../models/lecture_model.dart';
import '../models/m3hd_model.dart';
import '../models/posts_model.dart';
import '../models/sub_model.dart';
import '../update_screen.dart';
import '../utls/manger/assets_manger.dart';
import '../utls/manger/font_manger.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);
  late HomeModel home;
  CollageModel? collage;
   UserModel? user;
  XFile? file;
  int pos = 0;
  List<AcademicYear> subjectList = [];
  List<LectureModel> lectureList = [];
  List<String> doctorList = [];
  List<String> additionalList = [];
  List<M3hdModel> lectureAdditionalList = [];
  List<SubModel> subList = [];
  List<ChatListModel> listChat = [];
  int index = 1;
  int correctAnswer = 0;
  List<PostsModel> posts = [];
  PageController pageController = PageController();
  bool isVisitor=false;
  void changePos(value) {
    pos = value;
    emit(ChangePos());
  }

  void changeIndex(value) {
    index = value;
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
      String topic= await translate("${user?.field}-${user?.university}-${user?.team}");

      FirebaseMessaging.instance.subscribeToTopic(topic.replaceAll(" ", "-"));

      SharedPreference.setDate(key: "token", value: userNew.token);
    }).catchError((error) {});
  }

  void editUser(UserModel userNew, BuildContext context) {
    FirebaseFirestore.instance
        .collection("Users")
        .doc(userNew.token)
        .update(userNew.toMap())
        .then((value) async {
      navigatorWid(
          page: const HomeScreen(), returnPage: false, context: context);

      user = userNew;
      String topic= await translate("${user?.field}-${user?.university}-${user?.team}");

      FirebaseMessaging.instance.subscribeToTopic(topic.replaceAll(" ", "-"));
      SharedPreference.setDate(key: "token", value: userNew.token);
    }).catchError((error) {});
  }

  Future<String> uploadProfilePhoto() {
    return FirebaseStorage.instance
        .ref()
        .child('profilePhoto/${user?.token}')
        .putFile(File(file!.path))
        .then((value) {
      return value.ref.getDownloadURL().then((value) {
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

  Future getInfo(uid, BuildContext context) async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(uid)
        .get()
        .then((value) {
      if (value.data()!["profileUrl"] != null) {
        navigatorWid(
            page: CompleteInfoScreen(phone: value.data()!["phone"], token: uid),
            context: context,
            returnPage: false);
      } else {
        user = UserModel.fromJson(value.data()!);

        getSubject();
      }
      emit(GetInfo());
      return value.data()!["profileUrl"];
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
          getInfo(value.user?.uid, context).then((value) {
            if (value == null) {
              navigatorWid(
                context: context,
                page: const HomeScreen(),
                returnPage: false,
              );
            } else {
              navigatorWid(
                  page: CompleteInfoScreen(
                      phone: phoneNumber, token: value.user!.uid),
                  context: context,
                  returnPage: false);
            }
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
          await getInfo(value.user!.uid, context);
          navigatorWid(
            context: context,
            page: const HomeScreen(),
            returnPage: false,
          );
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
      });
    } catch (e) {}
  }

  Future getSubject() async {
    FirebaseFirestore.instance
        .collection(user!.field)
        .doc(user?.university)
        .collection("teams")
        .doc(user?.team)
        .collection(home.term)
        .get()
        .then((value) {
      subjectList = List.generate(value.docs.length,
          (index) => AcademicYear.fromJson(value.docs[index].data()));
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

  Future getAdditionalSubject() async {
    return FirebaseFirestore.instance
        .collection("additional")
        .get()
        .then((value) {
      additionalList = List.generate(
          value.docs.length, (index) => value.docs[index].get("name"));
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
          (index) => M3hdModel.fromJson(value.docs[index].data()));
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
          (index) => M3hdModel.fromJson(value.docs[index].data()));
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
        .orderBy("time")
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
}
