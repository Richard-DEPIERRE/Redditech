import 'package:flutter/material.dart';

class BackgroundComponent extends StatelessWidget {
  final Widget component;
  const BackgroundComponent({
    Key? key,
    required this.component
  }): super(key:key);


  @override
  SingleChildScrollView build(BuildContext context) {
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
                      top: height * 0.25,
                      right: 0.0,
                      left: 0.0),
                  child: SizedBox(
                    height: height,
                    width: width,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      color: Colors.white,
                      elevation: 4.0,
                      // child: component,
                    ),
                  ),
                ),
                Container(
                  child: component,
                )
              ]
            ),
          ),
        ],
      ),
    );
  }
}