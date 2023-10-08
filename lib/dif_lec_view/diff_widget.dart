import 'package:afeer/utls/extension.dart';
import 'package:afeer/utls/manger/color_manger.dart';
import 'package:afeer/utls/manger/font_manger.dart';
import 'package:afeer/utls/widget/base_widget.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

import 'lect_screen_dif.dart';

class DiffSubjectWidget extends StatefulWidget {
  final String name;
  final String collection;
  const DiffSubjectWidget({super.key, required this.name, required this.collection});

  @override
  State<DiffSubjectWidget> createState() => _DiffSubjectWidgetState();
}

class _DiffSubjectWidgetState extends State<DiffSubjectWidget> {
  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: (){
      if(context.appCuibt.user?.subscription!=null) {
        context.appCuibt.getLecturesM3dh(widget.name, widget.collection).then((
            value) {
          navigatorWid(page: LectureDiffScreens(
              subjectName: widget.name, collection: widget.collection),
              context: context,
              returnPage: true);
        });
      }else {
        MotionToast.error(description: const Text("من فضلك قم بالاشتراك اولا!")).show(context);

      }
      },
      child: Container(
        height: context.height*.09,
        width: context.width*.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: ColorsManger.scaffoldBackGround,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.4),
              blurRadius: 1,
            )
          ],

        ),
        child: Center(
          child: Text(widget.name,style: FontsManger.blackFont(context)?.copyWith(fontSize: 12,color: ColorsManger.text3.withOpacity(.4))),
        ),
      ),
    );
  }
}
