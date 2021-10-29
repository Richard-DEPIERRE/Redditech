import 'package:flutter/material.dart';
import 'package:redditech/shared/basic_overlay_widget.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatelessWidget {
  const VideoPlayerWidget ({Key ?key, required this.controller}) : super(key: key);
  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) => 
    controller != null && controller.value.isInitialized
      ? 
      Container(
        alignment: Alignment.topCenter,
        child: buildVideo(),
      )
      : Container(
        height: 200,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
  Widget buildVideo() => Stack(
    children: [
      buildVideoPlayer(),
      Positioned.fill(child: BasicOverlayWidget(controller: controller))
    ]
  );
  Widget buildVideoPlayer() => AspectRatio(
    aspectRatio: controller.value.aspectRatio,
    child: VideoPlayer(controller)
  );
}