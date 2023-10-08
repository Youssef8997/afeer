
import 'package:afeer/utls/extension.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../models/chat_model.dart';

class UserWidgetChat extends StatefulWidget {
final   MassageModel chat;
  const UserWidgetChat({super.key, required this.chat});

  @override
  State<UserWidgetChat> createState() => _UserWidgetChatState();
}

class _UserWidgetChatState extends State<UserWidgetChat> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CachedNetworkImage(
          fit: BoxFit.fill,
          height: 30,
          width: 30,
          imageUrl: context.appCuibt.user?.image??"",
          imageBuilder:(context,i)=> Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
               shape: BoxShape.circle,
                image: DecorationImage(
                    image: i,
                    fit: BoxFit.fill
                )
            ),
          ),
          errorWidget: (context,i,_)=>Container(
            height: 30,
            width: 30,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,

            ),
            child: const Icon(Icons.person),
          ),
        ),
        const SizedBox(width: 10,),
        Container(
          width: context.width*.4,
         decoration: BoxDecoration(
           color: const Color(0xffDFDFDF),
           borderRadius: BorderRadius.circular(19),

         ),
          padding: const EdgeInsets.all(5),
          child: Text(widget.chat.massage),
        )
      ],
    );
  }
}
