import 'package:afeer/utls/extension.dart';
import 'package:afeer/utls/manger/color_manger.dart';
import 'package:afeer/utls/manger/font_manger.dart';
import 'package:afeer/utls/widget/base_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

import '../../lecture_views/screens/doctor_screen.dart';

class AddSubjectWidget extends StatefulWidget {
  final String imagePath;
  final String name;
  final String kind;
  final String  year;
  const AddSubjectWidget({super.key, required this.imagePath, required this.name, required this.kind, required this.year});

  @override
  State<AddSubjectWidget> createState() => _AddSubjectWidgetState();
}

class _AddSubjectWidgetState extends State<AddSubjectWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if(context.appCuibt.user?.subscription!=null){
          if(context.appCuibt.user?.subscription!.isASingleSubject==true){
            if(context.appCuibt.user?.subscription!.singleSubject!.contains(widget.name)==true){
              context.appCuibt.getAddSubjectDoctor(subjectName:  widget.name,year: widget.year).then((value) {
                navigatorWid(page: DoctorScreen(subjectName: widget.name,add: true,year: widget.year),returnPage: true,context: context);
              });
            }else{
              MotionToast.error(description: const Text("من فضلك قم بالاشتراك اولا في هذه الماده!")).show(context);

            }

          }else {
            context.appCuibt.getAddSubjectDoctor(subjectName:  widget.name,year:widget.year ).then((value) {
              navigatorWid(page: DoctorScreen(subjectName: widget.name,add: true,year: widget.year),returnPage: true,context: context);
            });
          }

        }else {
          MotionToast.error(description: const Text("من فضلك قم بالاشتراك اولا!")).show(context);
        }

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
            CachedNetworkImage(imageUrl:widget.imagePath,
                height: context.height*.16,
                width:context.width*.6,
                fit: BoxFit.cover,
                errorWidget: (context,i,_)=>  SizedBox(
                  height: context.height*.16,
                  width:context.width*.6,
                  child: const Icon(Icons.school),
                )
            ),
            Divider(color: ColorsManger.text3.withOpacity(.2),),
            Text(widget.name,style: FontsManger.largeFont(context),),
            const SizedBox(height: 5,),
            Text(widget.kind,style: FontsManger.mediumFont(context)?.copyWith(fontSize: 13,color: ColorsManger.text3.withOpacity(.4)),),
          ],
        ),
      ),
    );
  }
}
