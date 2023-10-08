
import 'package:afeer/models/comment_model.dart';
import 'package:afeer/news_view/widget/comment_widget.dart';
import 'package:afeer/utls/extension.dart';
import 'package:afeer/utls/manger/color_manger.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../auth_views/screens/auth_home_screen.dart';
import '../../models/posts_model.dart';
import '../../pdf_view.dart';
import '../../utls/manger/font_manger.dart';
import '../../utls/widget/base_widget.dart';
import '../../utls/widget/text_form.dart';

class PostWidget extends StatefulWidget {
  final PostsModel post;
  const PostWidget({super.key, required this.post});

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
 late TextEditingController commentController;
 List <CommentModel>comments=[];
  @override
  void initState() {
    commentController=TextEditingController();
    comments=widget.post.comments!;
    super.initState();
  }
  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "منصة عافر التعليمية",
            style: FontsManger.mediumFont(context)
                ?.copyWith(
                fontSize: 15,
                color: const Color(0xff1D1F23)),
          ),
          Text(
            "${widget.post.time!.toDate().month}/${widget.post.time!.toDate().day}",
            style: FontsManger.mediumFont(context)
                ?.copyWith(
                fontSize: 13,
                color: const Color(0xff606770)),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.post.title,
            style: FontsManger.mediumFont(context)
                ?.copyWith(color: const Color(0xff1D1F23),fontSize: 16),textAlign: TextAlign.start,
          ),
          const SizedBox(height:10),
          if(widget.post.linkImage!=null)
            CachedNetworkImage(
              imageUrl: widget.post.linkImage!,
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
          if(widget.post.linkPdf!=null)
            IconButton(onPressed: ()=>navigatorWid(page: PdfView(pdfLink: widget.post.linkPdf!)), icon: const Icon(Icons.picture_as_pdf)),
          const SizedBox(height:5),
          Row(
            children: [
              Text("تعليق ${widget.post.comments?.length}",style: FontsManger.mediumFont(context)?.copyWith(color:const Color(0xff606770),fontSize: 15),),
              const Spacer(),
              Text.rich(TextSpan(
                  children: [
                    TextSpan(text: widget.post.likedId?.length.toString(),style:FontsManger.mediumFont(context)?.copyWith(color:const Color(0xff606770),fontSize: 15), ),

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
                onTap: () {
                  showDialog(
                      context: context,
                      useRootNavigator: false,

                      builder: (ctx) => AlertDialog(

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                          backgroundColor: Colors.white,
                          content: StatefulBuilder(
                            builder: (BuildContext context, StateSetter setState) {
                              return Container(
                                height: context.height*.9,
                                width: context.width,
                                color: Colors.white,

                                child: Column(
                                  children: [
                                    Expanded(
                                      child: ListView(
                                        children: [
                                          for(int i=0;i<comments.length;i++)
                                            CommentWidget(comment: comments[i]),

                                        ],
                                      ),
                                    ),
                                    TextFormWidget(
                                      controller:commentController ,
                                      label: "أكتب تعليقك",
                                      suffix: IconButton(onPressed: () {
                                        if(context.appCuibt.isVisitor==true){
                                          navigatorWid(page: const AuthHomeScreen(),context: context,returnPage: false);
                                        }else {
                                          CommentModel comment=CommentModel(idUser: context.appCuibt.user!.token, idComment: const Uuid().v4(), comment: commentController.text, time: Timestamp.now() );
                                          context.appCuibt.addComment(comment, widget.post);
                                          setState((){
                                            comments.add(comment);
                                          });
                                          commentController.clear();
                                        }

                                      },icon: Icon(Icons.send,color: ColorsManger.pColor,)),
                                    )
                                  ],
                                ),
                              );
                            }
                          )));
                },
                child: Row(
                  children: [
                    Text(
                      "تعليق",
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
                onTap: () {
                  if(context.appCuibt.isVisitor==true){
                    navigatorWid(page: const AuthHomeScreen(),context: context,returnPage: false);
                  }else {
                    context.appCuibt.addLike(widget.post);

                  }
                },
                child: Row(
                  children: [
                    Text(
                      "اعجاب",
                      style: FontsManger.mediumFont(context)
                          ?.copyWith(
                          fontSize: 10,
                          color:  widget.post.likedId!.contains(context.appCuibt.user?.token)?Colors.blue:const Color(0xff606770)),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                     Icon(Icons.thumb_up_off_alt_outlined,size: 20,color: widget.post.likedId?.contains(context.appCuibt.user?.token)==true?Colors.blue:const Color(0xff606770)),
                  ],
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
