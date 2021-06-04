import 'package:gsb/model/inclFeeCatSubParent.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class InclFee {

  static final InclFeeCatSubParent _defaultSubCat = InclFeeCatSubParent(
    price: 0,
    name: "Produit indisponible ou supprimé",
  );

  int id;
  double? qtt;
  DateTime? date;
  bool? valid;
  final cat = ToOne<InclFeeCatSubParent>();

  InclFee({this.qtt,this.date,this.valid = false,this.id=0});

  InclFeeCatSubParent? getCat(){
    if(this.cat.hasValue && this.cat.target != null){
      return this.cat.target;
    } else {
      return _defaultSubCat;
    }
  }
}