import 'dart:io';

import 'package:path_provider/path_provider.dart';

import 'objectbox.g.dart';


class SingleStore {

  SingleStore._privateConstructor(){
    getApplicationDocumentsDirectory().then((Directory dir) {
      store = Store(getObjectBoxModel(), directory: dir.path + '/objectbox');
    });
  }

  static final SingleStore _instance = SingleStore._privateConstructor();
  late final Store store;

  factory SingleStore() { //eq public static SingleStore getInstance() { return this.instance; }
    return _instance;
  }

}