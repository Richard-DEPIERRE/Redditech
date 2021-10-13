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
          Icon(icon)
        ],
      )
    );
  }
}