import 'package:afeer/utls/extension.dart';
import 'package:afeer/utls/manger/font_manger.dart';
import 'package:flutter/material.dart';

import '../manger/assets_manger.dart';

class AppBarWidget extends StatefulWidget {
  const AppBarWidget({super.key});

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(color: const Color(0xffFCFCFE), boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(.16),
            offset: const Offset(0, 3),
            blurRadius: 6)
      ]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(bottom: 0, right: 0, top: 0, left: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [if (Navigator.canPop(context)) const BackButton()],
            ),
          ),
          SizedBox(
            width: context.width * .25,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Text("الاشتراكات", style: FontsManger.largeFont(context)),
            ),
          )
        ],
      ),
    );
  }
}
