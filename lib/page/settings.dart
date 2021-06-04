import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsb/data/settingsData.dart';

class Settings extends StatelessWidget{

  const Settings();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        CupertinoSliverNavigationBar(
          largeTitle: Text("Paramètres"),

        ),
        SliverList(
            delegate: SliverChildBuilderDelegate(
                (BuildContext context, int i) {
                  return SettingsData.getSettingsMenuData(context).elementAt(i);
                },
                childCount: SettingsData.getSettingsMenuData(context).length,

            ),
        ),
      ],
    );
  }


}