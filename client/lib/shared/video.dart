import 'package:flutter/material.dart';
import 'package:redditech/shared/video_player_widget.dart';
import 'package:video_player/video_player.dart';

class VideoApp extends StatefulWidget {
  VideoApp({Key? key, required this.title}) : super(key: key);
  String title;
  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.title);
    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
  }

  @override
  Widget build(BuildContext context) {
    return VideoPlayerWidget(controller: _controller);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}