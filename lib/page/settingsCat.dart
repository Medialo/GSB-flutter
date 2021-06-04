import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:gsb/main.dart';
import 'package:gsb/model/feeFile.dart';
import 'package:gsb/model/inclFeeCatParent.dart';
import 'package:gsb/model/inclFeeCatSubParent.dart';
import 'package:path_provider/path_provider.dart';

import '../objectbox.g.dart';
import '../main.dart';

class SettingsCat extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SettingsCatState();
}

class SettingsCatState extends State<SettingsCat> {
  final TextEditingController _cPrice = new TextEditingController();
  final TextEditingController _c = new TextEditingController();
  final _formKeySubCat = GlobalKey<FormState>();
  final _formKeyCat = GlobalKey<FormState>();
  late final StreamSubscription<Query<InclFeeCatSubParent>> sub2;
  late final StreamSubscription<Query<InclFeeCatParent>> sub1;
  late final Box<InclFeeCatSubParent> _boxSub;
  late final Box<InclFeeCatParent> box;
  late final Store _store = MyHomePage.store;
  List<InclFeeCatParent> _inclFeeCatParent = [];
  InclFeeCatParent? _dropDownParentCatForm;
  bool _alreadyInit = false;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(_alreadyInit){
      return;
    }

      box = _store.box<InclFeeCatParent>();
      _boxSub = _store.box<InclFeeCatSubParent>();
      _inclFeeCatParent = box.getAll();
      sub1 = box.query().watch().listen((Query<InclFeeCatParent> query) {
        setState(() {
          _inclFeeCatParent = box.getAll();
        });
      });
      sub2 = _boxSub.query().watch().listen((Query<InclFeeCatSubParent> query) {
        setState(() {
          _inclFeeCatParent = box.getAll();
        });
      });

