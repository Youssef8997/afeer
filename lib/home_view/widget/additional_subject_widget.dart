import 'package:afeer/utls/extension.dart';
import 'package:afeer/utls/manger/color_manger.dart';
import 'package:afeer/utls/manger/font_manger.dart';
import 'package:afeer/utls/widget/base_widget.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

import '../../add_lec_view/screen/lect_screens.dart';

class AdditionalSubjectWidget extends StatefulWidget {
  final String name;
  const AdditionalSubjectWidget({super.key, required this.name});

  @override
  State<AdditionalSubjectWidget> createState() => _AdditionalSubjectWidgetState();
}

class _AdditionalSubjectWidgetState extends State<AdditionalSubjectWidget> {
  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: (){
      if(context.appCuibt.user?.subscription!=null) {
        context.appCuibt.getLecturesAdditional(widget.name).then((value) {
          navigatorWid(page: LectureAddScreens(subjectName: widget.name,),
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
