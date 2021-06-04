import 'package:objectbox/objectbox.dart';

import 'inclFeeCatParent.dart';

@Entity()
class InclFeeCatSubParent {
  int id = 0;
  final cat = ToOne<InclFeeCatParent>();
  String? name;
  double price;

  InclFeeCatSubParent({this.name,this.price = -1});

  String priceToString(){
    return  this.price.toString() + " €  / unité";
  }
}