    _alreadyInit = true;


  }

  @override
  void dispose() {
    sub1.cancel();
    sub2.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: Text("Catégories"),
            // trailing: Material(
            //   child: IconButton(
            //     color: Colors.blue,
            //     icon: Icon(Icons.help_outline),
            //     onPressed: () {
            //       showDialog(
            //           context: context,
            //           builder: (BuildContext context) {
            //             return AlertDialog(
            //               title: const Text('Select assignment'),
            //               content: const Text("Pour supprimer une ligne glissée la sur la droite ou la gauche. Pour la modifier restez appuyé sur la ligne."),
            //               actions: [
            //                 ElevatedButton(
            //                     onPressed: () => Navigator.pop(context, null),
            //                     child: const Text("ok"))
            //               ],
            //             );
            //           });
            //     },
            //   ),
            // ),
          ),
          if (_inclFeeCatParent.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: const Text("Aucune catégorie"),
              ),
            ),
          if (_inclFeeCatParent.isNotEmpty)
            for (InclFeeCatParent p in _inclFeeCatParent)
              SliverStickyHeader(
                header: Dismissible(
                  key: Key(p.id.toString()),
                  // onDismissed: (direction) {
                  //   box.remove(p.id);
                  // },
                  child: Container(
                    height: 60.0,
                    color: Colors.lightBlue,
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      p.name!,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, i) => Dismissible(
                        key: Key(i.toString()),
                        // onDismissed: (direction) {
                        //   final InclFeeCatSubParent s = p.subs.elementAt(i);
                        //   _boxSub.remove(s.id);
                        // },
                        child: ListTile(
                          title: Text(p.subs.elementAt(i).name.toString()),
                          subtitle: Text(p.subs.elementAt(i).priceToString()),
                        )),
                    childCount: p.subs.length,
                  ),
                ),
              ),
        ],
      ),
      floatingActionButton: SpeedDial(
        // icon: Icons.add,
        // activeIcon: Icons.remove,
        tooltip: 'Ajouter ...',
        // heroTag: 'speed-dial-hero-tag',
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.25,
        animationSpeed: 50,
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),

        children: [
          SpeedDialChild(
            child: Icon(Icons.category_outlined),
            backgroundColor: Theme.of(context).colorScheme.primary,
            labelBackgroundColor: Colors.white,
            label: 'Catégorie',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        title: const Text('Nouvelle catégorie'),
                        content: Form(
                          key: _formKeyCat,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                //todo
                                controller: _c,
                                maxLines: 1,
                                decoration: InputDecoration(
                                  hintText: "ex: Restauration",
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Entrez une valeur valide';
                                  }
                                  if (_inclFeeCatParent
                                      .map((e) => e.name)
                                      .toList()
                                      .contains(value)) {
                                    return "Cette catégorie existe déjà";
                                  }
                                  return null;
                                },
                              )
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              if (_formKeyCat.currentState!.validate()) {
                                InclFeeCatParent p =
                                    InclFeeCatParent(name: _c.value.text);
                                final Box<InclFeeCatParent> _box =
                                    _store.box<InclFeeCatParent>();
                                _box.put(p);
                                Navigator.pop(context, 'OK');
                              }
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      )).then((exit) {
                _c.text = "";
              });
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.inventory),
            backgroundColor: Theme.of(context).colorScheme.primary,
            labelBackgroundColor: Colors.white,
            label: 'Produit',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        title: const Text('Nouveau produit'),
                        content: Form(
                          key: _formKeySubCat,
                          child: StatefulBuilder(
                            builder: (context, setState) => Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  //todo
                                  controller: _c,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Entrez une valeur valide';
                                    }
                                    //todo avec produit
                                    if (_inclFeeCatParent
                                        .map((e) => e.name)
                                        .toList()
                                        .contains(value)) {
                                      return "Cette catégorie existe déjà";
                                    }
                                    return null;
                                  },
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    hintText: "ex: Restauration",
                                  ),
                                ),
                                TextFormField(
                                  controller: _cPrice,
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    try {
                                      if (value == null || value.isEmpty) {
                                        return "Entrez un nombre valide";
                                      }
                                      num v =
                                          num.parse(value.replaceAll(",", "."));
                                    } catch (e) {
                                      return "Entrez un nombre valide";
                                    }
                                    return null;
                                  },
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    hintText: "ex: 0.5 €",
                                  ),
                                ),
                                DropdownButtonFormField<InclFeeCatParent>(
                                  validator: (value) {
                                    if (value == null) {
                                      return "Choisissez une valeur valide";
                                    }
                                  },
                                  elevation: 5,
                                  value: _dropDownParentCatForm,
                                  onChanged: (value) {
                                    setState(() {
                                      _dropDownParentCatForm = value!;
                                    });
                                  },
                                  isExpanded: true,
                                  style: TextStyle(color: Colors.black),
                                  hint: Text(
                                    "Choisir une catégorie",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  items: (() {
                                    // final List<String> l = [];
                                    // l.addAll(_inclFeeCatParent.map((e) {
                                    //   return e.name!;
                                    // }).toList());
                                    // return l.map<DropdownMenuItem<String>>((String value) {
                                    //   return DropdownMenuItem<String>(
                                    //     value: value,
                                    //     child: Text(value),
                                    //   );
                                    // }).toList();
                                    return _inclFeeCatParent.map<
                                            DropdownMenuItem<InclFeeCatParent>>(
                                        (e) {
                                      return DropdownMenuItem<InclFeeCatParent>(
                                        child: Text(e.name.toString()),
                                        value: e,
                                      );
                                    }).toList();
                                    // return _inclFeeCatParent.map<DropdownMenuItem<String>>((InclFeeCatParent value) {
                                    //   return DropdownMenuItem<InclFeeCatParent>(
                                    //     value: value,
                                    //     child: Text(value.name),
                                    //   );
                                    // }).toList();
                                  }()),
                                )
                              ],
                            ),
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              if (_formKeySubCat.currentState!.validate() &&
                                  _dropDownParentCatForm != null) {
                                final double? n = double.tryParse(
                                    _cPrice.text.replaceAll(",", "."));
                                final InclFeeCatSubParent p =
                                    new InclFeeCatSubParent(
                                  name: _c.value.text,
                                  price: n == null ? 0 : n,
                                )..cat.target = _dropDownParentCatForm;
                                _dropDownParentCatForm!.subs.add(p);
                                _boxSub.put(p);
                                box.put(_dropDownParentCatForm!);
                                Navigator.pop(context, 'OK');
                              }
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      )).then((exit) {
                _c.text = "";
                _cPrice.text = "";
              });
            },
          ),
        ],
      ),
    );
  }
}