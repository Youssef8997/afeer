import 'dart:io';

import 'package:afeer/utls/extension.dart';
import 'package:afeer/utls/manger/color_manger.dart';
import 'package:afeer/utls/manger/font_manger.dart';
import 'package:afeer/utls/widget/base_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

import '../../lecture_views/screens/doctor_screen.dart';

class SubjectWidget extends StatefulWidget {
  final String imagePath;
  final String imagePath2;
  final String name;
  final String kind;
  final String info;
  final String time;
  final String year;
  final bool isRev;
  final int index;

  const SubjectWidget(
      {super.key,
      required this.imagePath,
      required this.imagePath2,
      required this.name,
      required this.kind,
      required this.time,
      required this.index,
      required this.year,
      this.isRev = false,
      required this.info});

  @override
  State<SubjectWidget> createState() => _SubjectWidgetState();
}

class _SubjectWidgetState extends State<SubjectWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this, // Associate the AnimationController
      // with teh widget's lifecycle
      duration: const Duration(seconds: 1),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
    _animationController.forward();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: InkWell(
        onTap: () {
          if (widget.isRev) {
            if (context.appCuibt.user!.subscriptionRev.contains(widget.name)) {
              context.appCuibt
                  .getSubjectDoctor(
                subjectName: widget.name,
              )
                  .then((value) {
                navigatorWid(
                    page: DoctorScreen(
                      info: widget.info,
                      subjectName: widget.name,
                      time: widget.time,
                      imagePath: widget.imagePath2,
                    ),
                    returnPage: true,
                    context: context);
              });
            } else {
              final snackBar = SnackBar(
                backgroundColor: Colors.red,
                content: Text('انت غير مشترك برجاء التواصل مع خدمه العملاء',
                    style: FontsManger.largeFont(context)
                        ?.copyWith(color: ColorsManger.white)),
                showCloseIcon: true,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          } else {
            if (context.appCuibt.isVisitor) {
              context.appCuibt
                  .getSubjectDoctorV(
                subjectName: widget.name,
              )
                  .then((value) {
                navigatorWid(
                    page: DoctorScreen(
                      info: widget.info,
                      time: widget.time,
                      subjectName: widget.name,
                      imagePath: widget.imagePath2,
                    ),
                    returnPage: true,
                    context: context);
              });
            } else {
              context.appCuibt
                  .getSubjectDoctor(
                subjectName: widget.name,
              )
                  .then((value) {
                navigatorWid(
                    page: DoctorScreen(
                      info: widget.info,
                      time: widget.time,
                      subjectName: widget.name,
                      imagePath: widget.imagePath2,
                    ),
                    returnPage: true,
                    context: context);
              });
            }
          }

          /*        if(context.appCuibt.user?.subscription!=null){
            if(context.appCuibt.user?.subscription!.isASingleSubject==true){
              if(context.appCuibt.user?.subscription!.singleSubject!.contains(widget.name)==true){
                context.appCuibt.getSubjectDoctor(subjectName:  widget.name,).then((value) {
                  navigatorWid(page: DoctorScreen(subjectName: widget.name,),returnPage: true,context: context);
                });
              }else{
                MotionToast.error(description: const Text("من فضلك قم بالاشتراك اولا في هذه الماده!")).show(context);
      
              }
      
            }else {
              context.appCuibt.getSubjectDoctor(subjectName:  widget.name,).then((value) {
                navigatorWid(page: DoctorScreen(subjectName: widget.name,),returnPage: true,context: context);
              });
            }
          }else {
            if(context.appCuibt.isVisitor==true){
      
      
            }else {
              context.appCuibt.getSubjectDoctor(subjectName:  widget.name,).then((value) {
                navigatorWid(page: DoctorScreen(subjectName: widget.name,),returnPage: true,context: context);
              });
      
            }
          }*/
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
              const SizedBox(
                height: 7,
              ),
              Text(
                widget.name,
                style: FontsManger.largeFont(context)
                    ?.copyWith(fontSize: 13, color: const Color(0xff242126)),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                widget.kind,
                style: FontsManger.mediumFont(context)?.copyWith(
                    fontSize: 9,
                    color: const Color(0xff242126).withOpacity(.65)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool apple() {
    if (context.appCuibt.home.applePay && Platform.isIOS) {
      return true;
    } else if (Platform.isAndroid) {
      return true;
    } else {
      return false;
    }
  }
}
