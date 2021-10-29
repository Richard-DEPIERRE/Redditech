import 'package:flutter/material.dart';
import 'package:redditech/API/api.dart';
import 'package:redditech/shared/background.dart';

class ProfilComponent extends StatefulWidget {
  const ProfilComponent({Key? key}): super(key:key);

  @override
  State<ProfilComponent> createState() => _ProfilComponent();
}

class _ProfilComponent extends State<ProfilComponent> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: getUser(),
      builder: (context, snapshot) {
        switch(snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator(),);
          default:
            return Scaffold(
              body: BackgroundComponent(component: InnerText(me: snapshot.data),),
            );
        }
    }
  );}
}

class InnerText extends StatefulWidget {
  InnerText({
    Key? key,
    required this.me
  }) : super(key: key);
  final Map<String, dynamic>? me;

  @override
  State<InnerText> createState() => _InnerTextState();
}

class _InnerTextState extends State<InnerText> {
    var avatar = "";
    var name = "";
    var description = "";
    var subscribers = 0;
    var friends = 0;
    var coins = 0;
    bool isSwitched = false;
    bool nightmode = false;
    bool email_private_message = false;
    bool over_18 = false;
    bool search_include_over_18 = false;
    bool enable_followers = false;
    bool email_user_new_follower = false;
  @override
  Widget build(BuildContext context) {
    avatar = widget.me!["avatar"];
    name = widget.me!["name"];
    description = widget.me!["description"];
    subscribers = widget.me!["subscribers"];
    friends = widget.me!["friends"];
    coins = widget.me!["coins"];
    final width = MediaQuery.of(context).size.width;
    nightmode = widget.me!["nightmode"];
    email_private_message = widget.me!["email_private_message"];
    over_18 = widget.me!["over_18"];
    search_include_over_18 = widget.me!["search_include_over_18"];
    enable_followers = widget.me!["enable_followers"];
    email_user_new_follower = widget.me!["email_user_new_follower"];
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 110
          ),
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Image.network(avatar, height: 150.0, width: 150.0,),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 20.0
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
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
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40.0, 20, 20, 20),
                    child: Text(
                      subscribers.toString() + "\nSubscribers",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40.0, 0.0, 0.0, 0.0),
                    child: Text(
                      friends.toString() + "\nFriends",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(60.0, 0.0, 0.0, 0.0),
                    child: Text(
                      coins.toString() + "\nCoins",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Nightmode :"
            ),
            Switch(
              value: widget.me!["nightmode"],
              onChanged: (value) {
                setState(() {
                  widget.me!["nightmode"] = value;
                  changeSettings(value, "nightmode");
                });
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Email private messages :"
            ),
            Switch(
              value: widget.me!["email_private_message"],
              onChanged: (value) {
                setState(() {
                  widget.me!["email_private_message"] = value;
                  changeSettings(value, "email_private_message");
                });
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Over 18 :"
            ),
            Switch(
              value: widget.me!["over_18"],
              onChanged: (value) {
                setState(() {
                  widget.me!["over_18"] = value;
                  changeSettings(value, "over_18");
                });
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Search include over 18 :"
            ),
            Switch(
              value: widget.me!["search_include_over_18"],
              onChanged: (value) {
                setState(() {
                  widget.me!["search_include_over_18"] = value;
                  changeSettings(value, "search_include_over_18");
                });
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Enable followers :"
            ),
            Switch(
              value: widget.me!["enable_followers"],
              onChanged: (value) {
                setState(() {
                  widget.me!["enable_followers"] = value;
                  changeSettings(value, "enable_followers");
                });
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Email user new follower :"
            ),
            Switch(
              value: widget.me!["email_user_new_follower"],
              onChanged: (value) {
                setState(() {
                  widget.me!["email_user_new_follower"] = value;
                  changeSettings(value, "email_user_new_follower");
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}