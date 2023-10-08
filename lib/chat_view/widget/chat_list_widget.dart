
import 'package:afeer/utls/extension.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../models/user_model.dart';
import '../../../utls/manger/font_manger.dart';
import '../../models/chat_list_model.dart';
import '../../utls/widget/base_widget.dart';
import '../screens/massgae_personal_screen.dart';

class ChatListWidget extends StatefulWidget {
  final ChatListModel chatList;

  const ChatListWidget({super.key, required this.chatList});

  @override
  State<ChatListWidget> createState() => _ChatListWidgetState();
}

class _ChatListWidgetState extends State<ChatListWidget> {
  UserModel? user;

  void getUserInfo() async {
    if(widget.chatList.idUser1!=context.appCuibt.user!.token){
      user = await context.appCuibt.getInfoUser(widget.chatList.idUser1);

    }else {
      user = await context.appCuibt.getInfoUser(widget.chatList.idUser2);

    }
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: ()=>user!=null?navigatorWid(page: PersonalChatScreen(chat: widget.chatList,user: user!,),context: context,returnPage: true):null,
      leading: Container(
        height: 60,
        width: 51,
        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xff374AE0), width: 2)),
        child: CachedNetworkImage(
          fit: BoxFit.fill,
          height: 54,
          width: 46,
          imageUrl: user?.image ?? "",
          imageBuilder: (context, i) => Container(
            height: 54,
            width: 46,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(image: i, fit: BoxFit.fill)),
          ),
          errorWidget: (context, i, _) => Container(
            height: 54,
            width: 46,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(Icons.person),
          ),
        ),
      ),
      title: Text(user?.name ?? "",
          style: FontsManger.largeFont(context)
              ?.copyWith(fontSize: 15, color: const Color(0xff343434))),
      subtitle: Text(widget.chatList.lastMassage,
          style: FontsManger.mediumFont(context)
              ?.copyWith(fontSize: 10, color: Colors.black.withOpacity(.7)),
          maxLines: 1),

    );
  }
}
