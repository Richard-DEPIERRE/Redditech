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

// ignore: camel_case_types
class innerText extends StatelessWidget {
  const innerText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text("hello world yoooooooooo");
  }
} 