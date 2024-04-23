import 'dart:io';

import 'package:afeer/utls/extension.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pod_player/pod_player.dart';

import '../../../utls/crypto_helpear.dart';
import '../../../utls/manger/font_manger.dart';

class VideoOffline extends StatefulWidget {
  final Map map;
  const VideoOffline({super.key, required this.map});

  @override
  State<VideoOffline> createState() => _VideoOfflineState();
}

class _VideoOfflineState extends State<VideoOffline> {
    PodPlayerController? controller;
  File? saveLocation;
getData()async{
  Directory directory= await getApplicationCacheDirectory();

  saveLocation =File("${directory.path}/${widget.map["videoId"]}.mp4");
  controller = PodPlayerController(
    playVideoFrom:
    PlayVideoFrom.file(saveLocation!),
    podPlayerConfig: const PodPlayerConfig(
      autoPlay: true,
      isLooping: false,
      forcedVideoFocus: true,
      videoQualityPriority: [720, 360],
    ),
  )..initialise();
  controller?.addListener(() async {
    if(controller?.isInitialised==true){
      if(await saveLocation?.exists()==true){
        saveLocation?.delete();
      }
    }
  });

  setState(() {

  });
}
  @override
  void initState() {
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        if(await saveLocation?.exists()==true){
        saveLocation?.delete();
        }
        return Future(() => true);
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 50,
          title: Text(widget.map["lectureName"],style: FontsManger.largeFont(context),),
          centerTitle: true,
        ),
        body: controller!=null?PodVideoPlayer(
            controller: controller!,

            matchVideoAspectRatioToFrame: true,
            onLoading: (context) => const CircularProgressIndicator(),
            frameAspectRatio: (context.width / context.height),
            matchFrameAspectRatioToVideo: true):Center(child: CircularProgressIndicator()),

      ),
    );
  }
}
