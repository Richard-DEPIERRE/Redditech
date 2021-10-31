import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:redditech/API/api.dart';
import 'package:redditech/shared/cards.dart';

class SubRedditComponent extends StatefulWidget {
  const SubRedditComponent({Key? key, this.type = "Best"}) : super(key: key);
  final String type;
  @override
  State<SubRedditComponent> createState() => _SubRedditComponentState();
}

class _SubRedditComponentState extends State<SubRedditComponent> {
  String titleSub = "Best";
  void changeState(String state) {
    print(state);
    setState(() {
      titleSub = state;
    });
  }

  String kmbGenerator(num) {
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
    final LocalStorage storage = LocalStorage('redditech');
    String name = storage.getItem("subreddit");
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return FutureBuilder<Map<String, dynamic>>(
      future: getSubReddit(name, titleSub),
      builder: (context, snapshot) {
        print(snapshot.data);
        switch(snapshot.connectionState) {
          case ConnectionState.waiting:
            return Container(
              color: Colors.white,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          default:
                List<Widget> test1 = [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(22, 10, 32, 0),
                    child: SizedBox(
                      width: width * 0.888,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Row(
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color: (titleSub == "Best") ? const Color.fromRGBO(255, 69, 0, 1): Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(1, 0, 1, 0),
                                child: TextButton(
                                  onPressed: () => changeState("Best"),
                                  child: Text(
                                    "Best",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: (titleSub == "Best") ? Colors.white : const Color.fromRGBO(165, 165, 165, 1)
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color: (titleSub == "Hot") ? const Color.fromRGBO(255, 69, 0, 1): Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(1, 0, 1, 0),
                                child: TextButton(
                                  onPressed: () => changeState("Hot"),
                                  child: Text(
                                    "Hot",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: (titleSub == "Hot") ? Colors.white : const Color.fromRGBO(165, 165, 165, 1)
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color: (titleSub == "New") ? const Color.fromRGBO(255, 69, 0, 1): Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(1, 0, 1, 0),
                                child: TextButton(
                                  onPressed: () => changeState("New"),
                                  child: Text(
                                    "New",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: (titleSub == "New") ? Colors.white : const Color.fromRGBO(165, 165, 165, 1)
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color: (titleSub == "Top") ? const Color.fromRGBO(255, 69, 0, 1): Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(1, 0, 1, 0),
                                child: TextButton(
                                  onPressed: () => changeState("Top"),
                                  child: Text(
                                    "Top",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: (titleSub == "Top") ? Colors.white : const Color.fromRGBO(165, 165, 165, 1)
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ];
                Widget widget;
                List<Widget> cards = List<Widget>.from(test1)..addAll(List<Widget>.generate(snapshot.data!['posts'].length, (i) =>
                  HomeCards(
                    author: snapshot.data!['posts'][i]['author'],
                    date: snapshot.data!['posts'][i]['date'],
                    subreddit: snapshot.data!['posts'][i]['subreddit'],
                    title: snapshot.data!['posts'][i]['title'],
                    media: snapshot.data!['posts'][i]['media'],
                    type: snapshot.data!['posts'][i]['type']
                  )
                ));
                final backImage = (snapshot.data != null && snapshot.data!['banner_background_image'] != '') ? snapshot.data!['banner_background_image'] : "https://i.imgur.com/mzL45Qy.png";
                final comImage = (snapshot.data != null && snapshot.data!['community_icon'] != '') ? snapshot.data!['community_icon'] : "https://f.hellowork.com/blogdumoderateur/2015/08/Reddit-alien.png";
                final title = (snapshot.data != null && snapshot.data!['title'] != '') ? snapshot.data!['title'] : "Title unavailable";
                final url = (snapshot.data != null && snapshot.data!['url'] != '') ? snapshot.data!['url'] : "url unavailable";
                final description = (snapshot.data != null && snapshot.data!['description'] != '') ? snapshot.data!['description'] : "description unavailable";
                final fullname = (snapshot.data != null && snapshot.data!['name'] != '') ? snapshot.data!['name'] : "";
                final int subscribers = (snapshot.data != null && snapshot.data!['subscribers'] != '') ? snapshot.data!['subscribers'] : 0;
                bool subscribed = (snapshot.data != null && snapshot.data!['subscribed'] != '') ? snapshot.data!['subscribed'] : false;
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
                          Navigator.pop(context);
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
                                            kmbGenerator(subscribers),
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
                                padding: EdgeInsets.only(top: height * 0.50),
                                child: SizedBox(
                                  height: height * 0.8,
                                  width: width,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    color: Colors.white,
                                    elevation: 4.0,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(12.0, 0, 12, 12),
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
            // return Subredd(name: name, height: height, width: width, subreddit: snapshot.data);
            
        }
    }
  );}
}