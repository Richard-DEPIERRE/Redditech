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
        title: const Text("Home"),
      )
    );
  }
}