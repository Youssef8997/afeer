import 'dart:io';

import 'package:afeer/cuibt/app_cuibt.dart';
import 'package:afeer/cuibt/app_state.dart';
import 'package:afeer/utls/extension.dart';
import 'package:afeer/utls/manger/color_manger.dart';
import 'package:afeer/utls/manger/font_manger.dart';
import 'package:afeer/views/lecture_views/screens/video_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';

import '../../../pdf_view.dart';
import '../../../utls/widget/base_widget.dart';
import '../widget/exam.dart';

class DoctorScreen extends StatefulWidget {
  final String subjectName;
  final String info;
  final String time;
  final String imagePath;
  final String? year;
  final bool? add;
  final bool isRev;

  const DoctorScreen(
      {super.key,
      required this.subjectName,
      this.add,
      this.year,
      this.isRev = false,
      required this.imagePath,
      required this.info,
      required this.time});

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen>
    with SingleTickerProviderStateMixin {
  late TabController tab;
  List<Map> pdfs = [];
  List<Map> exam = [];
  String path = "";
  String doctorName = "";
  int minOfSubject = 0;
  int hourOfSubject = 0;

  getData() async {
    await getApplicationDocumentsDirectory().then((value) {
      path = value.path;
    });
  }

  @override
  void initState() {
    getData();
    tab = TabController(
      initialIndex: 0,
      length: 4,
      vsync: this,
    );
    context.appCuibt.lectureList = [];
    if (widget.add == true) {
      context.appCuibt.lectureList = context.appCuibt.lectureAdditionalList;
      context.appCuibt.doctorList = [];
      context.appCuibt.getLecturesAdditional(widget.subjectName).then((value) {
        pdfs = [];
        for (var e in context.appCuibt.lectureList) {
          for (var element in e.pdfLinks!) {
            pdfs.add({"name": e.name, "det": e.details, "link": element});
          }
        }

        setState(() {});
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AppCubit, AppState>(
        builder: (context, state) {
          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const CircleAvatar(
                          backgroundColor: ColorsManger.text3,
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          )),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "تفاصيل المادة",
                      style: FontsManger.largeFont(context)?.copyWith(
                          color: const Color(0xff242126), fontSize: 15),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                height: doctorName == "" ? 187 : 0,
                width: context.width * .95,
                child: CachedNetworkImage(
                  width: context.width * .95,
                  height: 187,
                  fit: BoxFit.fill,
                  imageUrl: widget.imagePath,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      "نبذة عن المادة",
                      style: FontsManger.largeFont(context)?.copyWith(
                          color: ColorsManger.newColor, fontSize: 15),
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      widget.info,
                      style: FontsManger.mediumFont(context)?.copyWith(
                          color: const Color(0xff3E3E3E), fontSize: 11),
                    )),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: ColorsManger.newColor,
                          size: 17,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "5.0",
                          style: FontsManger.mediumFont(context)?.copyWith(
                              fontSize: 11, color: const Color(0xff3E3E3E)),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    if (minOfSubject != 0 || hourOfSubject != 0)
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time_filled_outlined,
                            color: ColorsManger.newColor,
                            size: 17,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "ساعات ${hourOfSubject} دقائق ${minOfSubject}",
                            style: FontsManger.mediumFont(context)?.copyWith(
                                fontSize: 11, color: const Color(0xff3E3E3E)),
                          )
                        ],
                      ),
                  ],
                ),
              ),
              if (context.appCuibt.doctorList.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        "محاضر المادة",
                        style: FontsManger.largeFont(context)?.copyWith(
                            color: ColorsManger.newColor, fontSize: 15),
                      )),
                ),
              if (context.appCuibt.doctorList.isNotEmpty)
                for (int i = 0; i < context.appCuibt.doctorList.length; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 3.5, horizontal: 16),
                    child: InkWell(
                      onTap: () {
                        minOfSubject = 0;
                        hourOfSubject = 0;
                        if (widget.add == true) {
                          context.appCuibt
                              .getAddLectures(
                                  doctor: context.appCuibt.doctorList[i],
                                  subjectName: widget.subjectName,
                                  year: widget.year)
                              .then((value) {
                            doctorName = context.appCuibt.doctorList[i];
                            pdfs = [];
                            for (var e in context.appCuibt.lectureList) {
                              for (var element in e.pdfLinks!) {
                                pdfs.add({
                                  "name": e.name,
                                  "det": e.details,
                                  "link": element
                                });
                              }
                            }

                            setState(() {});
                          });
                        } else {
                          if (context.appCuibt.isVisitor) {
                            context.appCuibt
                                .getLecturesV(
                                    doctor: context.appCuibt.doctorList[i],
                                    subjectName: widget.subjectName)
                                .then((value) {
                              doctorName = context.appCuibt.doctorList[i];

                              pdfs = [];

                              for (var e in context.appCuibt.lectureList) {
                                for (var element in e.pdfLinks!) {
                                  pdfs.add({
                                    "name": e.name,
                                    "det": e.details,
                                    "link": element
                                  });
                                }
                              }

                              setState(() {});
                            });
                          } else {
                            doctorName = context.appCuibt.doctorList[i];

                            context.appCuibt
                                .getLectures(
                                    doctor: context.appCuibt.doctorList[i],
                                    subjectName: widget.subjectName)
                                .then((value) {
                              pdfs = [];
                              exam = [];

                              for (var e in context.appCuibt.lectureList) {
                                for (var element in e.pdfLinks!) {
                                  pdfs.add({
                                    "name": e.name,
                                    "det": e.details,
                                    "link": element
                                  });
                                }
                                for (var ew in e.exam ?? []) {
                                  exam.add({
                                    "name": e.name,
                                    "det": e.details,
                                    "link": ew
                                  });
                                }
                                if (e.videoLink?["time"] != "0") {
                                  minOfSubject = int.parse(
                                          e.videoLink?["time"].toString() ??
                                              "0") +
                                      minOfSubject;
                                  if (minOfSubject >= 60) {
                                    hourOfSubject++;
                                    minOfSubject = minOfSubject - 60;
                                  }
                                }
                              }

                              setState(() {});
                            });
                          }
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 23, vertical: 6),
                        height: 33,
                        width: context.width,
                        decoration: BoxDecoration(
                          color: ColorsManger.newColor.withOpacity(.13),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(context.appCuibt.doctorList[i],
                            style: FontsManger.mediumFont(context)?.copyWith(
                                color: const Color(0xff2B2B2B), fontSize: 14)),
                      ),
                    ),
                  ),
              if (context.appCuibt.lectureList.isEmpty && doctorName != "")
                const Center(
                    heightFactor: 5,
                    child: Text("عفوا لا يوجد حتي الان محاضرات مضافه")),
              if (context.appCuibt.lectureList.isNotEmpty)
                TabBar(
                    indicatorColor: const Color(0xff65256E),
                    tabs: const [
                      Tab(
                        text: "الفيديو",
                      ),
                      Tab(
                        text: "الملزمة",
                      ),
                      Tab(
                        text: "تنبيهات المدرج",
                      ),
                      Tab(
                        text: "إختبارات",
                      ),
                    ],
                    controller: tab,
                    labelColor: const Color(0xff2B2B2B),
                    indicatorWeight: 3,
                    isScrollable: true,
                    indicatorPadding:
                        const EdgeInsets.symmetric(horizontal: 20),
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelStyle: FontsManger.largeFont(context)?.copyWith(
                        fontSize: 12, color: const Color(0xff2B2B2B))),
              AnimatedContainer(
                  duration: const Duration(milliseconds: 600),
                  height: doctorName == ""
                      ? context.height * .3
                      : context.height * .7,
                  width: context.width,
                  child: TabBarView(
                    controller: tab,
                    children: [
                      //video
                      ListView.separated(
                          padding: const EdgeInsets.all(20),
                          itemBuilder: (context, i) {
                            if (context.appCuibt.lectureList[i].videoLink !=
                                    null &&
                                context.appCuibt.lectureList[i]
                                        .videoLink?["link"] !=
                                    "" &&
                                context.appCuibt.lectureList[i]
                                        .videoLink?["link"] !=
                                    null) {
                              return InkWell(
                                onTap: () {
                                  if (Platform.isIOS &&
                                      context.appCuibt.home.applePay) {
                                    navigatorWid(
                                        page: VideoScreen(
                                          subjectName: widget.subjectName,
                                          lectureName: context
                                              .appCuibt.lectureList[i].name,
                                          doctorName: doctorName,
                                          pdfs: pdfs,
                                          videoId: context
                                              .appCuibt
                                              .lectureList[i]
                                              .videoLink!["link"],
                                        ),
                                        returnPage: true,
                                        context: context);
                                  } else {
                                    if (context.appCuibt.user?.subscription !=
                                        null) {
                                      if (context.appCuibt.user?.subscription!
                                              .isASingleSubject ==
                                          true) {
                                        if (context.appCuibt.user?.subscription!
                                                .singleSubject!
                                                .contains(widget.subjectName) ==
                                            true) {
                                          navigatorWid(
                                              page: VideoScreen(
                                                subjectName: widget.subjectName,
                                                lectureName: context.appCuibt
                                                    .lectureList[i].name,
                                                doctorName: doctorName,
                                                pdfs: pdfs,
                                                videoId: context
                                                    .appCuibt
                                                    .lectureList[i]
                                                    .videoLink!["link"],
                                              ),
                                              returnPage: true,
                                              context: context);
                                        } else {
                                          final snackBar = SnackBar(
                                            backgroundColor: Colors.red,
                                            content: Text(
                                                'انت غير مشترك برجاء التواصل مع خدمه العملاء',
                                                style: FontsManger.largeFont(
                                                        context)
                                                    ?.copyWith(
                                                        color: ColorsManger
                                                            .white)),
                                            showCloseIcon: true,
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        }
                                      } else {
                                        navigatorWid(
                                            page: VideoScreen(
                                              subjectName: widget.subjectName,
                                              lectureName: context
                                                  .appCuibt.lectureList[i].name,
                                              doctorName: doctorName,
                                              pdfs: pdfs,
                                              videoId: context
                                                  .appCuibt
                                                  .lectureList[i]
                                                  .videoLink!["link"],
                                            ),
                                            returnPage: true,
                                            context: context);
                                      }
                                    } else {
                                      if (i == 0) {
                                        navigatorWid(
                                            page: VideoScreen(
                                              subjectName: widget.subjectName,
                                              lectureName: context
                                                  .appCuibt.lectureList[i].name,
                                              doctorName: doctorName,
                                              pdfs: pdfs,
                                              videoId: context
                                                  .appCuibt
                                                  .lectureList[i]
                                                  .videoLink!["link"],
                                            ),
                                            returnPage: true,
                                            context: context);
                                      } else {
                                        final snackBar = SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text(
                                              'انت غير مشترك برجاء التواصل مع خدمه العملاء',
                                              style:
                                                  FontsManger.largeFont(context)
                                                      ?.copyWith(
                                                          color: ColorsManger
                                                              .white)),
                                          showCloseIcon: true,
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      }
                                    }
                                  }
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 10),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 0),
                                  height: 56,
                                  width: context.width,
                                  decoration: const BoxDecoration(
                                      color: Color(0xffF2F2F2)),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 40,
                                        width: 40,
                                        alignment: Alignment.bottomCenter,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: const Color(0xffEBE2EC)),
                                        child: Image.asset(
                                            "assets/image/video-camera.png",
                                            color: ColorsManger.newColor,
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
                                              context
                                                  .appCuibt.lectureList[i].name,
                                              style:
                                                  FontsManger.largeFont(context)
                                                      ?.copyWith(fontSize: 13)),
                                          Text(
                                              context.appCuibt.lectureList[i]
                                                  .details,
                                              style: FontsManger.mediumFont(
                                                      context)
                                                  ?.copyWith(
                                                      fontSize: 9,
                                                      color: const Color(
                                                              0xff242126)
                                                          .withOpacity(.65))),
                                        ],
                                      ),
                                      const Spacer(),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.access_time_filled,
                                            size: 18,
                                            color: ColorsManger.newColor,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "${context.appCuibt.lectureList[i].videoLink!["time"]}:00 دقائق",
                                            style:
                                                FontsManger.mediumFont(context)
                                                    ?.copyWith(
                                                        fontSize: 10,
                                                        color: const Color(
                                                            0xff3E3E3E)),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return const SizedBox();
                            }
                          },
                          separatorBuilder: (context, i) =>
                              const SizedBox(height: 0),
                          itemCount: context.appCuibt.lectureList.length),
                      //pdf
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
                                                          height:
                                                              context.height,
                                                          child: PdfView(
                                                              pdfLink: pdfs[i]
                                                                  ["link"])));
                                                },
                                              );
                                            }));
                                  } else {
                                    if (context.appCuibt.user?.subscription !=
                                        null) {
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
                                              builder:
                                                  (ctx) => BlocBuilder<AppCubit,
                                                              AppState>(
                                                          builder:
                                                              (context, state) {
                                                        return OrientationBuilder(
                                                          builder:
                                                              (context, o) {
                                                            if (o ==
                                                                Orientation
                                                                    .landscape) {
                                                              context.appCuibt
                                                                  .change();
                                                            }
                                                            if (o !=
                                                                Orientation
                                                                    .landscape) {
                                                              context.appCuibt
                                                                  .change();
                                                            }
                                                            return Dialog(
                                                                insetPadding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                elevation: 5,
                                                                backgroundColor:
                                                                    Colors.black
                                                                        .withOpacity(
                                                                            .2),
                                                                child: SizedBox(
                                                                    width: context
                                                                        .width,
                                                                    height: context
                                                                        .height,
                                                                    child: PdfView(
                                                                        pdfLink:
                                                                            pdfs[i]["link"])));
                                                          },
                                                        );
                                                      }));
                                        } else {
                                          final snackBar = SnackBar(
                                            backgroundColor: Colors.red,
                                            content: Text(
                                                'انت غير مشترك برجاء التواصل مع خدمه العملاء',
                                                style: FontsManger.largeFont(
                                                        context)
                                                    ?.copyWith(
                                                        color: ColorsManger
                                                            .white)),
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
                                                      if (o ==
                                                          Orientation
                                                              .landscape) {
                                                        context.appCuibt
                                                            .change();
                                                      }
                                                      if (o !=
                                                          Orientation
                                                              .landscape) {
                                                        context.appCuibt
                                                            .change();
                                                      }
                                                      return Dialog(
                                                          insetPadding:
                                                              EdgeInsets.zero,
                                                          elevation: 5,
                                                          backgroundColor:
                                                              Colors.black
                                                                  .withOpacity(
                                                                      .2),
                                                          child: SizedBox(
                                                              width:
                                                                  context.width,
                                                              height: context
                                                                  .height,
                                                              child: PdfView(
                                                                  pdfLink: pdfs[
                                                                          i][
                                                                      "link"])));
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
                                                      if (o ==
                                                          Orientation
                                                              .landscape) {
                                                        context.appCuibt
                                                            .change();
                                                      }
                                                      if (o !=
                                                          Orientation
                                                              .landscape) {
                                                        context.appCuibt
                                                            .change();
                                                      }
                                                      return Dialog(
                                                          insetPadding:
                                                              EdgeInsets.zero,
                                                          elevation: 5,
                                                          backgroundColor:
                                                              Colors.black
                                                                  .withOpacity(
                                                                      .2),
                                                          child: SizedBox(
                                                              width:
                                                                  context.width,
                                                              height: context
                                                                  .height,
                                                              child: PdfView(
                                                                  pdfLink: pdfs[
                                                                          i][
                                                                      "link"])));
                                                    },
                                                  );
                                                }));
                                      } else {
                                        final snackBar = SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text(
                                              'انت غير مشترك برجاء التواصل مع خدمه العملاء',
                                              style:
                                                  FontsManger.largeFont(context)
                                                      ?.copyWith(
                                                          color: ColorsManger
                                                              .white)),
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
                                  decoration: const BoxDecoration(
                                      color: Color(0xffF2F2F2)),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: const Color(0xffEBE2EC)),
                                        child: SvgPicture.asset(
                                            "assets/image/agenda.svg",
                                            fit: BoxFit.none),
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
                                          Text(pdfs[i]["name"],
                                              style:
                                                  FontsManger.largeFont(context)
                                                      ?.copyWith(fontSize: 13)),
                                          Text(pdfs[i]["det"],
                                              style: FontsManger.mediumFont(
                                                      context)
                                                  ?.copyWith(
                                                      fontSize: 9,
                                                      color: const Color(
                                                              0xff242126)
                                                          .withOpacity(.65))),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          separatorBuilder: (context, i) =>
                              const SizedBox(height: 10),
                          itemCount: pdfs.length),
                      // alerts
                      ListView.separated(
                          padding: const EdgeInsets.all(20),
                          itemBuilder: (context, i) {
                            if (context.appCuibt.lectureList[i].alerts != "" &&
                                context.appCuibt.lectureList[i].alerts !=
                                    null) {
                              return InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      useRootNavigator: false,
                                      builder: (ctx) => Dialog(
                                            insetPadding: EdgeInsets.zero,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            elevation: 5,
                                            backgroundColor:
                                                Colors.black.withOpacity(.2),
                                            child: Container(
                                              height: context.height,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 15),
                                              width: context.width,
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xffF2F2F2),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  InkWell(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Icon(
                                                          Icons.close)),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width: 40,
                                                        height: 40,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
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
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                              context
                                                                  .appCuibt
                                                                  .lectureList[
                                                                      i]
                                                                  .name,
                                                              style: FontsManger
                                                                      .largeFont(
                                                                          context)
                                                                  ?.copyWith(
                                                                      fontSize:
                                                                          13)),
                                                          Text(
                                                              context
                                                                  .appCuibt
                                                                  .lectureList[
                                                                      i]
                                                                  .details,
                                                              style: FontsManger
                                                                      .mediumFont(
                                                                          context)
                                                                  ?.copyWith(
                                                                      fontSize:
                                                                          9,
                                                                      color: const Color(
                                                                              0xff242126)
                                                                          .withOpacity(
                                                                              .65))),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    context
                                                            .appCuibt
                                                            .lectureList[i]
                                                            .alerts ??
                                                        "",
                                                    style: FontsManger
                                                            .mediumFont(context)
                                                        ?.copyWith(
                                                            color: const Color(
                                                                0xff3E3E3E),
                                                            fontSize: 12,
                                                            height: 2),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ));
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 15),
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
                                                    BorderRadius.circular(8),
                                                color: const Color(0xffEBE2EC)),
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
                                                  context.appCuibt
                                                      .lectureList[i].name,
                                                  style: FontsManger.largeFont(
                                                          context)
                                                      ?.copyWith(fontSize: 13)),
                                              Text(
                                                  context.appCuibt
                                                      .lectureList[i].details,
                                                  style: FontsManger.mediumFont(
                                                          context)
                                                      ?.copyWith(
                                                    fontSize: 9,
                                                    color:
                                                        const Color(0xff242126)
                                                            .withOpacity(.65),
                                                  )),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        context.appCuibt.lectureList[i]
                                                .alerts ??
                                            "",
                                        style: FontsManger.mediumFont(context)
                                            ?.copyWith(
                                                color: const Color(0xff3E3E3E),
                                                fontSize: 12,
                                                height: 1.3),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }
                          },
                          separatorBuilder: (context, i) =>
                              const SizedBox(height: 10),
                          itemCount: context.appCuibt.lectureList.length),
                      ListView.separated(
                          padding: const EdgeInsets.all(20),
                          itemBuilder: (context, i) {
                            return ExamDWidget(
                              det: exam[i]["det"],
                              name: exam[i]["name"],
                              link: exam[i]["link"],
                            );
                          },
                          separatorBuilder: (context, i) =>
                              const SizedBox(height: 0),
                          itemCount: exam.length),
                    ],
                  ))
            ],
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
