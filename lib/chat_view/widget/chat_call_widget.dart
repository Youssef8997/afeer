
import 'package:flutter/material.dart';

import '../../../utls/manger/font_manger.dart';
import '../../models/chat_list_model.dart';
import '../../utls/widget/base_widget.dart';
import '../screens/massage_screen.dart';

class CallChatListWidget extends StatefulWidget {
  final ChatListModel chatList;

  const CallChatListWidget({super.key, required this.chatList});

  @override
  State<CallChatListWidget> createState() => _CallChatListWidgetState();
}

class _CallChatListWidgetState extends State<CallChatListWidget> {

  void getUserInfo() async {
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: ()=>navigatorWid(page: CallCanterChatScreen(chat: widget.chatList,),context: context,returnPage: true),
      leading:  Container(
        height: 54,
        width: 46,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Icon(Icons.person),
      ),

      title: Text("خدمه عملاء",
          style: FontsManger.largeFont(context)
              ?.copyWith(fontSize: 15, color: const Color(0xff343434))),
      subtitle: Text(widget.chatList.lastMassage,
          style: FontsManger.mediumFont(context)
              ?.copyWith(fontSize: 10, color: Colors.black.withOpacity(.7)),
          maxLines: 1),
      trailing: widget.chatList.isRead
          ? null
          : Container(
          height: 10,
          width: 10,
          decoration:
          const BoxDecoration(color: Colors.green, shape: BoxShape.circle)),
    );
  }
}
