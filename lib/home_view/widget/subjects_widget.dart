import 'package:afeer/utls/extension.dart';
import 'package:afeer/utls/manger/color_manger.dart';
import 'package:afeer/utls/manger/font_manger.dart';
import 'package:afeer/utls/widget/base_widget.dart';
import 'package:flutter/material.dart';

import '../../lecture_views/screens/lecture_screens.dart';

class SubjectWidget extends StatefulWidget {
  final String imagePath;
  final String name;
  final String kind;
  final String  year;
  const SubjectWidget({super.key, required this.imagePath, required this.name, required this.kind, required this.year});

  @override
  State<SubjectWidget> createState() => _SubjectWidgetState();
}

class _SubjectWidgetState extends State<SubjectWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        context.appCuibt.getLecture(nameSubject: widget.name,context: context).then((value) {
          navigatorWid(page:  LectureScreens(subjectName: widget.name),context: context,returnPage: true);

        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
width: context.width*.6,
        height: context.height*.2,
        decoration: BoxDecoration(
          border: Border.all(
            color: ColorsManger.text3.withOpacity(.40),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*CachedNetworkImage(imageUrl:widget.imagePath,
            height: 150,
              width:258 ,
              fit: BoxFit.cover,

            ),*/
            Image.asset(widget.imagePath,       height: context.height*.16,
              width:context.width*.6,
              fit: BoxFit.cover,
            ),
            Divider(color: ColorsManger.text3.withOpacity(.2),),
            Text(widget.name,style: FontsManger.largeFont(context),),
            const SizedBox(height: 5,),
            Text("${widget.year}  ــ  ${widget.kind}",style: FontsManger.mediumFont(context)?.copyWith(fontSize: 13,color: ColorsManger.text3.withOpacity(.4)),),
          ],
        ),
      ),
    );
  }
}
