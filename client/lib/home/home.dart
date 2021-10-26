import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redditech/API/api.dart';

class HomeComponent extends StatefulWidget {
  const HomeComponent({Key? key}) : super(key: key);

  @override
  State<HomeComponent> createState() => _HomeComponentState();
}

class _HomeComponentState extends State<HomeComponent> {
  List<Widget> cards = List<Widget>.generate(20, (i)=> const HomeCards());

  @override
  Widget build(BuildContext context) {
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
                  Navigator.pushNamed(context, '/subreddit');
                },
            ),
          )
        ],
      ),
      body: ListView(
        children: cards,
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
