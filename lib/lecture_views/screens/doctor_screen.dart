import 'package:afeer/cuibt/app_cuibt.dart';
import 'package:afeer/cuibt/app_state.dart';
import 'package:afeer/utls/extension.dart';
import 'package:afeer/utls/manger/color_manger.dart';
import 'package:afeer/utls/manger/font_manger.dart';
import 'package:afeer/utls/widget/base_app_Bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utls/widget/base_widget.dart';
import 'lecture_screens.dart';

class DoctorScreen extends StatefulWidget {
  final String subjectName;

  const DoctorScreen({super.key, required this.subjectName});

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AppCubit,AppState>(
        builder: (context,state) {
          return Column(
            children: [
              const AppBarWidget(),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Align(alignment: Alignment.topRight,child: Text("اختر الدكتور !",style: FontsManger.largeFont(context)?.copyWith(color: ColorsManger.pColor),)),

              ),
              if(context.appCuibt.doctorList.isNotEmpty)
              Expanded(
                child: ListView.separated(
                    padding: const EdgeInsets.all(10),
                    itemBuilder: (context, i) => ListTile(
                      leading: const SizedBox(
                        height: 30,
                        width: 30,
                        child: Icon(Icons.person),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios,color: ColorsManger.pColor),
                      onTap: () {
                        context.appCuibt
                            .getLectures(
                            doctor: context.appCuibt.doctorList[i],
                            subjectName: widget.subjectName)
                            .then((value) => navigatorWid(
                            page: LectureScreens(
                                subjectName: widget.subjectName,doctor: context.appCuibt.doctorList[i] ),
                            context: context,
                            returnPage: true));
                      },
                      title: Text(context.appCuibt.doctorList[i],
                          style: FontsManger.largeFont(context)
                              ?.copyWith(color: ColorsManger.pColor)),
                    ),
                    separatorBuilder: (context, i)=>const SizedBox(height: 10),
                    itemCount: context.appCuibt.doctorList.length),
              ),
              if(context.appCuibt.doctorList.isEmpty)
const Center(
    heightFactor: 5,
    child: Text("عفوا لا يوجد حتي الان محاضرات مضافه"))
            ],
          );
        },
        listener: (context,state){},
      ),
    );
  }
}
