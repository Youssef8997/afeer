import 'package:afeer/utls/extension.dart';
import 'package:afeer/utls/manger/color_manger.dart';
import 'package:afeer/utls/manger/font_manger.dart';
import 'package:animated_list_item/animated_list_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animationController.forward();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark,
            systemStatusBarContrastEnforced: false),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "الاشعارات",
                  style: FontsManger.largeFont(context)
                      ?.copyWith(fontSize: 16, color: Colors.black),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_forward,
                      color: Colors.black,
                    ))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            if (context.appCuibt.notification.isNotEmpty)
              Expanded(
                  child: ListView.builder(
                itemCount: context.appCuibt.notification.length,
                shrinkWrap: true,
                itemBuilder: (context, i) => AnimatedListItem(
                  index: i,
                  length: context.appCuibt.notification.length,
                  aniController: _animationController,
                  animationType: AnimationType.slide,
                  startX: 40,
                  startY: 60,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: 80,
                    width: context.width,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        color: const Color(0xffF2F2F2).withOpacity(.85),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        if (context.appCuibt.notification[i].image != null &&
                            context.appCuibt.notification[i].image != "")
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CachedNetworkImage(
                              width: 80,
                              height: 70,
                              imageUrl: context.appCuibt.notification[i].image!,
                              fit: BoxFit.fill,
                            ),
                          ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              context.appCuibt.notification[i].title,
                              style: FontsManger.largeFont(context)?.copyWith(
                                  color: ColorsManger.text3, fontSize: 14),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(context.appCuibt.notification[i].subTitle,
                                style: FontsManger.mediumFont(context)
                                    ?.copyWith(
                                        fontSize: 12,
                                        color: Colors.grey.withOpacity(.6))),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )),
            if (context.appCuibt.notification.isEmpty)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: ColorsManger.newColor,
                        size: 50,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "ليس لديك اشعارات الان",
                        style: FontsManger.largeFont(context)!
                            .copyWith(color: ColorsManger.black, fontSize: 22),
                      )
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
