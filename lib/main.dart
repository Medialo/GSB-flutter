import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gsb/page/addExclFee.dart';
import 'package:gsb/page/addInclFee.dart';
import 'package:gsb/page/file.dart';
import 'package:gsb/page/fileDetail.dart';
import 'package:gsb/page/settings.dart';
import 'package:gsb/page/settingsAbout.dart';
import 'package:gsb/page/settingsCat.dart';
import 'package:gsb/routes.dart';
import 'package:objectbox/objectbox.dart';
import 'package:path_provider/path_provider.dart';

import 'objectbox.g.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('fr', 'FR'),
        // ... other locales the app supports
      ],
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      routes: {
        Routes.about(): (c) => SettingsAbout(),
        Routes.settingsCat(): (c) => SettingsCat(),
        Routes.fileDetail(): (c) => FileDetail(),
        Routes.formAddExclFee(): (c) => AddExclFee(),
        Routes.formAddInclFee(): (c) => AddInclFee(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  static late final Store store;
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static final GlobalKey<FileState> _key = GlobalKey();
  bool _isReadyToShow = false;
  int _counter = 0;
  // static late final Store _store;

  final List<Widget> _pages = <Widget>[
    File(key: _key,),
    Settings(),
  ];

  void _incrementCounter(int i) {
    setState(() {
      _counter = i;
    });
  }

  @override
  void initState() {
    super.initState();
    getApplicationDocumentsDirectory().then((Directory dir) {
      MyHomePage.store = Store(getObjectBoxModel(), directory: dir.path + '/objectbox');
      setState(() {
        _isReadyToShow = true;
      });
    });
  }

  @override
  void dispose() {
    MyHomePage.store.close();  // don't forget to close the store
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    if(!_isReadyToShow){
      return const Text("");
    }
    return Scaffold(

      body: SafeArea(
        child: _pages[_counter],
      ),
      floatingActionButton: Visibility(
        visible: _counter == 0 ? true : false,
        child: FloatingActionButton(
          tooltip: 'Nouvelle fiche de frais',
          onPressed: () {
              _key.currentState!.addFeeFile();
          },
          child: Icon(Icons.add),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _counter,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.description), label: "Fiche"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Paramètres"),
        ],
        onTap: (value) => _incrementCounter(value),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
