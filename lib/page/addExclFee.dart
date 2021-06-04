
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsb/model/dataAddFeePair.dart';
import 'package:gsb/model/exclFee.dart';
import 'package:gsb/model/feeFile.dart';
import 'package:intl/intl.dart';

import '../main.dart';
import '../objectbox.g.dart';

class AddExclFee extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AddExclFeeState();
}

class AddExclFeeState extends State<AddExclFee> {
  final TextEditingController _c = new TextEditingController();
  final TextEditingController _cPrice = new TextEditingController();
  final TextEditingController _cDate = new TextEditingController();
  final _form = GlobalKey<FormState>();
  late final Store _store = MyHomePage.store;
  late final Box<ExclFee> _bExcl;
  late final FeeFile? _feeFile;
  late final int _catId;
  DateTime _dateTime = DateTime.now();

  bool _valide = false;
  bool _alreadyInit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(_alreadyInit){
      return;
    }

    this._bExcl = _store.box<ExclFee>();
    _feeFile = _store.box<FeeFile>().get((ModalRoute.of(context)!.settings.arguments as DataAddFeePair).feeFile);
    _catId = (ModalRoute.of(context)!.settings.arguments as DataAddFeePair).subCatId;
    if(_catId > 0){
      final ExclFee? _exclFee = _bExcl.get(_catId);
      if(_exclFee != null){
        _c.text = _exclFee.label!;
        _dateTime = _exclFee.date!;
        _cPrice.text = _exclFee.price.toString();
        _cDate.text = DateFormat('dd MMMM yyyy' , Localizations.localeOf(context).languageCode).format(_dateTime).toString();
        _valide = _exclFee.valid!;
      }
    }

    _alreadyInit = true;
  }


  @override
  Widget build(BuildContext context) {

    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
            middle: _catId == 0 ? const Text('Ajouter frai') : const Text('Modification frai'),
            automaticallyImplyMiddle: true,

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
                            _bExcl.remove(_catId);
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
            ) : Material()

        ),
        child: Material(
          child: SafeArea(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                child: Form(
                  key: _form,
                  child: ListView(
                    children: [
                      _catId == 0 ? const Text("Ajouter votre frai hors forfait.") : const Text('Modification votre frai hors forfait.'),
                      TextFormField(
                        controller: _c,
                        maxLines: 1,
                        decoration: InputDecoration(
                          hintText: "Ordinateur, Parking, ...",
                          labelText: "Nom du frai",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Entrez une valeur valide';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _cPrice,
                        maxLines: 1,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: "100.5 €",
                            labelText: "Prix"
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Entrez une valeur valide';
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
                                          mode: CupertinoDatePickerMode.date,
                                          onDateTimeChanged: (val) {
                                            _dateTime = val;
                                          }),
                                    ),

                                    // Close the modal
                                    CupertinoButton(
                                      child: Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        _cDate.text = DateFormat('dd MMMM yyyy' , Localizations.localeOf(context).languageCode).format(_dateTime).toString();
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
                            decoration: new InputDecoration(hintText: 'Date', labelText: "Date"),
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
                      SwitchListTile(value: _valide,
                        onChanged: (value) {
                          setState(() {
                            _valide = value;
                          });
                        },
                        title: const Text("Validé"),
                        subtitle: const Text("Ce frai a-t-il été validé ?"),
                      ),
                      CupertinoButton.filled(child: _catId == 0 ? const Text("Ajouter") : const Text("Modifier"), onPressed: () {
                        if(_form.currentState!.validate()){
                          final ExclFee _excl = ExclFee(
                              price: double.tryParse(_cPrice.text),
                              label: _c.text,
                              date: _dateTime,
                              valid: _valide,
                              id: _catId
                          );
                          if(_catId > 0){
                            _bExcl.put(_excl);
                          } else {
                            final _bFee = _store.box<FeeFile>();
                            // _bExcl.put(_excl);
                            _feeFile!.excls.add(_excl);
                            _bFee.put(_feeFile!);
                          }
                          Navigator.of(context).pop();
                        }
                      },),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
    );
  }
}