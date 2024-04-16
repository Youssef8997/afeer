import 'package:afeer/models/fun_model.dart';
import 'package:afeer/utls/extension.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pod_player/pod_player.dart';

import '../../../utls/manger/font_manger.dart';

class FunWidget extends StatefulWidget {
  final FunModel fun;
  const FunWidget({super.key, required this.fun});

  @override
  State<FunWidget> createState() => _FunWidgetState();
}

class _FunWidgetState extends State<FunWidget> {
  late final PodPlayerController controller;

  @override
  void initState() {
    controller = PodPlayerController(
        playVideoFrom:
            PlayVideoFrom.youtube('https://youtu.be/${widget.fun.video}'),
        podPlayerConfig: const PodPlayerConfig(
          autoPlay: false,
          isLooping: false,
          videoQualityPriority: [720, 360],
        ))
      ..initialise();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            useRootNavigator: false,
            useSafeArea: false,
            builder: (ctx) => Dialog(
                insetPadding: EdgeInsets.zero,
                elevation: 5,
                backgroundColor: Colors.black.withOpacity(.2),
                child: SizedBox(
                  width: context.width,
                  height: context.height,
                  child: PodVideoPlayer(
                      controller: controller,
                      matchVideoAspectRatioToFrame: true,
                      frameAspectRatio: (context.width / context.height),
                      matchFrameAspectRatioToVideo: true),
                )));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        width: context.width * .4,
        height: context.height * .35,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
                imageUrl: widget.fun.image,
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
              widget.fun.name,
              style: FontsManger.largeFont(context)
                  ?.copyWith(fontSize: 13, color: const Color(0xff242126)),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              widget.fun.kind,
              style: FontsManger.mediumFont(context)?.copyWith(
                  fontSize: 9, color: const Color(0xff242126).withOpacity(.65)),
            ),
          ],
        ),
      ),
    );
  }
}
