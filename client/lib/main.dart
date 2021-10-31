import 'package:flutter/material.dart';
import 'package:redditech/Subreddit/subreddit.dart';
import 'package:redditech/profil/profil.dart';
import 'login/login.dart';
import 'home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Redditech',
      initialRoute: '/',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => const LoginComponent(),
        '/home': (context) => const HomeComponent(),
        '/profil': (context) => const ProfilComponent(),
        '/subreddit': (context) => const SubRedditComponent(),
      },
    );
  }
}
