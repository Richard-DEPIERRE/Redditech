import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redditech/shared/video.dart';
import 'package:video_player/video_player.dart';

class HomeCards extends StatefulWidget {
  HomeCards({
    Key? key,
    required this.subreddit,
    required this.author,
    required this.date,
    required this.title,
    required this.media,
    required this.type,
  }) : super(key: key);
  final String subreddit;
  final String author;
  final String date;
  final String title;
  final String media;
  final String type;
  @override
  State<HomeCards> createState() => _HomeCards();
}

class _HomeCards extends State<HomeCards> {

  Widget mediaInput = Container();
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    print("type : " + widget.type);
    switch (widget.type) {
      case 'text':
        mediaInput = Text(
          widget.media,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.grey
          ),
        );
        break;
      case 'photo':
        mediaInput = Image(image: NetworkImage(widget.media));
        break;
      case 'video':
        print(widget.media);
        mediaInput = VideoApp(title: widget.media);
        break;
      case 'youtube':
        print(widget.media);
        mediaInput = VideoApp(title: widget.media);
        break;
      default:
    }
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5,
        child: Column(
          children: [
            ListTile(
              leading: const CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage("https://f.hellowork.com/blogdumoderateur/2015/08/Reddit-alien.png"),
              ),
              title: Text(
                widget.subreddit,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
              subtitle: Text(
                "u/"+ widget.author +" • "+ widget.date,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
              trailing: const Icon(
                Icons.more_horiz_rounded,
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Color.fromRGBO(37, 37, 39, 1),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: mediaInput
              ),
            ),
          ],
        ),
      ),
    );
  }
}