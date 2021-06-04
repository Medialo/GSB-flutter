
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsb/model/dataAddFeePair.dart';
import 'package:gsb/model/feeFile.dart';
import 'package:gsb/model/inclFee.dart';
import 'package:gsb/model/inclFeeCatParent.dart';
import 'package:gsb/model/inclFeeCatSubParent.dart';
import 'package:intl/intl.dart';

import '../main.dart';
import '../objectbox.g.dart';

class AddInclFee extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AddInclFeeState();


}

class AddInclFeeState extends State<AddInclFee> {
  final TextEditingController _cQtt = new TextEditingController();
  final TextEditingController _cDate = new TextEditingController();
  final TextEditingController _cCat = new TextEditingController();
  final _form = GlobalKey<FormState>();
  late final Store _store = MyHomePage.store;
  late final Box<InclFee> _bIncl;
  late final Box<FeeFile> _bFee;
  late final Box<InclFeeCatSubParent> _bSubCat;
  late final FeeFile? _feeFile;
  late final int _catId;
  late List<InclFeeCatSubParent> _listSubCat;

  DateTime _dateTime = DateTime.now();
  int _selectedCat = 0;
  bool _valide = false;
  bool _alreadyInit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(_alreadyInit){
      return;
    }
    _bIncl = _store.box<InclFee>();
    _bFee = _store.box<FeeFile>();
    _bSubCat = _store.box<InclFeeCatSubParent>();
    _feeFile = _store.box<FeeFile>().get((ModalRoute.of(context)!.settings.arguments as DataAddFeePair).feeFile);
    _listSubCat = _bSubCat.getAll();
    _catId = (ModalRoute.of(context)!.settings.arguments as DataAddFeePair).subCatId;
    if (_catId > 0) {
      final InclFee? _inclFee = _bIncl.get(_catId);
      if (_inclFee != null) {
        _cQtt.text = _inclFee.qtt!.toString();
        _dateTime = _inclFee.date!;
        _selectedCat = _listSubCat.indexWhere((element) {
          return element.name == _inclFee.cat.target!.name && element.cat.target!.name == _inclFee.cat.target!.cat.target!.name;
        });
        _cCat.text = _inclFee.cat.target!.name!;
        _cDate.text = DateFormat('dd MMMM yyyy', Localizations.localeOf(context).languageCode).format(_dateTime).toString();
        _valide = _inclFee.valid!;
      }
    }
    _alreadyInit = true;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: _catId == 0
              ? const Text('Ajouter frai')
              : const Text('Modification frai'),
          trailing: _catId != 0 ? Material(
            child: IconButton(
              icon: Icon(Icons.delete),
              color: Colors.blue,
              onPressed: () {
                showCupertinoModalPopup<void>(
                  context: context,
                  builder: (BuildContext context) => CupertinoActionSheet(
                    title: const Text('Supprimer'),
                    message: const Text(
                        'Etes vous sûr de vouloir supprimer ce frai ?'),
                    actions: <CupertinoActionSheetAction>[
                      CupertinoActionSheetAction(
                        child: const Text('Supprimer', style: TextStyle(color: Colors.red),),
                        onPressed: () {
                          print("");
                          _bIncl.remove(_catId);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                      ),
                      CupertinoActionSheetAction(
                        child: const Text('Annuler'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ): Material(),
          automaticallyImplyMiddle: true,
        ),
        child: Material(
          child: SafeArea(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Form(
                  key: _form,
                  child: ListView(
                    children: [
                      InkWell(
                        onTap: () {
                          showCupertinoModalPopup(
                              context: context,
                              builder: (_) => Container(
                                height: 500,
                                color: Color.fromARGB(255, 255, 255, 255),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 400,
                                      child: CupertinoPicker.builder(
                                        itemExtent: 50,
                                        childCount: _listSubCat.length,
                                        onSelectedItemChanged: (int value) {
                                          _selectedCat = value;
                                        },
                                        itemBuilder: (BuildContext context,
                                            int index) {
                                          InclFeeCatParent? _o = _listSubCat
                                              .elementAt(index)
                                              .cat
                                              .target;

                                          if (_o != null) {
                                            return Column(children: [
                                              Text(_listSubCat.elementAt(index).name! + " (" + _listSubCat.elementAt(index).cat.target!.name! + ")"),
                                              Text(_listSubCat.elementAt(index).price.toString()+" € / unité"),
                                            ],);
                                          } else {
                                            return Column(
                                              children: [
                                                Text(_listSubCat.elementAt(index).name!),
                                                Text(_listSubCat.elementAt(index).price.toString()+" € / unité"),
                                              ],
                                            );
                                          }
                                        },
                                      ),
                                    ),

                                    // Close the modal
                                    CupertinoButton(
                                      child: Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        _cCat.text = _listSubCat
                                            .elementAt(_selectedCat)
                                            .name!;
                                      },
                                    )
                                  ],
                                ),
                              ));
                          // showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2100),da);
                        },
                        child: IgnorePointer(
                          child: new TextFormField(
                            controller: _cCat,
                            decoration: new InputDecoration(
                                hintText: 'Catégorie', labelText: "Catégorie"),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  _selectedCat.isNegative) {
                                return 'Chosir une catégorie';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: _cQtt,
                        keyboardType: TextInputType.number,
                        maxLines: 1,
                        decoration: InputDecoration(
                          hintText: "quantité supèrieur à 0",
                          labelText: "Quantité",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Entrez une valeur valide';
                          }
                          value = value.replaceAll(",", ".");
                          double? d = double.tryParse(value);
                          if (d == null || d <= 0) {
                            return 'Entrez une valeur supérieur à 0';
                          }
                          return null;
                        },
                      ),
                      InkWell(
                        onTap: () {
                          showCupertinoModalPopup(
                              context: context,
                              builder: (_) => Container(
                                height: 500,
                                color: Color.fromARGB(255, 255, 255, 255),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 400,
                                      child: CupertinoDatePicker(
                                          initialDateTime: DateTime.now(),
                                          use24hFormat: true,
                                          mode:
                                          CupertinoDatePickerMode.date,
                                          onDateTimeChanged: (val) {
                                            _dateTime = val;
                                          }),
                                    ),

                                    // Close the modal
                                    CupertinoButton(
                                      child: Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        _cDate.text = DateFormat(
                                            'dd MMMM yyyy',
                                            Localizations.localeOf(
                                                context)
                                                .languageCode)
                                            .format(_dateTime)
                                            .toString();
                                      },
                                    )
                                  ],
                                ),
                              ));
                          // showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2100),da);
                        },
                        child: IgnorePointer(
                          child: new TextFormField(
                            controller: _cDate,
                            decoration: new InputDecoration(
                                hintText: 'Date', labelText: "Date"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Entrez une date valide';
                              }
                              return null;
                            },
                            // validator: validateDob,
                          ),
                        ),
                      ),
                      SwitchListTile(
                        value: _valide,
                        onChanged: (value) {
                          setState(() {
                            _valide = value;
                          });
                        },
                        title: Text("Validé"),
                        subtitle: Text("Ce frai a-t-il été validé ?"),
                      ),
                      CupertinoButton.filled(
                        child: _catId == 0
                            ? const Text("Ajouter")
                            : const Text("Modifier"),
                        onPressed: () {
                          if (_form.currentState!.validate()) {
                            final InclFee _incl = InclFee(
                                qtt: double.parse(
                                    _cQtt.text.replaceAll(",", ".")),
                                date: _dateTime,
                                valid: _valide,
                                id: _catId)
                              ..cat.target =
                              _listSubCat.elementAt(_selectedCat);
                            // _bExcl.put(_excl);//
                            if (_catId > 0) {
                              _bIncl.put(_incl);
                            } else {
                              // _bIncl.put(_incl);
                              _feeFile!.incls.add(_incl);
                              _bFee.put(_feeFile!);
                            }
                            Navigator.of(context).pop();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
