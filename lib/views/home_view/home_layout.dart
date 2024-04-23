import 'dart:convert';
import 'dart:io';

import 'package:afeer/cuibt/app_cuibt.dart';
import 'package:afeer/cuibt/app_state.dart';
import 'package:afeer/utls/extension.dart';
import 'package:afeer/utls/manger/font_manger.dart';
import 'package:afeer/utls/widget/base_widget.dart';
import 'package:afeer/views/home_view/widget/add_subject_widget.dart';
import 'package:afeer/views/home_view/widget/additional_subject_widget.dart';
import 'package:afeer/views/home_view/widget/fun_widget.dart';
import 'package:afeer/views/home_view/widget/new_add_widget.dart';
import 'package:afeer/views/home_view/widget/subjects_widget.dart';
import 'package:afeer/views/home_view/widget/subscription_widget.dart';
import 'package:afeer/views/lecture_views/screens/video_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../data/local_data.dart';
import '../../utls/manger/color_manger.dart';
import '../dif_lec_view/diff_widget.dart';
import '../notification_view/screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  // late final PodPlayerController controller;
  Map? lastData = null;
  late AnimationController _animationController;

  Future<void> data(BuildContext context) async {
    await context.appCuibt.getCollage();
    String topic = await context.appCuibt.translate(
        "${context.appCuibt.user?.field}-${context.appCuibt.user?.university}-${context.appCuibt.user?.team}");
    FirebaseMessaging.instance.subscribeToTopic(topic.replaceAll(" ", "-"));
    context.appCuibt.getNotification(topic);
    lastData =
        await json.decode(await SharedPreference.getDate(key: "last") ?? "");
    setState(() {});
  }

  @override
  void initState() {
    data(context);
    FirebaseMessaging.instance.subscribeToTopic("all");
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animationController.forward();
    if (context.appCuibt.isVisitor == false) {
      if (context.appCuibt.user!.typeStudy == "Academic year") {
        context.appCuibt.getSubject();
        context.appCuibt.getRev();
      } else {
        context.appCuibt.getM3hdSubject(context.appCuibt.user!.typeStudy);
      }
      if (context.appCuibt.user!.university == "جامعة القاهرة") {
        context.appCuibt.getAdditionalSubject();
      }
    }
    if (context.appCuibt.isVisitor) {
      context.appCuibt.getSubjectV();
    }
    context.appCuibt.getSubscription();
/*    controller = PodPlayerController(
        playVideoFrom: PlayVideoFrom.youtube(
            'https://youtu.be/${context.appCuibt.home.videoLink}'),
        podPlayerConfig: const PodPlayerConfig(
          autoPlay: false,
          isLooping: false,
          videoQualityPriority: [720, 360],
        ))
      ..initialise();*/

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(context.appCuibt.subjectList.length);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark,
            systemStatusBarContrastEnforced: false),
      ),
      body: BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {},
          builder: (context, state) {
            return ListView(
              children: [
                SizedBox(
                  height: context.height * .6,
                  width: context.width,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      if (context.appCuibt.collage != null)
                        SafeArea(
                          top: true,
                          minimum: const EdgeInsets.only(top: 90),
                          child: Container(
                            height: 375,
                            width: context.width,
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(.1),
                                  spreadRadius: 2,
                                  offset: const Offset(2, 0),
                                  blurRadius: 8)
                            ]),
                            child: CarouselSlider(
                              items: List<Widget>.generate(
                                context.appCuibt.collage?.sliders.length ?? 0,
                                (index) => CachedNetworkImage(
                                  imageUrl:
                                      context.appCuibt.collage?.sliders[index],
                                  width: context.width,
                                  height: 375,
                                  fit: BoxFit.fill,
                                  filterQuality: FilterQuality.high,
                                  imageBuilder: (context, i) => Container(
                                    margin: const EdgeInsets.all(10),
                                    width: context.width,
                                    height: 375,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                      image: i,
                                      fit: BoxFit.fill,
                                      filterQuality: FilterQuality.high,
                                    )),
                                  ),
                                  progressIndicatorBuilder: (context, i, _) =>
                                      const CircularProgressIndicator
                                          .adaptive(),
                                ),
                              ),
                              options: CarouselOptions(
                                  autoPlay: true,
                                  height: 375,
                                  enlargeStrategy:
                                      CenterPageEnlargeStrategy.height,
                                  enlargeCenterPage: true,
                                  enableInfiniteScroll: true,
                                  disableCenter: true,
                                  enlargeFactor: 4,
                                  viewportFraction: 1.2,
                                  onPageChanged: (i, _) {
                                    context.appCuibt.changePos(i);
                                  }),
                            ),
                          ),
                        ),
                      Container(
                        height: 110,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(14))),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 9),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: context.width * .7,
                                      child: Text(
                                        "أهلاً وسهلاً يا ${context.appCuibt.user?.name ?? "زائر"}",
                                        style: FontsManger.largeFont(context)
                                            ?.copyWith(
                                                fontSize: 15,
                                                color: ColorsManger.newColor),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "هيا بنا نواصل الدراسة ولا نراكم محاضراتنا",
                                      style: FontsManger.mediumFont(context)
                                          ?.copyWith(
                                              fontSize: 13,
                                              color: ColorsManger.newColor),
                                    ),
                                  ],
                                ),
                                if (!context.appCuibt.isVisitor)
                                  InkWell(
                                      onTap: () async {
                                        showLoading(context);
                                        String topic = await context.appCuibt
                                            .translate(
                                                "${context.appCuibt.user?.field}-${context.appCuibt.user?.university}-${context.appCuibt.user?.team}");

                                        context.appCuibt
                                            .getNotification(
                                                topic.replaceAll(" ", "-"))
                                            .then((value) {
                                          Navigator.pop(context);
                                          navigatorWid(
                                              page: const NotificationScreen(),
                                              returnPage: true,
                                              context: context);
                                        });
                                      },
                                      child: SvgPicture.asset(
                                          "assets/image/Component 20 – 1.svg"))
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            if (!context.appCuibt.isVisitor)
                              Center(
                                child: Container(
                                  height: 30,
                                  width: context.width * .9,
                                  alignment: Alignment.centerRight,
                                  decoration: BoxDecoration(
                                      color: const Color(0xff65256E)
                                          .withOpacity(.2),
                                      borderRadius: BorderRadius.circular(13)),
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(context.appCuibt.user?.token ?? "",
                                          style: FontsManger.mediumFont(context)
                                              ?.copyWith(
                                                  fontSize: 13,
                                                  color:
                                                      const Color(0xff65256E))),
                                      InkWell(
                                        onTap: () {
                                          Clipboard.setData(ClipboardData(
                                              text: context
                                                      .appCuibt.user?.token ??
                                                  ""));
                                          final snackBar = SnackBar(
                                            backgroundColor:
                                                ColorsManger.newColor,
                                            content: Text('تم نسخ الكود ',
                                                style: FontsManger.largeFont(
                                                        context)
                                                    ?.copyWith(
                                                        color: ColorsManger
                                                            .white)),
                                            showCloseIcon: true,
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 64,
                                          decoration: BoxDecoration(
                                              color: const Color(0xff65256E)
                                                  .withOpacity(.9),
                                              borderRadius:
                                                  BorderRadius.circular(13)),
                                          alignment: Alignment.center,
                                          child: Text("نسخ الكود",
                                              style: FontsManger.mediumFont(
                                                      context)
                                                  ?.copyWith(
                                                      fontSize: 13,
                                                      color:
                                                          ColorsManger.white)),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      if (context.appCuibt.collage != null)
                        Positioned(
                          bottom: 0,
                          child: BlocBuilder<AppCubit, AppState>(
                              builder: (context, state) {
                            return Center(
                              child: DotsIndicator(
                                dotsCount:
                                    context.appCuibt.collage?.sliders.length ??
                                        0,
                                position: context.appCuibt.pos,
                                decorator: DotsDecorator(
                                  size: const Size(11, 11),
                                  activeSize: const Size(35, 11),
                                  color: ColorsManger.newColor.withOpacity(.15),
                                  activeShape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0)),

                                  // Inactive color
                                  activeColor: ColorsManger.newColor,
                                ),
                              ),
                            );
                          }),
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      if (lastData != null)
                        Text(
                          "آخر محاضرة تصفحتها",
                          style: FontsManger.largeFont(context)?.copyWith(
                              color: ColorsManger.newColor, fontSize: 17),
                        ),
                      if (lastData != null)
                        const SizedBox(
                          height: 10,
                        ),
                      if (lastData != null)
                        InkWell(
                          onTap: () {
                            navigatorWid(
                                page: VideoScreen(
                                  subjectName: lastData?["subjectName"],
                                  doctorName: lastData?["docName"],
                                  lectureName: lastData?["lectureName"],
                                  videoId: lastData?["videoId"],
                                  pdfs: jsonDecode(lastData?["pdfs"]),
                                ),
                                returnPage: true,
                                context: context);
                          },
                          child: Container(
                            height: 140,
                            width: context.width,
                            decoration: BoxDecoration(
                              color: const Color(0xff844E8B),
                              borderRadius: BorderRadius.circular(17),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  lastData?["subjectName"] ?? "",
                                  style: FontsManger.largeFont(context)
                                      ?.copyWith(
                                          color: Colors.white, fontSize: 17),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  lastData?["lectureName"] ?? "",
                                  style: FontsManger.mediumFont(context)
                                      ?.copyWith(
                                          color: Colors.white, fontSize: 13),
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                Text(
                                  "كمّل مذاكرتك",
                                  style: FontsManger.mediumFont(context)
                                      ?.copyWith(
                                          color: Colors.white, fontSize: 13),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  height: 9,
                                  width: context.width,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          tileMode: TileMode.mirror,
                                          colors: [
                                        Colors.white,
                                        Colors.white.withOpacity(.57)
                                      ],
                                          stops: [
                                        double.parse((lastData?["now"] ??
                                                1 / lastData?["AllVideoMin"] ??
                                                1)
                                            .toString()),
                                        0
                                      ])),
                                )
                              ],
                            ),
                          ),
                        ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "هتذاكر أيه؟",
                        style: FontsManger.largeFont(context)
                            ?.copyWith(color: ColorsManger.newColor),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (context.appCuibt.user?.typeStudy == "Academic year")
                        SizedBox(
                          height: context.height * .33,
                          width: context.width,
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, i) => SubjectWidget(
                                    info: context.appCuibt.subjectList[i].info,
                                    index: i,
                                    time: context.appCuibt.subjectList[i].time!,
                                    name: context.appCuibt.subjectList[i].name,
                                    kind: context.appCuibt.subjectList[i].type,
                                    year: context.appCuibt.subjectList[i].year,
                                    imagePath:
                                        context.appCuibt.subjectList[i].image,
                                    imagePath2:
                                        context.appCuibt.subjectList[i].image2,
                                  ),
                              separatorBuilder: (context, i) =>
                                  const SizedBox(width: 10),
                              itemCount: context.appCuibt.subjectList.length),
                        ),
                      if (context.appCuibt.isVisitor)
                        SizedBox(
                          height: context.height * .33,
                          width: context.width,
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, i) => SubjectWidget(
                                    info: context.appCuibt.subjectList[i].info,
                                    index: i,
                                    time: context.appCuibt.subjectList[i].time!,
                                    name: context.appCuibt.subjectList[i].name,
                                    kind: context.appCuibt.subjectList[i].type,
                                    year: context.appCuibt.subjectList[i].year,
                                    imagePath:
                                        context.appCuibt.subjectList[i].image,
                                    imagePath2:
                                        context.appCuibt.subjectList[i].image2,
                                  ),
                              separatorBuilder: (context, i) =>
                                  const SizedBox(width: 10),
                              itemCount: context.appCuibt.subjectList.length),
                        ),
                      if (context.appCuibt.user?.typeStudy == "Academic year" &&
                          context.appCuibt.newAdd.isNotEmpty)
                        Text(
                          "المضاف حديثا",
                          style: FontsManger.largeFont(context)
                              ?.copyWith(color: ColorsManger.newColor),
                        ),
                      if (context.appCuibt.user?.typeStudy == "Academic year" &&
                          context.appCuibt.newAdd.isNotEmpty)
                        const SizedBox(
                          height: 10,
                        ),
                      if (context.appCuibt.user?.typeStudy == "Academic year" &&
                          context.appCuibt.newAdd.isNotEmpty)
                        SizedBox(
                          height: 100,
                          width: context.width,
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, i) => NewAddWidget(
                                    lecture: context.appCuibt.newAdd[i]
                                        ["value"],
                                    image: context.appCuibt.newAdd[i]["image"],
                                    name: context.appCuibt.newAdd[i]["name"],
                                  ),
                              separatorBuilder: (context, i) =>
                                  const SizedBox(width: 10),
                              itemCount: context.appCuibt.newAdd.length),
                        ),
                      if (context.appCuibt.user?.typeStudy == "Academic year")
                        const SizedBox(
                          height: 10,
                        ),
                      if (context.appCuibt.user?.typeStudy != "Academic year" &&
                          context.appCuibt.isVisitor == false)
                        SizedBox(
                          height: context.height * .3,
                          width: context.width,
                          child: ListView.separated(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, i) => DiffSubjectWidget(
                                    name:
                                        context.appCuibt.additionalList[i].name,
                                    imagePath: context
                                        .appCuibt.additionalList[i].image!,
                                    collection:
                                        context.appCuibt.user?.typeStudy ?? "",
                                  ),
                              separatorBuilder: (context, i) =>
                                  const SizedBox(width: 10),
                              itemCount:
                                  context.appCuibt.additionalList.length),
                        ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (context.appCuibt.user?.addSubject?.isNotEmpty == true)
                        Text(
                          "هتذاكر أيه؟",
                          style: FontsManger.largeFont(context)
                              ?.copyWith(color: ColorsManger.newColor),
                        ),
                      if (context.appCuibt.user?.addSubject?.isNotEmpty == true)
                        const SizedBox(
                          height: 10,
                        ),
                      if (context.appCuibt.user?.addSubject?.isNotEmpty == true)
                        SizedBox(
                          height: context.height * .35,
                          width: context.width,
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, i) => AddSubjectWidget(
                                    name: context
                                        .appCuibt.user!.addSubject![i].name,
                                    kind: context
                                        .appCuibt.user!.addSubject![i].type,
                                    time: context
                                        .appCuibt.user!.addSubject![i].time,
                                    year: context
                                        .appCuibt.user!.addSubject![i].year,
                                    imagePath: context.appCuibt.user!
                                        .addSubject![i].imagePath,
                                    imagePath2: context.appCuibt.rev[i].image2,
                                  ),
                              separatorBuilder: (context, i) =>
                                  const SizedBox(width: 10),
                              itemCount:
                                  context.appCuibt.user!.addSubject?.length ??
                                      0),
                        ),
                      if (context.appCuibt.user?.addSubject?.isNotEmpty == true)
                        const SizedBox(
                          height: 10,
                        ),
                      if (context.appCuibt.user?.university == "جامعة القاهرة")
                        Text(
                          "المواد الإضافية!",
                          style: FontsManger.largeFont(context)
                              ?.copyWith(color: ColorsManger.newColor),
                        ),
                      if (context.appCuibt.user?.university == "جامعة القاهرة")
                        SizedBox(
                          height: context.height * .32,
                          width: context.width,
                          child: ListView.separated(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, i) =>
                                  AdditionalSubjectWidget(
                                    name:
                                        context.appCuibt.additionalList[i].name,
                                    imagePath: context
                                        .appCuibt.additionalList[i].image!,
                                  ),
                              separatorBuilder: (context, i) =>
                                  const SizedBox(width: 10),
                              itemCount:
                                  context.appCuibt.additionalList.length),
                        ),
                      if (context.appCuibt.fun.isNotEmpty)
                        Text(
                          "وسائل ترفيهية",
                          style: FontsManger.largeFont(context)
                              ?.copyWith(color: ColorsManger.newColor),
                        ),
                      if (context.appCuibt.fun.isNotEmpty)
                        SizedBox(
                          height: context.height * .32,
                          width: context.width,
                          child: ListView.separated(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, i) => FunWidget(
                                    fun: context.appCuibt.fun[i],
                                  ),
                              separatorBuilder: (context, i) =>
                                  const SizedBox(width: 10),
                              itemCount: context.appCuibt.fun.length),
                        ),
                      if (Platform.isIOS && !context.appCuibt.home.applePay)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "الباقات والإشتراكات",
                              style: FontsManger.largeFont(context)
                                  ?.copyWith(color: ColorsManger.newColor),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 120,
                              width: context.width,
                              child: CarouselSlider(
                                items: List<Widget>.generate(
                                    context.appCuibt.subList.length,
                                    (index) => SubscriptionWidget(
                                          name: context
                                              .appCuibt.subList[index].name,
                                          disc: context
                                              .appCuibt.subList[index].det,
                                          price: context
                                              .appCuibt.subList[index].price,
                                        )),
                                options: CarouselOptions(
                                    autoPlay: true,
                                    height: 100,
                                    enlargeStrategy:
                                        CenterPageEnlargeStrategy.zoom,
                                    enlargeFactor: 2,
                                    disableCenter: true,
                                    viewportFraction: 1,
                                    enlargeCenterPage: true,
                                    onPageChanged: (i, _) {}),
                              ),
                            ),
                          ],
                        ),
                      if (Platform.isAndroid)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "الباقات والإشتراكات",
                              style: FontsManger.largeFont(context)
                                  ?.copyWith(color: ColorsManger.newColor),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 120,
                              width: context.width,
                              child: CarouselSlider(
                                items: List<Widget>.generate(
                                    context.appCuibt.subList.length,
                                    (index) => SubscriptionWidget(
                                          name: context
                                              .appCuibt.subList[index].name,
                                          disc: context
                                              .appCuibt.subList[index].det,
                                          price: context
                                              .appCuibt.subList[index].price,
                                        )),
                                options: CarouselOptions(
                                    autoPlay: true,
                                    height: 100,
                                    enlargeStrategy:
                                        CenterPageEnlargeStrategy.zoom,
                                    enlargeFactor: 2,
                                    disableCenter: true,
                                    viewportFraction: 1,
                                    enlargeCenterPage: true,
                                    onPageChanged: (i, _) {}),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }

  bool apple() {
    if (context.appCuibt.home.applePay && Platform.isIOS) {
      return true;
    } else if (Platform.isAndroid) {
      return true;
    } else {
      return false;
    }
  }
}
