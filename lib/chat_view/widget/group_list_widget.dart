
import 'package:flutter/material.dart';

import '../../../utls/manger/font_manger.dart';
import '../../models/chat_list_model.dart';
import '../../utls/widget/base_widget.dart';
import '../screens/massage_group_screen.dart';

class ChatGroupListWidget extends StatefulWidget {
  final ChatListModel chatList;

  const ChatGroupListWidget({super.key, required this.chatList});

  @override
  State<ChatGroupListWidget> createState() => _ChatGroupListWidgetState();
}

class _ChatGroupListWidgetState extends State<ChatGroupListWidget> {



  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: ()=>navigatorWid(page: GroupChat(chat: widget.chatList,),context: context,returnPage: true),
      leading: Container(
        height: 60,
        width: 51,
        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xff374AE0), width: 2)),
        child: Container(
          height: 54,
          width: 46,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Icon(Icons.group),
        ),
      ),
      title: Text(widget.chatList.idUser1,
          style: FontsManger.largeFont(context)
              ?.copyWith(fontSize: 15, color: const Color(0xff343434))),


    );
  }
}
