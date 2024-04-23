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
  final String imagePath2;
  final String name;
  final String time;
  final String kind;
  final String year;
  const AddSubjectWidget(
      {super.key,
      required this.imagePath,
      required this.name,
      required this.imagePath2,
      required this.time,
      required this.kind,
      required this.year});

  @override
  State<AddSubjectWidget> createState() => _AddSubjectWidgetState();
}

class _AddSubjectWidgetState extends State<AddSubjectWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (context.appCuibt.user?.subscription != null) {
          if (context.appCuibt.user?.subscription!.isASingleSubject == true) {
            if (context.appCuibt.user?.subscription!.singleSubject!
                    .contains(widget.name) ==
                true) {
              context.appCuibt
                  .getAddSubjectDoctor(
                      subjectName: widget.name, year: widget.year)
                  .then((value) {
                navigatorWid(
                    page: DoctorScreen(
                        subjectName: widget.name,
                        info: widget.kind,
                        time: widget.time,
                        add: true,
                        year: widget.year,
                        imagePath: widget.imagePath2),
                    returnPage: true,
                    context: context);
              });
            } else {
              MotionToast.error(
                      description: const Text(
                          "من فضلك قم بالاشتراك اولا في هذه الماده!"))
                  .show(context);
            }
          } else {
            context.appCuibt
                .getAddSubjectDoctor(
                    subjectName: widget.name, year: widget.year)
                .then((value) {
              navigatorWid(
                  page: DoctorScreen(
                      subjectName: widget.name,
                      info: widget.kind,
                      add: true,
                      time: widget.time,
                      year: widget.year,
                      imagePath: widget.imagePath2),
                  returnPage: true,
                  context: context);
            });
          }
        } else {
          MotionToast.error(
                  description: const Text("من فضلك قم بالاشتراك اولا!"))
              .show(context);
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
            const SizedBox(
              height: 5,
            ),
            Text(
              widget.kind,
              style: FontsManger.mediumFont(context)
                  ?.copyWith(fontSize: 9, color: const Color(0xff707070)),
            ),
          ],
        ),
      ),
    );
  }
}
