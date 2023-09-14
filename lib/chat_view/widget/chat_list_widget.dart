import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../utls/manger/font_manger.dart';

class ChatListWidget extends StatefulWidget {
  const ChatListWidget({super.key});

  @override
  State<ChatListWidget> createState() => _ChatListWidgetState();
}

class _ChatListWidgetState extends State<ChatListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 60,
        width: 51,
        padding: const EdgeInsets.symmetric(horizontal: 3,vertical: 3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xff374AE0),width:2 )
        ),
        child: CachedNetworkImage(
          fit: BoxFit.fill,
          height: 54,
          width: 46,
          imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzHQv_th9wq3ivQ1CVk7UZRxhbPq64oQrg5Q&usqp=CAU",
          imageBuilder:(context,i)=> Container(
            height: 54,
            width: 46,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: i,
                fit: BoxFit.fill
              )
            ),
          ),
        ),
      ),
      title: Text("يوسف احمد",style: FontsManger.largeFont(context)?.copyWith(fontSize: 15,color: const Color(0xff343434))),
      subtitle: Text("المهم يا صديقي عاوزين نذاكر ونجتهد علشان مفيش وقت ولازم ننجز اللي ...",style: FontsManger.mediumFont(context)?.copyWith(fontSize: 10,color:Colors.black.withOpacity(.7) ),maxLines: 1),
    );
  }
}
