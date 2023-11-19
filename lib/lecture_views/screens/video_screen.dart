import 'package:afeer/utls/extension.dart';
import 'package:flutter/material.dart';
import 'package:pod_player/pod_player.dart';
//import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatefulWidget {
final String videoId;
  const VideoScreen({super.key, required this.videoId});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late final PodPlayerController controller;

@override
  void initState() {
  controller = PodPlayerController(

      playVideoFrom: PlayVideoFrom.youtube('https://youtu.be/${widget.videoId}'),
      podPlayerConfig: const PodPlayerConfig(
          autoPlay: true,
          isLooping: false,
          videoQualityPriority: [720, 360],

      )
  )..initialise();
 super.initState();
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {


  return Scaffold(
    appBar: AppBar(
      toolbarHeight: 30,
    ),
    body: PodVideoPlayer(controller: controller,matchVideoAspectRatioToFrame: true,frameAspectRatio: (context.width/context.height),matchFrameAspectRatioToVideo: true),
  );
  }



  }


