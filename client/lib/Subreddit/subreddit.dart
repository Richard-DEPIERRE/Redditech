import 'dart:convert';

import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:redditech/API/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubRedditComponent extends StatefulWidget {
  const SubRedditComponent({Key? key, required this.name}) : super(key: key);
  final String name;
  @override
  State<SubRedditComponent> createState() => _SubRedditComponentState();
}

class _SubRedditComponentState extends State<SubRedditComponent> {
  List<Widget> cards = List<Widget>.generate(20, (i)=> const HomeCards());


  @override
  Widget build(BuildContext context) {
    String name = widget.name;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return FutureBuilder<Map<String, dynamic>>(
      future: getSubReddit(name),
      builder: (context, snapshot) {
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

  @override
  Widget build(BuildContext context) {
    final backImage = (subreddit != null && subreddit!['banner_background_image'] != '') ? subreddit!['banner_background_image'] : "https://i.imgur.com/mzL45Qy.png";
    final comImage = (subreddit != null && subreddit!['community_icon'] != '') ? subreddit!['community_icon'] : "https://f.hellowork.com/blogdumoderateur/2015/08/Reddit-alien.png";
    final title = (subreddit != null && subreddit!['title'] != '') ? subreddit!['title'] : "Title unavailable";
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
                      Image(
                        image: NetworkImage(
                          backImage
                        ),
                        height: height * 0.7,
                        fit:BoxFit.fitHeight  
                      ),
                      Positioned(
                        top: 100,
                        left: 50,
                        width: width - 100,
                        height: 250,
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(comImage),
                            ),
                            Text(
                              title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 26,
                              ),
                            ),
                          ],
                        ),
                      )
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
                        // child: component,
                      ),
                    ),
                  ),
                  // Container(
                  //   child: component,
                  // )
                ]
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeCards extends StatelessWidget {
  const HomeCards({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5,
        child: Column(
          children: [
            const ListTile(
              leading: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage('https://www.presse-citron.net/app/uploads/2019/04/playstation-5-premiers-details-prix-date-de-sortie.jpg'),
              ),
              title: Text(
                "r/playstation5",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              subtitle: Text(
                "u/gamedas • 4h",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              trailing: Icon(
                Icons.more_horiz_rounded,
                color: Colors.grey,
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "All PS5 info!",
                  style: TextStyle(
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
                child: const Image(
                  image: NetworkImage('https://www.ma-reduc.com/assets/YPUKv7iJnXmx8WRh78P6pw/r720--/upload/cfs/acheter-ps55f6cb80cccf271.62576126.jpg'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
