
import 'package:afeer/utls/extension.dart';
import 'package:afeer/utls/manger/color_manger.dart';
import 'package:flutter/material.dart';

import '../../models/chat_model.dart';
import '../../utls/manger/font_manger.dart';

class AdminWidgetChat extends StatefulWidget {
  final   MassageModel chat;
  const AdminWidgetChat({super.key, required this.chat});

  @override
  State<AdminWidgetChat> createState() => _AdminWidgetChatState();
}

class _AdminWidgetChatState extends State<AdminWidgetChat> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: context.width*.4,
          decoration: BoxDecoration(
            color: ColorsManger.pColor,
            borderRadius: BorderRadius.circular(19),

          ),
          padding: const EdgeInsets.all(5),
          child: Text(widget.chat.massage,style: FontsManger.largeFont(context)?.copyWith(color: Colors.white)),
        ),
        const SizedBox(width: 10,),
        Container(
          height: 30,
          width: 30,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,

          ),
          child: const Icon(Icons.person),
        ),

      ],
    );
  }
}
