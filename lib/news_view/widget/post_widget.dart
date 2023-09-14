import 'package:afeer/utls/extension.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../utls/manger/font_manger.dart';

class PostWidget extends StatefulWidget {
  const PostWidget({super.key});

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: context.height * .58,
      width: context.width,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(.20),
                offset: const Offset(0, 1),
                blurRadius: 2)
          ]),
      child: Column(
        children: [
          Row(
            children: [
              CachedNetworkImage(
                imageUrl:
                "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
                width: 27,
                height: 27,
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "يوسف احمد",
                    style: FontsManger.mediumFont(context)
                        ?.copyWith(
                        fontSize: 10,
                        color: const Color(0xff1D1F23)),
                  ),
                  Text(
                    "نوفمبر 16, 2021",
                    style: FontsManger.mediumFont(context)
                        ?.copyWith(
                        fontSize: 8,
                        color: const Color(0xff606770)),
                  )
                ],
              ),
              const Spacer(),
              Container(
                  decoration: const BoxDecoration(
                      color: Color(0xffF2F2F2),
                      shape: BoxShape.circle),
                  child: const Icon(
                    Icons.more_horiz,
                    size: 25,
                    color: Color(0xff606770),
                  ))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "بخصوص مادة  المحاسبة المالية دي محاضرة مهمة جداً ، إتقال فيها حاجات مهمة ، نقدر هنا على المنصة ننزلكم صور أو ملفات pdf  صغير الحجم تساعدكم بشكل مجاني",style: FontsManger.mediumFont(context)?.copyWith(color: const Color(0xff1D1F23)),),
          const SizedBox(height:10),
          CachedNetworkImage(
            imageUrl: "https://www.propertyfinder.sa/blog/wp-content/uploads/2021/09/%D8%AC%D9%88%D9%87%D8%B1%D8%A9-%D8%A7%D9%84%D8%BA%D8%B1%D9%88%D8%A8-%D9%A4.jpeg",
            fit: BoxFit.fill,
            width: context.width*.9,
            height: context.height * .3,
            imageBuilder: (context,i)=>Container(
              width: context.width*.9,
              height: context.height * .34,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  image: DecorationImage(
                    image: i,

                    fit: BoxFit.fill,

                  )
              ),
            ),
          ),
          const SizedBox(height:5),
          Row(
            children: [
              Text("comment 1",style: FontsManger.mediumFont(context)?.copyWith(color:const Color(0xff606770),fontSize: 15),),
              const Spacer(),
              Text.rich(TextSpan(
                  children: [
                    TextSpan(text: "26",style:FontsManger.mediumFont(context)?.copyWith(color:const Color(0xff606770),fontSize: 15), ),

                    WidgetSpan(child: Image.asset("assets/image/Image 20.png",height: 20,width: 20,)),
                    const WidgetSpan(child: SizedBox(width: 5,)),
                  ]
              ))
            ],
          ),
          const SizedBox(height:5),
          const Divider(
            color: Color(0xffE4E6EB),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    Text(
                      "Comment",
                      style: FontsManger.mediumFont(context)
                          ?.copyWith(
                          fontSize: 10,
                          color: const Color(0xff606770)),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Icon(Icons.chat_bubble_outline,size: 20,color: Color(0xff606770)),
                  ],
                ),
              ),
              InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    Text(
                      "Like",
                      style: FontsManger.mediumFont(context)
                          ?.copyWith(
                          fontSize: 10,
                          color: const Color(0xff606770)),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Icon(Icons.thumb_up_off_alt_outlined,size: 20,color: Color(0xff606770)),
                  ],
                ),
              ),
            ],
          ),
          const Divider(
            color: Color(0xffE4E6EB),
            thickness: 2,
          ),
          Row(
            children: [
              CachedNetworkImage(
                imageUrl:
                "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
                width: 25,
                height: 25,
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                height: 32,
                width: context.width * .76,
                alignment: Alignment.centerRight,
                decoration: BoxDecoration(
                    color: const Color(0xffF0F2F5),
                    borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text("أكتب المنشور الذي تريد رفعه ",
                    style: FontsManger.mediumFont(context)
                        ?.copyWith(
                        fontSize: 10,
                        color: const Color(0xff606770))),
              )
            ],
          ),
        ],
      ),
    );
  }
}
