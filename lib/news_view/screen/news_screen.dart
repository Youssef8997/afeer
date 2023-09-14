import 'package:afeer/utls/extension.dart';
import 'package:afeer/utls/manger/font_manger.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../chat_view/screens/chat_screen.dart';
import '../../settings_views/screen/settings_screen.dart';
import '../../utls/manger/assets_manger.dart';
import '../../utls/widget/base_widget.dart';
import '../widget/post_widget.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
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
                      bottom: 0, right: 15, top: 15, left: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(child: Image.asset("assets/image/Container.png",width: 20,height: 35,fit: BoxFit.cover,),onTap: ()=>navigatorWid(page: const SettingsScreen(),returnPage: true,context: context)),
                      const SizedBox(
                        width: 5,
                      ),
                      InkWell(
                          child: const Icon(
                            Icons.home_outlined,
                            size: 30,
                          ),
                          onTap: () => Navigator.pop(context)),
                      const SizedBox(
                        width: 5,
                      ),
                      InkWell(child: SvgPicture.asset("assets/image/Message---4.svg",width: 10,height: 30,fit: BoxFit.cover,),onTap: ()=>navigatorWid(page: const ChatScreen(),context: context,returnPage: true),),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Image.asset(
                    AssetsManger.logo2,
                    width: 100,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  height: context.height * .13,
                  width: context.width,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(.20),
                            offset: const Offset(0, 1),
                            blurRadius: 2)
                      ]),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CachedNetworkImage(
                            imageUrl:
                                "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
                            width: 25,
                            height: 25,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 32,
                            width: context.width * .76,
                            alignment: Alignment.centerRight,
                            decoration: BoxDecoration(
                                color: const Color(0xffF0F2F5),
                                borderRadius: BorderRadius.circular(20)),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text("أكتب المنشور الذي تريد رفعه ",
                                style: FontsManger.mediumFont(context)
                                    ?.copyWith(
                                        fontSize: 10,
                                        color: const Color(0xff606770))),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        color: Color(0xffE4E6EB),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Row(
                              children: [
                                Text(
                                  "إدراج مستند",
                                  style: FontsManger.mediumFont(context)
                                      ?.copyWith(
                                          fontSize: 10,
                                          color: const Color(0xff606770)),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                SvgPicture.asset("assets/image/paper.svg",
                                    height: 20, width: 20),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Row(
                              children: [
                                Text(
                                  "إدراج صورة",
                                  style: FontsManger.mediumFont(context)
                                      ?.copyWith(
                                          fontSize: 10,
                                          color: const Color(0xff606770)),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Image.asset("assets/image/gallery.png",
                                    height: 20, width: 20),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: context.height * .06,
                  width: context.width,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(.20),
                            offset: const Offset(0, 1),
                            blurRadius: 2)
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color(0xffE4E6EB),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          height: 40,
                          width: 60,
                          child: Text.rich(TextSpan(children: [
                            TextSpan(
                                text: "فلترة",
                                style: FontsManger.mediumFont(context)
                                    ?.copyWith(
                                        fontSize: 12,
                                        color: const Color(0xff1D1F23))),
                            WidgetSpan(
                                child: SvgPicture.asset(
                                    "assets/image/Image 17.svg")),
                            const WidgetSpan(
                                child: SizedBox(
                              width: 5,
                            )),
                          ])),
                        ),
                      ),
                      Text(
                        "المنشورات",
                        style: FontsManger.largeFont(context),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const PostWidget(),
                const SizedBox(
                  height: 20,
                ),
                const PostWidget(),

              ],
            ),
          )
        ],
      ),
    );
  }
}
