import 'package:afeer/utls/extension.dart';
import 'package:afeer/utls/manger/font_manger.dart';
import 'package:flutter/material.dart';

import '../../../utls/manger/color_manger.dart';

class BottomNavBarWidget extends StatefulWidget {
  const BottomNavBarWidget({super.key});

  @override
  State<BottomNavBarWidget> createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: context.height * .083,
        width: context.width,
        decoration: BoxDecoration(
            color: const Color(0xffFAF9F9),
            border: const Border.symmetric(
                vertical: BorderSide(color: Color(0xffF0F0F0), width: 1.6)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(.2),
                  spreadRadius: 2,
                  blurRadius: 6,
                  offset: const Offset(0, 1))
            ]),
        alignment: Alignment.bottomCenter,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ItemNavBarWidget(
                icon: Icons.home,
                index: 0,
                name: "الرئيسيه",
              ),
              ItemNavBarWidget(
                icon: Icons.person,
                index: 1,
                name: "حسابي",
              ),
            ]));
  }
}

class ItemNavBarWidget extends StatefulWidget {
  final int index;
  final IconData icon;
  final String name;

  const ItemNavBarWidget(
      {super.key, required this.index, required this.icon, required this.name});

  @override
  State<ItemNavBarWidget> createState() => _ItemNavBarWidgetState();
}

class _ItemNavBarWidgetState extends State<ItemNavBarWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.appCuibt.changeIndexS(widget.index);
      },
      child: Column(
        children: [
          Container(
              height: context.height * .025,
              width: 24,
              child: Icon(widget.icon,
                  size: 24,
                  color: context.appCuibt.indexScaffold == widget.index
                      ? ColorsManger.newColor
                      : const Color(0xff828F9C))),
          const SizedBox(
            height: 8,
          ),
          Text(
            widget.name,
            style: FontsManger.largeFont(context)?.copyWith(
                fontSize: 13,
                color: widget.index == context.appCuibt.indexScaffold
                    ? ColorsManger.newColor
                    : const Color(0xff828F9C)),
          )
        ],
      ),
    );
  }
}
