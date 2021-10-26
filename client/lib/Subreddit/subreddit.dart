import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:redditech/API/api.dart';

class SubRedditComponent extends StatefulWidget {
  const SubRedditComponent({Key? key}) : super(key: key);

  void checkUser() async {
    const storage = FlutterSecureStorage();
    final code = await storage.read(key: 'code');
    print(code);
  }
  @override
  State<SubRedditComponent> createState() => _SubRedditComponentState();
}

class _SubRedditComponentState extends State<SubRedditComponent> {
  List<Widget> cards = List<Widget>.generate(20, (i)=> const HomeCards());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
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
        title: const Text(
          "Home",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
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
                const Image(
                  image: NetworkImage("https://i.imgur.com/mzL45Qy.png")
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
  );}
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
