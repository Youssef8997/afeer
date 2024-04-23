import 'package:afeer/utls/extension.dart';

import 'package:flutter/material.dart';

import '../../../utls/manger/color_manger.dart';
import '../../../utls/manger/font_manger.dart';
import '../../../utls/widget/base_app_Bar.dart';

class AlertsScreens extends StatefulWidget {
  final String alerts;
  const AlertsScreens({super.key, required this.alerts});

  @override
  State<AlertsScreens> createState() => _AlertsScreensState();
}

class _AlertsScreensState extends State<AlertsScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const AppBarWidget(),
          SizedBox(
            height: context.height * .35,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Center(
                child: Text(
              widget.alerts,
              style: FontsManger.largeFont(context)?.copyWith(
                color: ColorsManger.black,
              ),
            )),
          )
        ],
      ),
    );
  }
}
