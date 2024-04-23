import 'dart:convert';
import 'dart:io';

import 'package:afeer/cuibt/app_cuibt.dart';
import 'package:afeer/cuibt/app_state.dart';
import 'package:afeer/utls/extension.dart';
import 'package:afeer/utls/widget/text_form.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pod_player/pod_player.dart';

import '../../../data/local_data.dart';
import '../../../pdf_view.dart';
import '../../../utls/crypto_helpear.dart';
import '../../../utls/manger/color_manger.dart';
import '../../../utls/manger/font_manger.dart';
import '../widget/q_widget.dart';

class VideoScreen extends StatefulWidget {
  final String videoId;
  final String subjectName;
  final String lectureName;
  final String doctorName;
  final List? pdfs;

  const VideoScreen(
      {super.key,
      required this.videoId,
      this.pdfs,
      required this.subjectName,
      required this.lectureName,
      required this.doctorName});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen>
    with SingleTickerProviderStateMixin {
  late final PodPlayerController controller;
  late TabController tab;
  final CryptoHelper cryptoHelper = CryptoHelper();

  TextEditingController note = TextEditingController();
  String path = "";
  bool fileExists = true;
  Future<void> getData() async {
    context.appCuibt
        .getNotes(
          subjectName: widget.subjectName,
          doctorName: widget.doctorName,
          lectureName: widget.lectureName,
        )
        .then((value) => setState(() {}));
    context.appCuibt
        .getQ(
            subjectName: widget.subjectName,
            doctorName: widget.doctorName,
            lectureName: widget.lectureName,
            context: context)
        .then((value) => setState(() {}));
    getApplicationCacheDirectory().then((value) => path = value.path);
    File saveLocation = File("$path/${widget.videoId}.aes");
    fileExists = await saveLocation.exists();
  }

  @override
  void initState() {
    tab = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
    controller = PodPlayerController(
      playVideoFrom:
          PlayVideoFrom.youtube('https://youtu.be/${widget.videoId}'),
      podPlayerConfig: const PodPlayerConfig(
        autoPlay: true,
        isLooping: false,
        forcedVideoFocus: true,
        videoQualityPriority: [720, 360],
      ),
    )..initialise();
    getData();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        SharedPreference.setDate(
            key: "last",
            value: json.encode({
              "subjectName": widget.subjectName,
              "pdfs": json.encode(widget.pdfs),
              "lectureName": widget.lectureName,
              "videoId": widget.videoId,
              "docName": widget.doctorName,
              "AllVideoMin": controller.totalVideoLength.inMinutes,
              "now": controller.currentVideoPosition.inMinutes,
            }));
        return Future(() => true);
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 30,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              PodVideoPlayer(
                  controller: controller,
                  matchVideoAspectRatioToFrame: true,
                  onLoading: (context) => const CircularProgressIndicator(),
                  onVideoError: () {
                    controller = PodPlayerController(
                      playVideoFrom: PlayVideoFrom.youtube(
                          'https://youtu.be/${widget.videoId}'),
                      podPlayerConfig: const PodPlayerConfig(
                        autoPlay: true,
                        isLooping: false,
                        forcedVideoFocus: true,
                        videoQualityPriority: [720, 360],
                      ),
                    )..initialise();
                    controller.changeVideo(
                      playVideoFrom: PlayVideoFrom.youtube(
                          'https://youtu.be/${widget.videoId}'),
                      playerConfig: const PodPlayerConfig(
                        autoPlay: true,
                        isLooping: false,
                        forcedVideoFocus: true,
                        videoQualityPriority: [720, 360],
                      ),
                    );
                    return Center(
                      child: Text(
                        "هناك خطا في تحميل الفيديو يرجي التاكد من سرعه الانترنت الخاصه بك ",
                        style: FontsManger.largeFont(context),
                      ),
                    );
                  },
                  frameAspectRatio: (context.width / context.height),
                  matchFrameAspectRatioToVideo: true),
              if (!fileExists)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Text(
                        " تحميل المحاضره الان",
                        style: FontsManger.largeFont(context),
                      ),
                      const Spacer(),
                      BlocBuilder<AppCubit, AppState>(
                          builder: (context, state) {
                        return IconButton(
                          icon: context.appCuibt.isLoading
                              ? CircularProgressIndicator()
                              : Icon(
                                  Icons.download,
                                  color: Colors.black,
                                ),
                          onPressed: () {
                            context.appCuibt
                                .downloadVideo(
                                    "https://www.youtube.com/watch?v=${widget.videoId}",
                                    context)
                                .then((value) => context.appCuibt.save(
                                    widget.videoId,
                                    widget.subjectName,
                                    widget.lectureName));
                            //  CryptoHelper().decrypt(inputPath:"storage/emulated/0/Download/yoyo.aes",  key: "Youssefahmed116", ivw: "Youssefahmed116", outputPath: "storage/emulated/0/Download/yoyo.mp4");
                          },
                        );
                      }),
                    ],
                  ),
                ),
              TabBar(
                  tabs: const [
                    Tab(
                      text: "الملزمة",
                    ),
                    Tab(
                      text: "ملاحظاتك",
                    ),
                    Tab(
                      text: "إطرح سؤالك",
                    ),
                  ],
                  controller: tab,
                  labelColor: const Color(0xff2B2B2B),
                  indicatorWeight: 3,
                  isScrollable: true,
                  indicatorColor: const Color(0xff65256E),
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelStyle: FontsManger.mediumFont(context)
                      ?.copyWith(fontSize: 12, color: const Color(0xff2B2B2B))),
              BlocBuilder<AppCubit, AppState>(builder: (context, state) {
                return Expanded(
                    child: TabBarView(
                  controller: tab,
                  children: [
                    ListView.separated(
                      padding: const EdgeInsets.all(20),
                      itemBuilder: (context, i) => InkWell(
                        onTap: () {
                          if (Platform.isIOS &&
                              context.appCuibt.home.applePay) {
                            showDialog(
                                context: context,
                                useRootNavigator: false,
                                useSafeArea: false,
                                builder: (ctx) =>
                                    BlocBuilder<AppCubit, AppState>(
                                        builder: (context, state) {
                                      return OrientationBuilder(
                                        builder: (context, o) {
                                          if (o == Orientation.landscape) {
                                            context.appCuibt.change();
                                          }
                                          if (o != Orientation.landscape) {
                                            context.appCuibt.change();
                                          }
                                          return Dialog(
                                              insetPadding: EdgeInsets.zero,
                                              elevation: 5,
                                              backgroundColor:
                                                  Colors.black.withOpacity(.2),
                                              child: SizedBox(
                                                  width: context.width,
                                                  height: context.height,
                                                  child: PdfView(
                                                      pdfLink: widget.pdfs![i]
                                                          ["link"])));
                                        },
                                      );
                                    }));
                          } else {
                            if (context.appCuibt.user?.subscription != null) {
                              if (context.appCuibt.user?.subscription!
                                      .isASingleSubject ==
                                  true) {
                                if (context.appCuibt.user?.subscription!
                                        .singleSubject!
                                        .contains(widget.subjectName) ==
                                    true) {
                                  showDialog(
                                      context: context,
                                      useRootNavigator: false,
                                      useSafeArea: false,
                                      builder: (ctx) =>
                                          BlocBuilder<AppCubit, AppState>(
                                              builder: (context, state) {
                                            return OrientationBuilder(
                                              builder: (context, o) {
                                                if (o ==
                                                    Orientation.landscape) {
                                                  context.appCuibt.change();
                                                }
                                                if (o !=
                                                    Orientation.landscape) {
                                                  context.appCuibt.change();
                                                }
                                                return Dialog(
                                                    insetPadding:
                                                        EdgeInsets.zero,
                                                    elevation: 5,
                                                    backgroundColor: Colors
                                                        .black
                                                        .withOpacity(.2),
                                                    child: SizedBox(
                                                        width: context.width,
                                                        height: context.height,
                                                        child: PdfView(
                                                            pdfLink:
                                                                widget.pdfs![i]
                                                                    ["link"])));
                                              },
                                            );
                                          }));
                                } else {
                                  final snackBar = SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(
                                        'انت غير مشترك برجاء التواصل مع خدمه العملاء',
                                        style: FontsManger.largeFont(context)
                                            ?.copyWith(
                                                color: ColorsManger.white)),
                                    showCloseIcon: true,
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              } else {
                                showDialog(
                                    context: context,
                                    useRootNavigator: false,
                                    useSafeArea: false,
                                    builder: (ctx) =>
                                        BlocBuilder<AppCubit, AppState>(
                                            builder: (context, state) {
                                          return OrientationBuilder(
                                            builder: (context, o) {
                                              if (o == Orientation.landscape) {
                                                context.appCuibt.change();
                                              }
                                              if (o != Orientation.landscape) {
                                                context.appCuibt.change();
                                              }
                                              return Dialog(
                                                  insetPadding: EdgeInsets.zero,
                                                  elevation: 5,
                                                  backgroundColor: Colors.black
                                                      .withOpacity(.2),
                                                  child: SizedBox(
                                                      width: context.width,
                                                      height: context.height,
                                                      child: PdfView(
                                                          pdfLink:
                                                              widget.pdfs![i]
                                                                  ["link"])));
                                            },
                                          );
                                        }));
                              }
                            } else {
                              if (i == 0) {
                                showDialog(
                                    context: context,
                                    useRootNavigator: false,
                                    useSafeArea: false,
                                    builder: (ctx) =>
                                        BlocBuilder<AppCubit, AppState>(
                                            builder: (context, state) {
                                          return OrientationBuilder(
                                            builder: (context, o) {
                                              if (o == Orientation.landscape) {
                                                context.appCuibt.change();
                                              }
                                              if (o != Orientation.landscape) {
                                                context.appCuibt.change();
                                              }
                                              return Dialog(
                                                  insetPadding: EdgeInsets.zero,
                                                  elevation: 5,
                                                  backgroundColor: Colors.black
                                                      .withOpacity(.2),
                                                  child: SizedBox(
                                                      width: context.width,
                                                      height: context.height,
                                                      child: PdfView(
                                                          pdfLink:
                                                              widget.pdfs![i]
                                                                  ["link"])));
                                            },
                                          );
                                        }));
                              } else {
                                final snackBar = SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text(
                                      'انت غير مشترك برجاء التواصل مع خدمه العملاء',
                                      style: FontsManger.largeFont(context)
                                          ?.copyWith(
                                              color: ColorsManger.white)),
                                  showCloseIcon: true,
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            }
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 0),
                          height: 56,
                          width: context.width,
                          decoration:
                              const BoxDecoration(color: Color(0xffF2F2F2)),
                          child: Row(
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: const Color(0xffEBE2EC)),
                                child: SvgPicture.asset(
                                    "assets/image/agenda.svg",
                                    fit: BoxFit.none),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.pdfs![i]["name"],
                                      style: FontsManger.largeFont(context)
                                          ?.copyWith(fontSize: 13)),
                                  Text(widget.pdfs![i]["det"],
                                      style: FontsManger.mediumFont(context)
                                          ?.copyWith(
                                              fontSize: 9,
                                              color: const Color(0xff242126)
                                                  .withOpacity(.65))),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      separatorBuilder: (context, i) =>
                          const SizedBox(height: 10),
                      itemCount: (widget.pdfs!.length),
                    ),
                    if (context.appCuibt.notes.isEmpty)
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "لم تقم بإضافة أي ملاحظات",
                              style: FontsManger.largeFont(context)?.copyWith(
                                  fontSize: 14, color: const Color(0xff242126)),
                            ),
                            Center(
                              child: Image.asset(
                                fit: BoxFit.cover,
                                height: 287,
                                "assets/image/4025692.png",
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            Center(
                              child: ElevatedButton(
                                  style: Theme.of(context)
                                      .elevatedButtonTheme
                                      .style
                                      ?.copyWith(
                                          backgroundColor:
                                              const MaterialStatePropertyAll(
                                                  Color(0xff313131)),
                                          shape: const MaterialStatePropertyAll(
                                              StadiumBorder()),
                                          fixedSize: MaterialStatePropertyAll(
                                              Size(context.width * .8, 45))),
                                  onPressed: () {
                                    showModalBottomSheet(
                                        enableDrag: true,
                                        isDismissible: true,
                                        isScrollControlled: true,
                                        constraints: BoxConstraints(
                                            minHeight: context.height * .5,
                                            maxHeight: context.height * .5),
                                        context: context,
                                        builder: (context) {
                                          return Container(
                                            height: context.height,
                                            width: context.width,
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                        top: Radius.circular(
                                                            36))),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 22, vertical: 10),
                                            child: StatefulBuilder(
                                              builder: (BuildContext context,
                                                  StateSetter setState) {
                                                return ListView(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 150),
                                                      child: Container(
                                                          width: 42,
                                                          height: 5,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          100),
                                                              color: ColorsManger
                                                                  .newColor)),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Center(
                                                      child: Text("أضف ملاحظتك",
                                                          style: FontsManger
                                                                  .largeFont(
                                                                      context)
                                                              ?.copyWith(
                                                                  fontSize: 16,
                                                                  color: const Color(
                                                                      0xff242126))),
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    TextFormWidget(
                                                      label: "اكتب ملاحظتك",
                                                      controller: note,
                                                      maxLine: 7,
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          right: context.width *
                                                              .5),
                                                      child: ElevatedButton(
                                                          style: Theme.of(
                                                                  context)
                                                              .elevatedButtonTheme
                                                              .style
                                                              ?.copyWith(
                                                                  backgroundColor:
                                                                      const MaterialStatePropertyAll(
                                                                          Color(
                                                                              0xff313131)),
                                                                  shape: const MaterialStatePropertyAll(
                                                                      StadiumBorder()),
                                                                  fixedSize:
                                                                      MaterialStatePropertyAll(Size(
                                                                          context.width *
                                                                              .1,
                                                                          39))),
                                                          onPressed: () {
                                                            context.appCuibt
                                                                .addNotes(
                                                                    subjectName:
                                                                        widget
                                                                            .subjectName,
                                                                    doctorName:
                                                                        widget
                                                                            .doctorName,
                                                                    lectureName:
                                                                        widget
                                                                            .lectureName,
                                                                    notes: note
                                                                        .text)
                                                                .then((value) {
                                                              Navigator.pop(
                                                                  context);
                                                              context.appCuibt
                                                                  .getNotes(
                                                                subjectName: widget
                                                                    .subjectName,
                                                                doctorName: widget
                                                                    .doctorName,
                                                                lectureName: widget
                                                                    .lectureName,
                                                              );
                                                              note.clear();
                                                            });
                                                          },
                                                          child: const Text(
                                                              "اضف ملاحظتك")),
                                                    )
                                                  ],
                                                );
                                              },
                                            ),
                                          );
                                        });
                                  },
                                  child: const Text("أضف ملاحظة")),
                            )
                          ],
                        ),
                      ),
                    if (context.appCuibt.notes.isNotEmpty)
                      Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                                padding: const EdgeInsets.all(20),
                                itemBuilder: (context, i) => InkWell(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            useRootNavigator: false,
                                            builder: (ctx) => Dialog(
                                                  insetPadding: EdgeInsets.zero,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                  elevation: 5,
                                                  backgroundColor: Colors.black
                                                      .withOpacity(.2),
                                                  child: Container(
                                                    height: context.height,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10,
                                                        vertical: 15),
                                                    width: context.width,
                                                    decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xffF2F2F2),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12)),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        InkWell(
                                                            onTap: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Icon(
                                                                Icons.close)),
                                                        const SizedBox(
                                                          height: 20,
                                                        ),
                                                        Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Container(
                                                                  width: 40,
                                                                  height: 40,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                      color: const Color(
                                                                          0xffEBE2EC)),
                                                                  child: SvgPicture.asset(
                                                                      "assets/image/caution (1).svg",
                                                                      fit: BoxFit
                                                                          .none,
                                                                      height:
                                                                          30,
                                                                      width:
                                                                          30),
                                                                ),
                                                                const SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                        context
                                                                            .appCuibt
                                                                            .user!
                                                                            .name,
                                                                        style: FontsManger.largeFont(context)?.copyWith(
                                                                            fontSize:
                                                                                13)),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text(
                                                              context.appCuibt
                                                                          .notes[i]
                                                                      [
                                                                      "text"] ??
                                                                  "",
                                                              style: FontsManger
                                                                      .mediumFont(
                                                                          context)
                                                                  ?.copyWith(
                                                                      color: const Color(
                                                                          0xff3E3E3E),
                                                                      fontSize:
                                                                          12),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ));
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 15),
                                        width: context.width,
                                        decoration: const BoxDecoration(
                                            color: Color(0xffF2F2F2)),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  width: 40,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      color: const Color(
                                                          0xffEBE2EC)),
                                                  child: SvgPicture.asset(
                                                      "assets/image/caution (1).svg",
                                                      fit: BoxFit.none,
                                                      height: 30,
                                                      width: 30),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        context.appCuibt.user!
                                                            .name,
                                                        style: FontsManger
                                                                .largeFont(
                                                                    context)
                                                            ?.copyWith(
                                                                fontSize: 13)),
                                                  ],
                                                ),
                                                const Spacer(),
                                                Row(
                                                  children: [
                                                    IconButton(
                                                        onPressed: () {
                                                          note.text = context
                                                              .appCuibt
                                                              .notes[i]["text"];
                                                          showModalBottomSheet(
                                                              enableDrag: true,
                                                              isDismissible:
                                                                  true,
                                                              isScrollControlled:
                                                                  true,
                                                              constraints: BoxConstraints(
                                                                  minHeight:
                                                                      context.height *
                                                                          .5,
                                                                  maxHeight:
                                                                      context.height *
                                                                          .5),
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return Container(
                                                                  height: context
                                                                      .height,
                                                                  width: context
                                                                      .width,
                                                                  decoration: const BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      borderRadius:
                                                                          BorderRadius.vertical(
                                                                              top: Radius.circular(36))),
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          22,
                                                                      vertical:
                                                                          10),
                                                                  child:
                                                                      StatefulBuilder(
                                                                    builder: (BuildContext
                                                                            context,
                                                                        StateSetter
                                                                            setState) {
                                                                      return ListView(
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.symmetric(horizontal: 150),
                                                                            child: Container(
                                                                                width: 42,
                                                                                height: 5,
                                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: ColorsManger.newColor)),
                                                                          ),
                                                                          const SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          Center(
                                                                            child:
                                                                                Text("عدل ملاحظتك ملاحظتك", style: FontsManger.largeFont(context)?.copyWith(fontSize: 16, color: const Color(0xff242126))),
                                                                          ),
                                                                          const SizedBox(
                                                                            height:
                                                                                20,
                                                                          ),
                                                                          TextFormWidget(
                                                                            label:
                                                                                "اكتب ملاحظتك",
                                                                            controller:
                                                                                note,
                                                                            maxLine:
                                                                                7,
                                                                          ),
                                                                          const SizedBox(
                                                                            height:
                                                                                20,
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.only(right: context.width * .5),
                                                                            child: ElevatedButton(
                                                                                style: Theme.of(context).elevatedButtonTheme.style?.copyWith(backgroundColor: const MaterialStatePropertyAll(Color(0xff313131)), shape: const MaterialStatePropertyAll(StadiumBorder()), fixedSize: MaterialStatePropertyAll(Size(context.width * .1, 39))),
                                                                                onPressed: () {
                                                                                  context.appCuibt.editNotes(subjectName: widget.subjectName, doctorName: widget.doctorName, lectureName: widget.lectureName, note: note.text, id: context.appCuibt.notes[i]["id"]).then((value) {
                                                                                    Navigator.pop(context);
                                                                                    context.appCuibt.getNotes(
                                                                                      subjectName: widget.subjectName,
                                                                                      doctorName: widget.doctorName,
                                                                                      lectureName: widget.lectureName,
                                                                                    );
                                                                                    note.clear();
                                                                                  });
                                                                                },
                                                                                child: const Text("عدل ملاحظتك")),
                                                                          )
                                                                        ],
                                                                      );
                                                                    },
                                                                  ),
                                                                );
                                                              });
                                                        },
                                                        icon: const Icon(
                                                          Icons.edit,
                                                          color: ColorsManger
                                                              .newColor,
                                                        )),
                                                    IconButton(
                                                        onPressed: () {
                                                          context.appCuibt
                                                              .deleteNotes(
                                                                  subjectName:
                                                                      widget
                                                                          .subjectName,
                                                                  doctorName: widget
                                                                      .doctorName,
                                                                  lectureName:
                                                                      widget
                                                                          .lectureName,
                                                                  id: context
                                                                          .appCuibt
                                                                          .notes[
                                                                      i]["id"])
                                                              .then((value) =>
                                                                  getData());
                                                        },
                                                        icon: const Icon(
                                                          Icons.delete,
                                                          color: ColorsManger
                                                              .newColor,
                                                        )),
                                                  ],
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              context.appCuibt.notes[i]
                                                      ["text"] ??
                                                  "",
                                              style: FontsManger.mediumFont(
                                                      context)
                                                  ?.copyWith(
                                                      color: const Color(
                                                          0xff3E3E3E),
                                                      fontSize: 12),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                separatorBuilder: (context, i) =>
                                    const SizedBox(height: 10),
                                itemCount: context.appCuibt.notes.length),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: context.width * .6, left: 20),
                            child: Center(
                              child: ElevatedButton(
                                  style: Theme.of(context)
                                      .elevatedButtonTheme
                                      .style
                                      ?.copyWith(
                                          backgroundColor:
                                              const MaterialStatePropertyAll(
                                                  Color(0xff313131)),
                                          shape: const MaterialStatePropertyAll(
                                              StadiumBorder()),
                                          fixedSize: MaterialStatePropertyAll(
                                              Size(context.width * .8, 45))),
                                  onPressed: () {
                                    showModalBottomSheet(
                                        enableDrag: true,
                                        isDismissible: true,
                                        isScrollControlled: true,
                                        constraints: BoxConstraints(
                                            minHeight: context.height * .5,
                                            maxHeight: context.height * .5),
                                        context: context,
                                        builder: (context) {
                                          return Container(
                                            height: context.height,
                                            width: context.width,
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                        top: Radius.circular(
                                                            36))),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 22, vertical: 10),
                                            child: StatefulBuilder(
                                              builder: (BuildContext context,
                                                  StateSetter setState) {
                                                return ListView(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 150),
                                                      child: Container(
                                                          width: 42,
                                                          height: 5,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          100),
                                                              color: ColorsManger
                                                                  .newColor)),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Center(
                                                      child: Text("أضف ملاحظتك",
                                                          style: FontsManger
                                                                  .largeFont(
                                                                      context)
                                                              ?.copyWith(
                                                                  fontSize: 16,
                                                                  color: const Color(
                                                                      0xff242126))),
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    TextFormWidget(
                                                      label: "اكتب ملاحظتك",
                                                      controller: note,
                                                      maxLine: 7,
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          right: context.width *
                                                              .5),
                                                      child: ElevatedButton(
                                                          style: Theme.of(
                                                                  context)
                                                              .elevatedButtonTheme
                                                              .style
                                                              ?.copyWith(
                                                                  backgroundColor:
                                                                      const MaterialStatePropertyAll(
                                                                          Color(
                                                                              0xff313131)),
                                                                  shape: const MaterialStatePropertyAll(
                                                                      StadiumBorder()),
                                                                  fixedSize:
                                                                      MaterialStatePropertyAll(Size(
                                                                          context.width *
                                                                              .1,
                                                                          39))),
                                                          onPressed: () {
                                                            context.appCuibt
                                                                .addNotes(
                                                                    subjectName:
                                                                        widget
                                                                            .subjectName,
                                                                    doctorName:
                                                                        widget
                                                                            .doctorName,
                                                                    lectureName:
                                                                        widget
                                                                            .lectureName,
                                                                    notes: note
                                                                        .text)
                                                                .then((value) {
                                                              Navigator.pop(
                                                                  context);
                                                              context.appCuibt
                                                                  .getNotes(
                                                                subjectName: widget
                                                                    .subjectName,
                                                                doctorName: widget
                                                                    .doctorName,
                                                                lectureName: widget
                                                                    .lectureName,
                                                              );
                                                              note.clear();
                                                            });
                                                          },
                                                          child: const Text(
                                                              "اضف ملاحظتك")),
                                                    )
                                                  ],
                                                );
                                              },
                                            ),
                                          );
                                        });
                                  },
                                  child: const Text("أضف ملاحظة")),
                            ),
                          )
                        ],
                      ),
                    //pdf
                    if (context.appCuibt.q.isEmpty)
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "لم تقم بإضافة أي سؤال",
                              style: FontsManger.largeFont(context)?.copyWith(
                                  fontSize: 14, color: const Color(0xff242126)),
                            ),
                            Center(
                              child: Image.asset(
                                fit: BoxFit.cover,
                                height: 287,
                                "assets/image/4025692.png",
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            Center(
                              child: ElevatedButton(
                                  style: Theme.of(context)
                                      .elevatedButtonTheme
                                      .style
                                      ?.copyWith(
                                          backgroundColor:
                                              const MaterialStatePropertyAll(
                                                  Color(0xff313131)),
                                          shape: const MaterialStatePropertyAll(
                                              StadiumBorder()),
                                          fixedSize: MaterialStatePropertyAll(
                                              Size(context.width * .8, 45))),
                                  onPressed: () {
                                    showModalBottomSheet(
                                        enableDrag: true,
                                        isDismissible: true,
                                        isScrollControlled: true,
                                        constraints: BoxConstraints(
                                            minHeight: context.height * .5,
                                            maxHeight: context.height * .5),
                                        context: context,
                                        builder: (context) {
                                          return Container(
                                            height: context.height,
                                            width: context.width,
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                        top: Radius.circular(
                                                            36))),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 22, vertical: 10),
                                            child: StatefulBuilder(
                                              builder: (BuildContext context,
                                                  StateSetter setState) {
                                                return ListView(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 150),
                                                      child: Container(
                                                          width: 42,
                                                          height: 5,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          100),
                                                              color: ColorsManger
                                                                  .newColor)),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Center(
                                                      child: Text("أضف سؤالك",
                                                          style: FontsManger
                                                                  .largeFont(
                                                                      context)
                                                              ?.copyWith(
                                                                  fontSize: 16,
                                                                  color: const Color(
                                                                      0xff242126))),
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    TextFormWidget(
                                                      label: "اكتب سؤالك",
                                                      controller: note,
                                                      maxLine: 7,
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          right: context.width *
                                                              .5),
                                                      child: ElevatedButton(
                                                          style: Theme.of(
                                                                  context)
                                                              .elevatedButtonTheme
                                                              .style
                                                              ?.copyWith(
                                                                  backgroundColor:
                                                                      const MaterialStatePropertyAll(
                                                                          Color(
                                                                              0xff313131)),
                                                                  shape: const MaterialStatePropertyAll(
                                                                      StadiumBorder()),
                                                                  fixedSize:
                                                                      MaterialStatePropertyAll(Size(
                                                                          context.width *
                                                                              .1,
                                                                          39))),
                                                          onPressed: () {
                                                            context.appCuibt
                                                                .addQ(
                                                                    subjectName:
                                                                        widget
                                                                            .subjectName,
                                                                    doctorName:
                                                                        widget
                                                                            .doctorName,
                                                                    lectureName:
                                                                        widget
                                                                            .lectureName,
                                                                    q: note
                                                                        .text,
                                                                    min: controller
                                                                        .currentVideoPosition
                                                                        .inMinutes)
                                                                .then((value) {
                                                              Navigator.pop(
                                                                  context);
                                                              context.appCuibt.getQ(
                                                                  subjectName:
                                                                      widget
                                                                          .subjectName,
                                                                  doctorName: widget
                                                                      .doctorName,
                                                                  lectureName:
                                                                      widget
                                                                          .lectureName,
                                                                  context:
                                                                      context);
                                                            });
                                                          },
                                                          child: const Text(
                                                              "اضف سؤالك")),
                                                    )
                                                  ],
                                                );
                                              },
                                            ),
                                          );
                                        });
                                  },
                                  child: const Text("أضف سؤالك")),
                            )
                          ],
                        ),
                      ),
                    if (context.appCuibt.q.isNotEmpty)
                      Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                                padding: const EdgeInsets.all(20),
                                itemBuilder: (context, i) => QWidget(
                                    q: context.appCuibt.q[i],
                                    lectureName: widget.lectureName,
                                    doctorName: widget.doctorName,
                                    subjectName: widget.subjectName),
                                separatorBuilder: (context, i) =>
                                    const SizedBox(height: 10),
                                itemCount: context.appCuibt.q.length),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: context.width * .6, left: 20),
                            child: Center(
                              child: ElevatedButton(
                                  style: Theme.of(context)
                                      .elevatedButtonTheme
                                      .style
                                      ?.copyWith(
                                          backgroundColor:
                                              const MaterialStatePropertyAll(
                                                  Color(0xff313131)),
                                          shape: const MaterialStatePropertyAll(
                                              StadiumBorder()),
                                          fixedSize: MaterialStatePropertyAll(
                                              Size(context.width * .8, 45))),
                                  onPressed: () {
                                    showModalBottomSheet(
                                        enableDrag: true,
                                        isDismissible: true,
                                        isScrollControlled: true,
                                        constraints: BoxConstraints(
                                            minHeight: context.height * .5,
                                            maxHeight: context.height * .5),
                                        context: context,
                                        builder: (context) {
                                          return Container(
                                            height: context.height,
                                            width: context.width,
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                        top: Radius.circular(
                                                            36))),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 22, vertical: 10),
                                            child: StatefulBuilder(
                                              builder: (BuildContext context,
                                                  StateSetter setState) {
                                                return ListView(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 150),
                                                      child: Container(
                                                          width: 42,
                                                          height: 5,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          100),
                                                              color: ColorsManger
                                                                  .newColor)),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Center(
                                                      child: Text("أضف سؤالك",
                                                          style: FontsManger
                                                                  .largeFont(
                                                                      context)
                                                              ?.copyWith(
                                                                  fontSize: 16,
                                                                  color: const Color(
                                                                      0xff242126))),
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    TextFormWidget(
                                                      label: "اكتب سؤالك",
                                                      controller: note,
                                                      maxLine: 7,
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          right: context.width *
                                                              .5),
                                                      child: ElevatedButton(
                                                          style: Theme.of(
                                                                  context)
                                                              .elevatedButtonTheme
                                                              .style
                                                              ?.copyWith(
                                                                  backgroundColor:
                                                                      const MaterialStatePropertyAll(
                                                                          Color(
                                                                              0xff313131)),
                                                                  shape: const MaterialStatePropertyAll(
                                                                      StadiumBorder()),
                                                                  fixedSize:
                                                                      MaterialStatePropertyAll(Size(
                                                                          context.width *
                                                                              .1,
                                                                          39))),
                                                          onPressed: () {
                                                            context.appCuibt
                                                                .addQ(
                                                                    subjectName:
                                                                        widget
                                                                            .subjectName,
                                                                    doctorName:
                                                                        widget
                                                                            .doctorName,
                                                                    lectureName:
                                                                        widget
                                                                            .lectureName,
                                                                    q: note
                                                                        .text,
                                                                    min: controller
                                                                        .currentVideoPosition
                                                                        .inMinutes)
                                                                .then((value) {
                                                              Navigator.pop(
                                                                  context);
                                                              getData();
                                                              note.clear();
                                                            });
                                                          },
                                                          child: const Text(
                                                              "اضف سؤالك")),
                                                    )
                                                  ],
                                                );
                                              },
                                            ),
                                          );
                                        });
                                  },
                                  child: const Text("اضف سؤالك")),
                            ),
                          )
                        ],
                      ),
                  ],
                ));
              })
            ],
          ),
        ),
      ),
    );
  }
}
