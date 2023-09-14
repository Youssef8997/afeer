import 'package:afeer/utls/extension.dart';
import 'package:afeer/utls/manger/font_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoardingWidget extends StatefulWidget {
  final String text;
  final String imagePath;
  const OnBoardingWidget({super.key, required this.text, required this.imagePath});

  @override
  State<OnBoardingWidget> createState() => _OnBoardingWidgetState();
}

class _OnBoardingWidgetState extends State<OnBoardingWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(widget.text,style: FontsManger.blackFont(context)?.copyWith(color: const Color(0xff1D1D1D)),textAlign: TextAlign.center),
          const SizedBox(height: 30,),
          SvgPicture.asset(widget.imagePath,height: context.height*.4,width: context.width,)
        ],
      ),
    );
  }
}
