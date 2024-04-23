import 'dart:async';

import 'package:afeer/utls/extension.dart';
import 'package:afeer/utls/manger/font_manger.dart';
import 'package:afeer/utls/widget/base_widget.dart';
import 'package:afeer/views/lecture_views/screens/video_offline_screen.dart';
import 'package:flutter/material.dart';

class OfflineVVideoScree extends StatefulWidget {
  const OfflineVVideoScree({super.key});

  @override
  State<OfflineVVideoScree> createState() => _OfflineVVideoScreeState();
}

class _OfflineVVideoScreeState extends State<OfflineVVideoScree> {
  @override
  void initState() {
    context.appCuibt.getBox();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        title: Text("الفيديوهات المحفوظه",style: FontsManger.largeFont(context),),
        centerTitle: true,
      ),
      body: ListView.separated(padding: EdgeInsets.all(20),itemBuilder: (context,i)=>ListTile(
        onTap: (){
          showLoading(context);
Timer(Duration(milliseconds: 400), () {
  context.appCuibt.deVideo(context.appCuibt.myVideos[i]["videoId"],context,context.appCuibt.myVideos[i]);

});



        },
        title: Text(context.appCuibt.myVideos[i]["title"],style: FontsManger.largeFont(context),),
     trailing: Icon(Icons.arrow_forward_ios),
        subtitle: Text(context.appCuibt.myVideos[i]["lectureName"],style: FontsManger.mediumFont(context)?.copyWith(color: Colors.grey[400]),),
      ), separatorBuilder: (context,i)=>SizedBox(height: 20,), itemCount: context.appCuibt.myVideos.length),
    );
  }
}
