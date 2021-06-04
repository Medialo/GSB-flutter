
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsb/model/dataAddFeePair.dart';
import 'package:gsb/model/feeFile.dart';
import 'package:gsb/routes.dart';
import 'package:objectbox/objectbox.dart';

import '../main.dart';
import '../objectbox.g.dart';

class FileDetail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FileDetailState();
}

class FileDetailState extends State<FileDetail> {
  final Store _store = MyHomePage.store;
  late final Box<FeeFile> _bFeeFile;
  late final int _i;
  late FeeFile _feeFile;
  bool _alreadyInit = false;
  int _slider = 0;

  void _updateFeeFile(){
    setState(() {
      this._feeFile = this._bFeeFile.get(_i)!;
    });

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(_alreadyInit){
      return;
    }
    this._i = ModalRoute.of(context)!.settings.arguments as int;
    this._bFeeFile = this._store.box<FeeFile>();
    this._feeFile = this._bFeeFile.get(this._i)!;
    _alreadyInit = true;
  }

  @override
  Widget build(BuildContext context) {

    final Widget l1 = ListView.builder(
      itemCount: _feeFile.incls.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: _feeFile.incls.elementAt(index).valid! ? getOkIcon() : getNotOkIcon(),
          title: Text(_feeFile.incls.elementAt(index).cat.target!.name!), //cat.target!.name!
          subtitle: ((){
            final double n = _feeFile.incls.elementAt(index).cat.target!.price * _feeFile.incls.elementAt(index).qtt!;
            return Text(_feeFile.incls.elementAt(index).qtt.toString() + " x " + _feeFile.incls.elementAt(index).cat.target!.price.toString() + "€ = " + n.toString() + "€");
          }()),
          onTap: () {
            Navigator.of(context).pushNamed(Routes.formAddInclFee(), arguments: DataAddFeePair(_feeFile.id, subCatId: _feeFile.incls.elementAt(index).id)).then((value) {
              _updateFeeFile();
            });
            // Navigator.of(context).pushNamed(Routes.about());
          },
        );
      },
    );

    final Widget l2 = ListView.builder(
      itemCount: _feeFile.excls.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading:
          _feeFile.excls.elementAt(index).valid! ? getOkIcon() : getNotOkIcon(),
          title: Text(_feeFile.excls.elementAt(index).label!),
          subtitle: Text(_feeFile.excls.elementAt(index).price.toString() + " €"),
          onTap: () {
            Navigator.of(context).pushNamed(Routes.formAddExclFee(), arguments: DataAddFeePair(_feeFile.id, subCatId: _feeFile.excls.elementAt(index).id)).then((value) {
              _updateFeeFile();
            });
            // Navigator.of(context).pushNamed(Routes.about());
          },
        );
      },
    );
    // SliverToBoxAdapter(child: Text("ee"),),





    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Votre fiche n°' + _feeFile.id.toString()),
        trailing: Material(
          child: IconButton(
            icon: Icon(Icons.add),
            color: Colors.blue,
            onPressed: () {
              showCupertinoModalPopup<void>(
                context: context,
                builder: (BuildContext context) => CupertinoActionSheet(
                  title: const Text('Ajouter'),
                  message: const Text(
                      'Ajouter un frai hors forfait ou autorisé pas le laboratoire GSB'),
                  actions: <CupertinoActionSheetAction>[
                    CupertinoActionSheetAction(
                      child: const Text('Ajouter un frai autorisé'),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.of(context)
                            .pushNamed(Routes.formAddInclFee(),
                            arguments: DataAddFeePair(_feeFile.id))
                            .then((value) {
                          _updateFeeFile();
                        });
                      },
                    ),
                    CupertinoActionSheetAction(
                      child: const Text('Ajouter un frai hors forfait'),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.of(context).pushNamed(Routes.formAddExclFee(), arguments: DataAddFeePair(_feeFile.id) ).then((value) {
                          _updateFeeFile();
                        });
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        automaticallyImplyMiddle: true,
      ),
      child: SafeArea(
        child: Material(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  Container(
                    width: 1000,
                    child: CupertinoSlidingSegmentedControl<int>(
                      children: const <int, Widget>{
                        0: const Text("Frai autorisé"),
                        1: const Text("Frai hors forfait"),
                      },
                      groupValue: _slider,
                      onValueChanged: (value) {
                        setState(() {
                          _slider = value!;
                        });
                      },
                    ),
                  ),
                  // Expanded(
                  //     child: CustomScrollView(
                  //       slivers: [
                  //         _tabs[_slider],
                  //       ],
                  //     )
                  // ),
                  Expanded(
                      child: _slider == 0 ? l1 : l2
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }



  Widget getOkIcon() {
    return Container(
      child: const Icon(Icons.check),
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
          color: Colors.green,
          borderRadius: const BorderRadius.all(
            Radius.circular(10.0),
          )),
    );
  }

  Widget getNotOkIcon() {
    return Container(
      child: const Icon(Icons.close),
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
          color: Colors.red,
          borderRadius: const BorderRadius.all(
            Radius.circular(10.0),
          )),
    );
  }
}























// final List<Widget> _tabs = [
//   SliverList(
//     delegate: SliverChildBuilderDelegate((c,i) {
//       final InclFee _inclFee = _feeFile.incls.elementAt(i);
//       final InclFeeCatSubParent? _inclFeeCatSubParent = _bFeeFile.get(this._i)!.incls.elementAt(i).cat.target;
//       return ListTile(
//         leading: _inclFee.valid! ? getOkIcon() : getNotOkIcon(),
//         title: Text(_inclFeeCatSubParent!.name!), //cat.target!.name!
//         subtitle: ((){
//           final double n = _inclFeeCatSubParent.price * _inclFee.qtt!;
//           return Text(_inclFee.qtt.toString() + " x " + _inclFeeCatSubParent.price.toString() + "€ = " + n.toString() + "€");
//         }()),
//         onTap: () {
//           Navigator.of(context).pushNamed(Routes.formAddInclFee(), arguments: DataAddFeePair(_feeFile.id, subCatId: _inclFee.id)).then((value) {
//             _updateFeeFile();
//           });
//         },
//       );
//     },
//         childCount: _feeFile.incls.length
//     ),
//   ),
//   SliverList(
//     delegate: SliverChildBuilderDelegate((c,i) {
//       final ExclFee _exclFee = _feeFile.excls.elementAt(i);
//       return ListTile(
//         leading:
//         _exclFee.valid! ? getOkIcon() : getNotOkIcon(),
//         title: Text(_exclFee.label!),
//         subtitle: Text(_exclFee.price.toString() + " €"),
//         onTap: () {
//           Navigator.of(context).pushNamed(Routes.formAddExclFee(), arguments: DataAddFeePair(_feeFile.id, subCatId: _exclFee.id)).then((value) {
//             _updateFeeFile();
//           });
//         },
//       );
//     },
//         childCount: _feeFile.excls.length
//     ),
//   ),
// ];