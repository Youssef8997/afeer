import 'package:afeer/utls/extension.dart';
import 'package:afeer/utls/manger/color_manger.dart';
import 'package:afeer/utls/manger/font_manger.dart';
import 'package:afeer/utls/widget/base_widget.dart';
import 'package:afeer/views/lecture_views/screens/doctor_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'dart:io' show Platform;
import '../../add_lec_view/screen/lect_screens.dart';

class AdditionalSubjectWidget extends StatefulWidget {
  final String name;
  final String imagePath;
  const AdditionalSubjectWidget(
      {super.key, required this.name, required this.imagePath});

  @override
  State<AdditionalSubjectWidget> createState() =>
      _AdditionalSubjectWidgetState();
}

class _AdditionalSubjectWidgetState extends State<AdditionalSubjectWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (Platform.isIOS && context.appCuibt.home.applePay) {
          context.appCuibt.getLecturesAdditional(widget.name).then((value) {
            navigatorWid(
                page: DoctorScreen(
                  subjectName: widget.name,
                  info: "",
                  time: "",
                  add: true,
                  imagePath: widget.imagePath,
                ),
                context: context,
                returnPage: true);
          });
        } else {
          if (context.appCuibt.user?.subscription != null) {
            context.appCuibt.getLecturesAdditional(widget.name).then((value) {
              navigatorWid(
                  page: DoctorScreen(
                    subjectName: widget.name,
                    info: "",
                    time: "",
                    add: true,
                    imagePath: widget.imagePath,
                  ),
                  context: context,
                  returnPage: true);
            });
          } else {
            MotionToast.error(
                    description: const Text("من فضلك قم بالاشتراك اولا!"))
                .show(context);
          }
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        width: context.width * .4,
        height: context.height * .35,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
                imageUrl: widget.imagePath,
                height: context.height * .25,
                width: context.width * .33,
                fit: BoxFit.fill,
                imageBuilder: (context, i) => Container(
                      height: context.height * .25,
                      width: context.width * .32,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.3),
                              offset: const Offset(0, 3),
                              blurRadius: 6,
                            ),
                          ],
                          image: DecorationImage(
                            image: i,
                            fit: BoxFit.fill,
                          )),
                    ),
                errorWidget: (context, i, _) => SizedBox(
                      height: context.height * .16,
                      width: context.width * .6,
                      child: const Icon(Icons.school),
                    )),
            SizedBox(
              height: 7,
            ),
            Text(
              widget.name,
              style: FontsManger.largeFont(context)
                  ?.copyWith(fontSize: 13, color: Color(0xff242126)),
            ),
          ],
        ),
      ),
    );
  }
}
