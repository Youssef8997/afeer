import 'package:afeer/utls/extension.dart';
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

 _controller?.toggleFullScreenMode();

 super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return YoutubePlayerBuilder(

        player: YoutubePlayer(
          aspectRatio: (context.height/context.width),
          controller: _controller!,
          showVideoProgressIndicator: true,

          progressIndicatorColor: Colors.blueAccent,
          topActions: <Widget>[
            const SizedBox(width: 8.0),
            Text(

              _controller?.value.playbackQuality ?? '',
            ),
            Expanded(
              child: Text(
                _controller!.metadata.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            const SizedBox(width: 30.0),
            InkWell(onTap: (){
              Navigator.pop(context);
              Navigator.pop(context);
            },child: const Icon(Icons.arrow_forward_outlined,color: Colors.white,size: 30),)
          ],

        ),
        builder: (context, player) => Scaffold(
            appBar: AppBar(
              leading: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: BackButton(
                  onPressed: (){
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                )
              ),
              title: const Text(
                'Youtube Player Flutter',
                style: TextStyle(color: Colors.white),
              ),

            ),
          body: player,
        ),);


  }
}

