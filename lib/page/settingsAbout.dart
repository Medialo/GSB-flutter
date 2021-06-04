import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsAbout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: const Text('A propos'),
        automaticallyImplyMiddle: true,

      ),
        child: Material(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
            child: ListView(
              children: [
                const Text("GSB App (flutter version) est une application de la KoalaCorp."),
                const Text("Projet PPE2 : contexte GSB Android "),
                const SizedBox(
                  height: 20,
                ),
                const Text("Version : 1.0.0"),
                const Text("Flutter version : 2.2.1"),
                const Text("Dart version : 2.13.1"),
              ],
              // padding: EdgeInsets.symmetric(horizontal: 50),
            ),
          ),
        ),

    );
  }
  
}