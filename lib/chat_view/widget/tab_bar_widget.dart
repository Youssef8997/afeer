import 'package:afeer/utls/manger/color_manger.dart';
import 'package:afeer/utls/manger/font_manger.dart';
import 'package:flutter/material.dart';

class TabBarWidget extends StatefulWidget {
  final String name;
  final int index;
  const TabBarWidget({super.key, required this.name, required this.index});

  @override
  State<TabBarWidget> createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.name,style: FontsManger.largeFont(context)?.copyWith(
          color: widget.index==1?ColorsManger.pColor:Colors.black
        ),),
        const SizedBox(height: 5,),
        if(widget.index==1)
        Container(height:2 ,width: 50,color: ColorsManger.pColor,)
      ],
    );
  }
}
