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
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quds_popup_menu/quds_popup_menu.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../chat_view/screens/chat_screen.dart';
import '../news_view/screen/news_screen.dart';
import '../settings_views/screen/settings_screen.dart';
import '../utls/manger/color_manger.dart';
import '../utls/widget/text_form.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  YoutubePlayerController ? controller;

  @override
  void initState() {
     controller = YoutubePlayerController(
      initialVideoId: context.appCuibt.home.videoLink,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
showLiveFullscreenButton: false
      ),
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
      body: ListView(
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
                        onTap: () => navigatorWid(
                            page: const ChatScreen(),
                            context: context,
                            returnPage: true),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                QudsPopupButton(
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
                ),
                Text(
                  "ما الجديد في المنصة؟",
                  style: FontsManger.largeFont(context)
                      ?.copyWith(color: ColorsManger.pColor),
                ),
                SizedBox(
                  height: 170,
                  width: context.width,
                  child: CarouselSlider(
                    items: List<Widget>.generate(
                      context.appCuibt.home.sliders.length,
                      (index) => CachedNetworkImage(
                        imageUrl: context.appCuibt.home.sliders[index],
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
                BlocBuilder<AppCubit, AppState>(builder: (context, state) {
                  return Center(
                    child: DotsIndicator(
                      dotsCount: context.appCuibt.home.sliders.length,
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
bottomActions: [

],
                  showVideoProgressIndicator: true,
                 onReady: (){

                 },

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
                SizedBox(
                  height: context.height * .25,
                  width: context.width,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, i) =>  SubjectWidget(
                            name: context.appCuibt.subjectList[i].name,
                            kind:  context.appCuibt.subjectList[i].type,
                            year:  context.appCuibt.subjectList[i].year,
                            imagePath: "assets/image/شسش.png",
                          ),
                      separatorBuilder: (context, i) =>
                          const SizedBox(width: 10),
                      itemCount: context.appCuibt.subjectList.length),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "المواد الإضافية!",
                  style: FontsManger.largeFont(context)
                      ?.copyWith(color: ColorsManger.pColor),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: context.height * .085,
                  width: context.width,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, i) =>
                          const AdditionalSubjectWidget(name: "English (1)"),
                      separatorBuilder: (context, i) =>
                          const SizedBox(width: 10),
                      itemCount: 5),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "!الباقات والإشتراكات",
                  style: FontsManger.largeFont(context)
                      ?.copyWith(color: ColorsManger.pColor),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 120,
                  width: context.width,
                  child: CarouselSlider(
                    items: List<Widget>.generate(
                        3,
                        (index) => const SubscriptionWidget(
                              name: "باقة الدحيح",
                              disc:
                                  "الآن مع باقة الدحيح تقدر تستمع بالمنهج بالكامل فيديوهات ومادة علمية وكل مزايا المنصة لجميع المواد",
                              price: "250",
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
      ),
    );
  }
}
