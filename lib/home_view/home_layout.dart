import 'package:afeer/cuibt/app_cuibt.dart';
import 'package:afeer/cuibt/app_state.dart';
import 'package:afeer/home_view/widget/additional_subject_widget.dart';
import 'package:afeer/home_view/widget/subjects_widget.dart';
import 'package:afeer/home_view/widget/subscription_widget.dart';
import 'package:afeer/utls/extension.dart';
import 'package:afeer/utls/manger/assets_manger.dart';
import 'package:afeer/utls/manger/font_manger.dart';
import 'package:afeer/utls/widget/base_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../auth_views/screens/auth_home_screen.dart';
import '../chat_view/screens/chat_screen.dart';
import '../dif_lec_view/diff_widget.dart';
import '../news_view/screen/news_screen.dart';
import '../settings_views/screen/settings_screen.dart';
import '../utls/manger/color_manger.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  YoutubePlayerController ? controller;
Future<void> data() async {
  String topic =
      await context.appCuibt.translate("${context.appCuibt.user?.field}-${context.appCuibt.user?.university}-${context.appCuibt.user?.team}");

  FirebaseMessaging.instance.subscribeToTopic(topic.replaceAll(" ", "-"));
}
  @override
  void initState() {
    data();
    FirebaseMessaging.instance.subscribeToTopic("all");

    if(context.appCuibt.isVisitor==false){
      if(context.appCuibt.user!.typeStudy=="Academic year") {
        context.appCuibt.getSubject();
      }else{
        context.appCuibt.getM3hdSubject(context.appCuibt.user!.typeStudy);
      }
      if (context.appCuibt.user!.university == "جامعة القاهرة") {
        context.appCuibt.getAdditionalSubject();
      }
    }
    context.appCuibt.getSubscription();

    controller = YoutubePlayerController(
      initialVideoId: context.appCuibt.home.videoLink,
      flags: const YoutubePlayerFlags(
          autoPlay: false, mute: false, showLiveFullscreenButton: false),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: Color(0xffFCFCFE)),
      ),
      body: BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {},
          builder: (context, state) {
            return ListView(
              children: [
                Container(
                  height: 80,
                  decoration:
                      BoxDecoration(color: const Color(0xffFCFCFE), boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(.16),
                        offset: const Offset(0, 3),
                        blurRadius: 6)
                  ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 0, right: 20, top: 15, left: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                                child: const Icon(Icons.settings_outlined),
                                onTap: () => navigatorWid(
                                    page: const SettingsScreen(),
                                    returnPage: true,
                                    context: context)),
                            const SizedBox(
                              width: 5,
                            ),
                            InkWell(
                                child: SvgPicture.asset(
                                  "assets/image/Notification---3.svg",
                                  width: 10,
                                  height: 30,
                                  fit: BoxFit.cover,
                                ),
                                onTap: () => navigatorWid(
                                    page: const NewsScreen(),
                                    returnPage: true,
                                    context: context)),
                            const SizedBox(
                              width: 5,
                            ),
                            InkWell(
                              child: SvgPicture.asset(
                                "assets/image/Message---4.svg",
                                width: 10,
                                height: 30,
                                fit: BoxFit.cover,
                              ),
                              onTap: () =>context.appCuibt.isVisitor?navigatorWid(
                                  page: const AuthHomeScreen(),
                                  context: context,
                                  returnPage: true): navigatorWid(
                                  page: const ChatScreen(),
                                  context: context,
                                  returnPage: true),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Image.asset(
                          AssetsManger.logo2,
                          width: 100,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
            /*          QudsPopupButton(
                        // backgroundColor: Colors.red,
                        tooltip: 'T',
                        items: [
                          QudsPopupMenuSection(
                              backgroundColor: Colors.yellow.shade200,
                              titleText: "الفرقه الاولي",
                              leading: const Icon(Icons.numbers),
                              subItems: [
                                QudsPopupMenuItem(
                                    leading: const Icon(Icons.numbers),
                                    title: const Text('Logout'),
                                    onPressed: () {}),
                              ]),
                          QudsPopupMenuSection(
                              titleText: 'الفرقة الثانة',
                              leading: const Icon(Icons.numbers),
                              subItems: [
                                QudsPopupMenuItem(
                                    leading: const Icon(Icons.logout),
                                    title: const Text('Logout'),
                                    onPressed: () {})
                              ]),
                          QudsPopupMenuSection(
                              titleText: 'الفرقة الثالثة',
                              leading: const Icon(Icons.numbers),
                              subItems: [
                                QudsPopupMenuItem(
                                    leading: const Icon(Icons.logout),
                                    title: const Text('Logout'),
                                    onPressed: () {})
                              ]),
                          QudsPopupMenuSection(
                              titleText: 'الفرقة الرابعة',
                              leading: const Icon(Icons.numbers),
                              subItems: [
                                QudsPopupMenuItem(
                                    leading: const Icon(Icons.logout),
                                    title: const Text('Logout'),
                                    onPressed: () {})
                              ]),
                        ],
                        child: TextFormWidget(
                          active: false,
                          label: 'إذا كنت تريد إضافة مواد جديدة',
                          suffix: Icon(Icons.search,
                              color: ColorsManger.text3.withOpacity(.20)),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),*/
                      if(context.appCuibt.collage!=null)
                      Text(
                        "ما الجديد في المنصة؟",
                        style: FontsManger.largeFont(context)
                            ?.copyWith(color: ColorsManger.pColor),
                      ),
                      if(context.appCuibt.collage!=null)

                        SizedBox(
                        height: 170,
                        width: context.width,
                        child: CarouselSlider(
                          items: List<Widget>.generate(
                            context.appCuibt.collage?.sliders.length??0,
                            (index) => CachedNetworkImage(
                              imageUrl: context.appCuibt.collage?.sliders[index],
                              width: context.width,
                              height: 160,
                              fit: BoxFit.fill,
                              filterQuality: FilterQuality.high,
                              imageBuilder: (context, i) => Container(
                                margin: const EdgeInsets.all(10),
                                width: context.width,
                                height: context.height * .38,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: i,
                                      fit: BoxFit.fill,
                                      filterQuality: FilterQuality.high,
                                    )),
                              ),
                            ),
                          ),
                          options: CarouselOptions(
                              autoPlay: true,
                              height: context.height * .25,
                              enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                              enlargeFactor: 2,
                              disableCenter: true,
                              viewportFraction: 1,
                              enlargeCenterPage: true,
                              onPageChanged: (i, _) {
                                context.appCuibt.changePos(i);
                              }),
                        ),
                      ),
                      if(context.appCuibt.collage!=null)

                        BlocBuilder<AppCubit, AppState>(
                          builder: (context, state) {
                        return Center(
                          child: DotsIndicator(
                            dotsCount: context.appCuibt.collage?.sliders.length??0,
                            position: context.appCuibt.pos,
                            decorator: DotsDecorator(
                              size: const Size(15, 15),
                              activeSize: const Size(15, 15),
                              color: ColorsManger.pColor.withOpacity(.15),
                              // Inactive color
                              activeColor: ColorsManger.pColor,
                            ),
                          ),
                        );
                      }),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "إزاي تستخدم المنصة؟",
                        style: FontsManger.largeFont(context)
                            ?.copyWith(color: ColorsManger.pColor),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      YoutubePlayer(
                        controller: controller!,
                        bottomActions: const [],
                        showVideoProgressIndicator: true,
                        onReady: () {},
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "هتذاكر أيه؟",
                        style: FontsManger.largeFont(context)
                            ?.copyWith(color: ColorsManger.pColor),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if(context.appCuibt.user?.typeStudy=="Academic year")
                      SizedBox(
                        height: context.height * .25,
                        width: context.width,
                        child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, i) => SubjectWidget(
                                  name: context.appCuibt.subjectList[i].name,
                                  kind: context.appCuibt.subjectList[i].type,
                                  year: context.appCuibt.subjectList[i].year,
                                  imagePath:
                                      context.appCuibt.subjectList[i].image,
                                ),
                            separatorBuilder: (context, i) =>
                                const SizedBox(width: 10),
                            itemCount: context.appCuibt.subjectList.length),
                      ),
                      if(context.appCuibt.user?.typeStudy!="Academic year")
                        SizedBox(
                        height: context.height * .090,
                        width: context.width,
                        child: ListView.separated(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, i) =>
                                DiffSubjectWidget(
                                    name: context.appCuibt.additionalList[i],
                                collection: context.appCuibt.user!.typeStudy,
                                ),
                            separatorBuilder: (context, i) =>
                            const SizedBox(width: 10),
                            itemCount:
                            context.appCuibt.additionalList.length),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (context.appCuibt.user?.university == "جامعة القاهرة")
                        Text(
                          "المواد الإضافية!",
                          style: FontsManger.largeFont(context)
                              ?.copyWith(color: ColorsManger.pColor),
                        ),
                      if (context.appCuibt.user?.university == "جامعة القاهرة")
                        const SizedBox(
                          height: 10,
                        ),
                      if (context.appCuibt.user?.university == "جامعة القاهرة")
                        SizedBox(
                          height: context.height * .090,
                          width: context.width,
                          child: ListView.separated(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, i) =>
                                  AdditionalSubjectWidget(
                                      name: context.appCuibt.additionalList[i]),
                              separatorBuilder: (context, i) =>
                                  const SizedBox(width: 10),
                              itemCount:
                                  context.appCuibt.additionalList.length),
                        ),
                      const SizedBox(
                        height: 20,
                      ),
                      if (context.appCuibt.subList.isNotEmpty)
                        Text(
                          "الباقات والإشتراكات",
                          style: FontsManger.largeFont(context)
                              ?.copyWith(color: ColorsManger.pColor),
                        ),
                      if (context.appCuibt.subList.isNotEmpty)
                        const SizedBox(
                          height: 10,
                        ),
                      if (context.appCuibt.subList.isNotEmpty)
                        SizedBox(
                          height: 120,
                          width: context.width,
                          child: CarouselSlider(
                            items: List<Widget>.generate(
                                context.appCuibt.subList.length,
                                (index) => SubscriptionWidget(
                                      name:
                                          context.appCuibt.subList[index].name,
                                      disc: context.appCuibt.subList[index].det,
                                      price:
                                          context.appCuibt.subList[index].price,
                                    )),
                            options: CarouselOptions(
                                autoPlay: true,
                                height: 100,
                                enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                                enlargeFactor: 2,
                                disableCenter: true,
                                viewportFraction: 1,
                                enlargeCenterPage: true,
                                onPageChanged: (i, _) {}),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}
