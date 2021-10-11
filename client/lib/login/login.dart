import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';

class LoginComponent extends StatefulWidget {
  const LoginComponent({Key? key}) : super(key: key);

  @override
  State<LoginComponent> createState() => _LoginComponentState();
}

class _LoginComponentState extends State<LoginComponent> {
  FlutterAppAuth appAuth = FlutterAppAuth();

  void loginAction() async {
    final AuthorizationTokenResponse? result = await appAuth.authorizeAndExchangeCode(
                    AuthorizationTokenRequest(
                      'tA9PXNna9bcHyoHW5e-NXA',
                      'com.example.redditech://login-callback',
                      discoveryUrl: 'com.example.redditech://login-callback',
                      scopes: ['identity','edit', 'flair', 'history', 'modconfig'],
                    ),
                  );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: hello(),
    );
  }

  Column hello() {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Stack(
          children: [
            const Image(
              image: NetworkImage("https://miro.medium.com/max/1400/1*i7JE9qVJ0sY0hoU6LeSevw.png")
            ),
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(
                  top: height * 0.26,
                  right: 0.0,
                  left: 0.0),
              child: SizedBox(
                height: height * 0.74,
                width: width,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  color: Colors.white,
                  elevation: 4.0,
                  child: ElevatedButton(
                    onPressed: () => loginAction(), 
                    child: const Text("login"),
                  ),
                ),
              ),
            )
          ]
        ),
      ],
    );
  }
}
