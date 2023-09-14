import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatefulWidget {
final String videoId;
  const VideoScreen({super.key, required this.videoId});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  YoutubePlayerController? _controller;

@override
  void initState() {
 _controller = YoutubePlayerController(
    initialVideoId: widget.videoId,
    flags: const YoutubePlayerFlags(
      autoPlay: true,
      mute: false,
forceHD: true,
    ),
  );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          YoutubePlayerBuilder(
              player: YoutubePlayer(
bottomActions: const [],
                controller: _controller!,
                aspectRatio: MediaQuery.of(context).size.aspectRatio,
              ),
              builder: (context, player) {
                return player;
              }),
        ],
      )
    );

  }
}

