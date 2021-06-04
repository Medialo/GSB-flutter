import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsb/routes.dart';

class SettingsData {

  static List<Widget> getSettingsMenuData(BuildContext context) => [
    ListTile(
      title: Text("Catégories"),
      subtitle: Text("Modifier les catégories, et leurs produits."),
      leading: Column(
        children: [
          Icon(Icons.category),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
      trailing: Icon(Icons.chevron_right),
      onTap: () {
        Navigator.of(context).pushNamed(Routes.settingsCat());
      },
    ),
    ListTile(
      title: Text("A propos"),
      subtitle: Text("En savoir plus à propos de votre application GSB."),
      leading: Icon(Icons.info),
      trailing: Icon(Icons.chevron_right),
      onTap: () {
        Navigator.of(context).pushNamed(Routes.about());
      },
    )
  ];


}