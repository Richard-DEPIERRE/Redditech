import 'dart:convert';

import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:redditech/API/api.dart';
import 'package:redditech/shared/cards.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubRedditComponent extends StatefulWidget {
  const SubRedditComponent({Key? key}) : super(key: key);
  @override
  State<SubRedditComponent> createState() => _SubRedditComponentState();
}

class _SubRedditComponentState extends State<SubRedditComponent> {
  // List<Widget> cards = List<Widget>.generate(20, (i)=> const HomeCardsSub());


  @override
  Widget build(BuildContext context) {
    final LocalStorage storage = LocalStorage('redditech');
    String name = storage.getItem("subreddit");
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return FutureBuilder<Map<String, dynamic>>(
      future: getSubReddit(name),
      builder: (context, snapshot) {
        print(snapshot.data);
        switch(snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator(),);
          default:
            return Subredd(name: name, height: height, width: width, subreddit: snapshot.data);
        }
    }
  );}
}

class Subredd extends StatelessWidget {
  const Subredd({
    Key? key,
    required this.name,
    required this.height,
    required this.width,
    required this.subreddit
  }) : super(key: key);

  final String name;
  final double height;
  final double width;
  final Map<String, dynamic>? subreddit;

  String k_m_b_generator(num) {
    if (num > 999 && num < 99999) {
      return "${(num / 1000).toStringAsFixed(1)} K";
    } else if (num > 99999 && num < 999999) {
      return "${(num / 1000).toStringAsFixed(0)} K";
    } else if (num > 999999 && num < 999999999) {
      return "${(num / 1000000).toStringAsFixed(1)} M";
    } else if (num > 999999999) {
      return "${(num / 1000000000).toStringAsFixed(1)} B";
    } else {
      return num.toString();
    }
  }

  Future<bool> changeSub(bool subbed, String fullname) async {
    return await changeSubbed(subbed, fullname);
  }

  @override
  Widget build(BuildContext context) {
    Widget widget;
    List<Widget> cards = List<Widget>.generate(subreddit!['posts'].length, (i) =>
      HomeCards(
        author: subreddit!['posts'][i]['author'],
        date: subreddit!['posts'][i]['date'],
        subreddit: subreddit!['posts'][i]['subreddit'],
        title: subreddit!['posts'][i]['title'],
        media: subreddit!['posts'][i]['media'],
        type: subreddit!['posts'][i]['type']
      )
    );
    final backImage = (subreddit != null && subreddit!['banner_background_image'] != '') ? subreddit!['banner_background_image'] : "https://i.imgur.com/mzL45Qy.png";
    final comImage = (subreddit != null && subreddit!['community_icon'] != '') ? subreddit!['community_icon'] : "https://f.hellowork.com/blogdumoderateur/2015/08/Reddit-alien.png";
    final title = (subreddit != null && subreddit!['title'] != '') ? subreddit!['title'] : "Title unavailable";
    final url = (subreddit != null && subreddit!['url'] != '') ? subreddit!['url'] : "url unavailable";
    final description = (subreddit != null && subreddit!['description'] != '') ? subreddit!['description'] : "description unavailable";
    final fullname = (subreddit != null && subreddit!['name'] != '') ? subreddit!['name'] : "";
    final int subscribers = (subreddit != null && subreddit!['subscribers'] != '') ? subreddit!['subscribers'] : 0;
    bool subscribed = (subreddit != null && subreddit!['subscribed'] != '') ? subreddit!['subscribed'] : false;
    if (subscribed) {
      widget = ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14)
          ),
          side: const BorderSide(
            width: 2,
            color: Colors.grey,
          ),
          textStyle: const TextStyle(
            fontSize: 24,
          ),
        ),
        onPressed: () {
          changeSub(subscribed, fullname);
          subscribed = !subscribed;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SubRedditComponent(),
            )
          );
        },
        child: const Text(
          "Leave"
        )
      );
    } else {
      widget = ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: const Color.fromRGBO(255, 69, 0, 1),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14)),
          textStyle: const TextStyle(
            fontSize: 24,
          ),
        ),
        onPressed: () {
          changeSub(subscribed, fullname);
          subscribed = !subscribed;
          Navigator.pushNamed(context, '/subreddit');
        },
        child: Row(
          children: const[
            Icon(
              Icons.add
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: Text(
                "Join"
              ),
            ),
          ],
        )
      );
    }
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: false,
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 0.0, 10.0),
          child: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
            icon: const Icon(Icons.arrow_back),
          ),    
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 10.0, 20.0, 10.0),
            child: IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.black,
                size: 30,
              ),
              tooltip: 'Search',
              onPressed: () => {},
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              child: Stack(
                children: [
                  Stack(
                    children: [
                      ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.8),
                          BlendMode.srcOver
                        ),
                        child: Image(
                          image: NetworkImage(
                            backImage
                          ),
                          height: height * 0.7,
                          fit:BoxFit.fitHeight,
                        ),
                      ),
                      Positioned(
                        top: 50,
                        height: 250,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
                              child: CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(comImage),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(12.0, 0.0, 0.0, 0.0),
                              child: Text(
                                title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 80,
                        height: 250,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(102, 5, 0, 0),
                              child: Text(
                                url,
                                style: const TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 0.8),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        top: 240,
                        height: 250,
                        width: 375,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 0.0),
                          child: Text(
                            description,
                            style: const TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 0.5),
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 250,
                        height: 250,
                        width: 375,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(80, 0, 0, 0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                              Text(
                                k_m_b_generator(subscribers),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 20,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                                child: widget,
                              )
                            ],
                          ),
                        ),
                      ),
                    ]
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.only(
                        top: height * 0.50,
                        right: 0.0,
                        left: 0.0),
                    child: SizedBox(
                      height: height,
                      width: width,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        color: Colors.white,
                        elevation: 4.0,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: ListView(
                            children: cards,
                          ),
                        ),
                      ),
                    ),
                  ),
                ]
              ),
            ),
          ],
        ),
      ),
    );
  }
}