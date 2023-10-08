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
                bottom: 0, right: 0, top: 0, left: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if(Navigator.canPop(context))
                const BackButton()
              ],
            ),
          ),
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Image.asset(
              AssetsManger.logo2,
              width: 100,
            ),
          )
        ],
      ),
    );
  }
}
