import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:redditech/API/api.dart';
import 'package:redditech/shared/cards.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class HomeComponent extends StatefulWidget {
  const HomeComponent({Key? key, this.title = 'Best'}) : super(key: key);
  final String title;

  @override
  State<HomeComponent> createState() => _HomeComponentState();
}

class _HomeComponentState extends State<HomeComponent> {
  String title = "Best";
  void changeState(String state) {
    print(state);
    setState(() {
      title = state;
    });
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: getHome(title),
      builder: (context, snapshot) {
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
                    padding: const EdgeInsets.fromLTRB(20, 10, 23, 0),
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
                              color: (title == "Best") ? const Color.fromRGBO(255, 69, 0, 1): Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
                                child: TextButton(
                                  onPressed: () => changeState("Best"),
                                  child: Text(
                                    "Best",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: (title == "Best") ? Colors.white : const Color.fromRGBO(165, 165, 165, 1)
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color: (title == "Hot") ? const Color.fromRGBO(255, 69, 0, 1): Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
                                child: TextButton(
                                  onPressed: () => changeState("Hot"),
                                  child: Text(
                                    "Hot",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: (title == "Hot") ? Colors.white : const Color.fromRGBO(165, 165, 165, 1)
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color: (title == "New") ? const Color.fromRGBO(255, 69, 0, 1): Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
                                child: TextButton(
                                  onPressed: () => changeState("New"),
                                  child: Text(
                                    "New",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: (title == "New") ? Colors.white : const Color.fromRGBO(165, 165, 165, 1)
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color: (title == "Top") ? const Color.fromRGBO(255, 69, 0, 1): Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
                                child: TextButton(
                                  onPressed: () => changeState("Top"),
                                  child: Text(
                                    "Top",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: (title == "Top") ? Colors.white : const Color.fromRGBO(165, 165, 165, 1)
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
            List<Widget> cards = List<Widget>.from(test1)..addAll(List<Widget>.generate(snapshot.data!.length, (i) =>
              HomeCards(
                author: snapshot.data![i]['author'],
                date: snapshot.data![i]['date'],
                subreddit: snapshot.data![i]['subreddit'],
                title: snapshot.data![i]['title'],
                media: snapshot.data![i]['media'],
                type: snapshot.data![i]['type']
              )
            ));
            final LocalStorage storage = LocalStorage('redditech');
            return Scaffold(
              key: _scaffoldKey,
              appBar: AppBar(
                backgroundColor: Colors.white,
                centerTitle: false,
                leading: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 0.0, 10.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/profil');
                    },
                    child: const CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage('https://f.hellowork.com/blogdumoderateur/2015/08/Reddit-alien.png'),
                      backgroundColor: Colors.grey,
                    ),
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
                      onPressed: () async {
                          final res = await getAutocomplete();
                          final result = await showSearch(
                              context: context, delegate: SubredditSearch(subRedditList: res));
                          storage.setItem('subreddit', result.toString());
                          Navigator.pushNamed(context, '/subreddit');
                        },
                    ),
                  )
                ],
              ),
              body: Column(
                children: [
                  Container(
                    height: height * 0.84,
                    child: ListView(
                      children: cards,
                    ),
                  ),
                ],
              ),
            );
            // return HomeReddit(height: height, width: width, title: widget.title, subreddit: snapshot.data);
        }
    }
  );}
}


class SubredditSearch extends SearchDelegate<String> {
  SubredditSearch({Key? key, required this.subRedditList});
  List<Map<String, dynamic>> subRedditList = [];

  @override
  List<Widget> buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (query.isEmpty) {
              close(context, "Done");
            } else {
              query = '';
              showSuggestions(context);
            }
          },
        )
      ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        onPressed: () {
          close(context, "close");
        },
        icon: const Icon(Icons.arrow_back),
      );

  @override
  Widget buildResults(BuildContext context) => Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.location_city,
            size: 120,
          ),
          const SizedBox(
            height: 48,
          ),
          Text(
            query,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 64,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ));

  @override
  Widget buildSuggestions(BuildContext context) => FutureBuilder<List<Map<String, dynamic>>>(
    future: getAutocomplete(query: query),
    builder: (context, snapshot) {
      switch(snapshot.connectionState) {
        case ConnectionState.waiting:
          return const Center(child: CircularProgressIndicator(),);
        default:
          return buildSuggestionsSuccess(snapshot.data);
      }
    },
  );

  Widget buildSuggestionsSuccess(List<Map<String, dynamic>>? subReddits) => ListView.builder(
        itemCount: subReddits!.length,
        itemBuilder: (context, index) {
          final suggestion = subReddits[index];
          var queryText = "";
          var remainingText = "";
          if (suggestion['name'] != null) {
            queryText = suggestion['name'].substring(0, query.length + 2);
            remainingText = suggestion['name'].substring(query.length + 2);
          } else {
            queryText = "";
            remainingText = "";
          }
          final img = suggestion['img'];
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
              leading: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(img),
                backgroundColor: Colors.grey,
              ),
              title: RichText(
                text: TextSpan(
                  text: queryText,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  children: [
                    TextSpan(
                      text: remainingText,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                query = suggestion['name'];
                close(context, suggestion['name']);
              },
            ),
          );
        },
      );
}
