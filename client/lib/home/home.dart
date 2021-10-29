import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:redditech/API/api.dart';
import 'package:redditech/Subreddit/subreddit.dart';
import 'package:redditech/shared/cards.dart';

class HomeComponent extends StatefulWidget {
  const HomeComponent({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomeComponent> createState() => _HomeComponentState();
}

class _HomeComponentState extends State<HomeComponent> {

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: getHome(widget.title),
      builder: (context, snapshot) {
        switch(snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator(),);
          default:
            return HomeReddit(height: height, width: width, title: widget.title, subreddit: snapshot.data);
        }
    }
  );}
}

class HomeReddit extends StatelessWidget {
  const HomeReddit({
    Key? key,
    required this.height,
    required this.width,
    required this.title,
    required this.subreddit
  }) : super(key: key);
  
  final double height;
  final double width;
  final String title;
  final List<Map<String, dynamic>>? subreddit;

  @override
  Widget build(BuildContext context) {
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
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeComponent(title: 'Best'),
                            )
                          ),
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
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeComponent(title: 'Hot'),
                            )
                          ),
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
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeComponent(title: 'New'),
                            )
                          ),
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
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeComponent(title: 'Top'),
                            )
                          ),
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
    List<Widget> cards = List<Widget>.from(test1)..addAll(List<Widget>.generate(subreddit!.length, (i) =>
      HomeCards(
        author: subreddit![i]['author'],
        date: subreddit![i]['date'],
        subreddit: subreddit![i]['subreddit'],
        title: subreddit![i]['title'],
        media: subreddit![i]['media'],
        type: subreddit![i]['type']
      )
    ));
    final LocalStorage storage = LocalStorage('redditech');
    return Scaffold(
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SubRedditComponent(),
                    )
                  );
                },
            ),
          )
        ],
      ),
      body: Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.fromLTRB(23, 10, 0, 0),
          //   child: SizedBox(
          //     width: width * 0.888,
          //     child: Card(
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(15.0),
          //       ),
          //       child: Row(
          //         children: [
          //           Card(
          //             shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(15.0),
          //             ),
          //             color: Color.fromRGBO(255, 69, 0, 1),
          //             child: Padding(
          //               padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
          //               child: const Text(
          //                 "Best",
          //                 style: TextStyle(
          //                   fontSize: 18,
          //                   fontWeight: FontWeight.w700,
          //                   color: Colors.white
          //                 ),
          //               ),
          //             ),
          //           ),
          //           Card(
          //             shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(15.0),
          //             ),
          //             color: Colors.white,
          //             child: Padding(
          //               padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
          //               child: const Text(
          //                 "Hot",
          //                 style: TextStyle(
          //                   fontSize: 18,
          //                   fontWeight: FontWeight.w700,
          //                   color: Color.fromRGBO(165, 165, 165, 1)
          //                 ),
          //               ),
          //             ),
          //           ),
          //           Card(
          //             shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(15.0),
          //             ),
          //             color: Colors.white,
          //             child: Padding(
          //               padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
          //               child: const Text(
          //                 "new",
          //                 style: TextStyle(
          //                   fontSize: 18,
          //                   fontWeight: FontWeight.w700,
          //                   color: Color.fromRGBO(165, 165, 165, 1)
          //                 ),
          //               ),
          //             ),
          //           ),
          //           Card(
          //             shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(15.0),
          //             ),
          //             color: Colors.white,
          //             child: Padding(
          //               padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
          //               child: const Text(
          //                 "Random",
          //                 style: TextStyle(
          //                   fontSize: 18,
          //                   fontWeight: FontWeight.w700,
          //                   color: Color.fromRGBO(165, 165, 165, 1)
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          Container(
            height: height * 0.87,
            child: ListView(
              children: cards,
            ),
          ),
        ],
      ),
    );
  }
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
            queryText = suggestion['name'].substring(0, query.length + 1);
            remainingText = suggestion['name'].substring(query.length + 1);
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
