import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomeComponent extends StatefulWidget {
  const HomeComponent({Key? key}) : super(key: key);

  void checkUser() async {
    const storage = FlutterSecureStorage();
    final code = await storage.read(key: 'code');
    print(code);
  }
  @override
  State<HomeComponent> createState() => _HomeComponentState();
}

class _HomeComponentState extends State<HomeComponent> {
  List cards = List.generate(20, (i)=> const HomeCards());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        leading: const Padding(
          padding: EdgeInsets.fromLTRB(20, 10, 0.0, 10.0),
          child: CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage('https://f.hellowork.com/blogdumoderateur/2015/08/Reddit-alien.png'),
            backgroundColor: Colors.grey,
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
              onPressed: () {

              },
            ),
          )
        ],
      ),
      // body: ListView(
      //   children: cards,
      // ),
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