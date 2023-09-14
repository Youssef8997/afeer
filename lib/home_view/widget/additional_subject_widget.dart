import 'package:afeer/utls/extension.dart';
import 'package:afeer/utls/manger/color_manger.dart';
import 'package:afeer/utls/manger/font_manger.dart';
import 'package:flutter/material.dart';

class AdditionalSubjectWidget extends StatefulWidget {
  final String name;
  const AdditionalSubjectWidget({super.key, required this.name});

  @override
  State<AdditionalSubjectWidget> createState() => _AdditionalSubjectWidgetState();
}

class _AdditionalSubjectWidgetState extends State<AdditionalSubjectWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height*.085,
      width: context.width*.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: ColorsManger.scaffoldBackGround,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.4),
            blurRadius: 1
          )
        ],

      ),
      child: Center(
        child: Text(widget.name,style: FontsManger.blackFont(context)?.copyWith(fontSize: 12,color: ColorsManger.text3.withOpacity(.4))),
      ),
    );
  }
}
