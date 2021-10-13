import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:draw/draw.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:localstorage/localstorage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginComponent extends StatefulWidget {
  const LoginComponent({Key? key}) : super(key: key);

  @override
  State<LoginComponent> createState() => _LoginComponentState();
}

class _LoginComponentState extends State<LoginComponent> {
  FlutterAppAuth appAuth = FlutterAppAuth();
  var red = Reddit.createInstalledFlowInstance(
    clientId: "D6oEdfHilywOWA0-QdA-6g",
    userAgent: "EpitechRed",
    redirectUri: Uri.parse("foobar://sucess"),
  );

  void loginAction() async {
    final authUrl = red.auth.url(["*"], "EpitechRed", compactLogin: true);
    final result = await FlutterWebAuth.authenticate(url: authUrl.toString(), callbackUrlScheme: "foobar");
    String? code = Uri.parse(result).queryParameters['code'];
    const storage = FlutterSecureStorage();
    await storage.write(key: 'code', value: code.toString());
    await red.auth.authorize(code.toString());
    Navigator.pushNamed(context, '/home');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: hello(),
      floatingActionButton: SizedBox(
        height: 100.0,
        width: 100.0,
        child: FloatingActionButton(
            onPressed: () => loginAction(),
            backgroundColor: const Color.fromRGBO(255, 69, 0, 1),
            child: Ink(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end:
                    Alignment(0.8, 0.6),
                  colors: <Color>[
                    Color(0xffee0000),
                    Color(0xffeea000)
                  ],
                  tileMode: TileMode.repeated,
                ),
                borderRadius: BorderRadius.all(Radius.circular(80.0)),
              ),
              child: Container(
                constraints: const BoxConstraints(minWidth: 88.0, minHeight: 36.0),
                alignment: Alignment.center,
                child: const Text(
                  'Log In',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  )
                ),
              ),
            ),
          ),
      ),
    );
  }

  SingleChildScrollView hello() {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          SingleChildScrollView(
            child: Stack(
              children: [
                const Image(
                  image: NetworkImage("https://i.imgur.com/mzL45Qy.png")
                ),
                Container(
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.only(
                      top: height * 0.40,
                      right: 0.0,
                      left: 0.0),
                  child: SizedBox(
                    height: height * 0.65,
                    width: width,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      color: Colors.white,
                      elevation: 4.0,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: RichText(
                              text: const TextSpan(
                                text: "The best ",
                                style: TextStyle(
                                  fontSize: 42,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: [
                                  TextSpan(
                                    text: "Reddit",
                                    style: TextStyle(
                                      fontSize: 42,
                                      color: Color.fromRGBO(255, 69, 0, 1),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: " experience",
                                    style: TextStyle(
                                      fontSize: 42,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ]
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: "Username & email",
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
                            child: TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: "Password",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ]
            ),
          ),
        ],
      ),
    );
  }
}
