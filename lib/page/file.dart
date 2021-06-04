import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gsb/model/feeFile.dart';
import 'package:gsb/routes.dart';
import 'package:path_provider/path_provider.dart';

import '../main.dart';
import '../objectbox.g.dart';

class File extends StatefulWidget {
  const File({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => FileState();
}

class FileState extends State<File> {
  late final Store _store = MyHomePage.store;
  late final Box<FeeFile> _boxFeeFile;
  List<FeeFile> _listFeeFiles = [];

  void updatePage() {
    setState(() {
      _listFeeFiles = _boxFeeFile.getAll();
      // var test = _listFeeFiles[0].incls.elementAt(0).cat.target!.name!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        CupertinoSliverNavigationBar(
          largeTitle: Text("Vos fiches"),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, i) {
              return getSlidable(_listFeeFiles.elementAt(i));
            },
            childCount: _listFeeFiles.length,
          ),
        ),
      ],
    );
  }

  Slidable getSlidable(FeeFile feeFile) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          child: Text(feeFile.id.toString()),
          foregroundColor: Colors.white,
        ),
        title: Text('Fiche n°' + feeFile.id.toString()),
        subtitle: Text(feeFile.created.toString()),
        onTap: () {
          Navigator.of(context)
              .pushNamed(Routes.fileDetail(), arguments: feeFile.id);
        },
      ),
      actions: <Widget>[],
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Editer',
          color: Colors.blue,
          icon: Icons.edit,
          onTap: () => Navigator.of(context)
              .pushNamed(Routes.fileDetail(), arguments: feeFile.id),
        ),
        IconSlideAction(
          caption: 'Supprimer',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {
            setState(() {
              _boxFeeFile.remove(feeFile.id);
              _listFeeFiles = _boxFeeFile.getAll();
            });
          },
        ),
      ],
    );
  }

  @override
  void initState() {
    getApplicationDocumentsDirectory().then((Directory dir) {
      // _store = Store(getObjectBoxModel(), directory: dir.path + '/objectbox');
      _boxFeeFile = _store.box<FeeFile>();
      setState(() {
        _listFeeFiles.addAll(_boxFeeFile.query().build().find());
      });
    });
  }

  @override
  void dispose() {
    // _store.close();
    super.dispose();
  }

  void addFeeFile() {
    FeeFile f = new FeeFile(created: DateTime.now(), edited: DateTime.now());
    _store.box<FeeFile>().put(f);
    updatePage();
  }
}