import 'package:flutter/material.dart';
import 'package:redditech/shared/background.dart';

/// @description: Profil component, display many informations
/// about the user
class ProfilComponent extends StatefulWidget {
  const ProfilComponent({Key? key}): super(key:key);

  @override
  State<ProfilComponent> createState() => _ProfilComponent();
}

class _ProfilComponent extends State<ProfilComponent> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BackgroundComponent(component: innerText(),),
    );
  }
}

/// Container with number of follower
/// account status (private public)
// ignore: camel_case_types
class innerText extends StatelessWidget {
  const innerText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 110
            ),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: Image.network("https://i.redd.it/snoovatar/avatars/2e974689-b5f3-44e1-8c20-3377b3cee7eb.png", height: 150.0, width: 150.0,),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              "Pseudo",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 20.0
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(30.0),
            child: Text(
              "I'm a pro gamer and I am very happy to meet you guys",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromRGBO(149, 165, 166, 1),
                fontStyle: FontStyle.italic,
                fontSize: 18
              ),
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: 110,
              width: width - 20,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        "10\nFollowers",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(40.0, 0.0, 0.0, 0.0),
                      child: Text(
                        "10\nFollowing",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(60.0, 0.0, 0.0, 0.0),
                      child: Text(
                        "10\nSubberedits",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                      ),
                    ),
                  ],
                ),
                color: Colors.black,
              ),
            ),
          ),
      ],
    );
  }
}