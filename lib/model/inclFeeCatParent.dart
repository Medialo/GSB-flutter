import 'package:gsb/model/inclFeeCatSubParent.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class InclFeeCatParent {
  int id = 0;
  String? name;
  final subs = ToMany<InclFeeCatSubParent>();

  InclFeeCatParent({this.name});

  @override
  String toString() => name != null ? name! : "name";

  @override
  bool operator == (Object other) {
    if(other is InclFeeCatParent){
      InclFeeCatParent o = other;
      if(o.id == this.id){
        return true;
      }
    }
  return false;
  }

  @override
  int get hashCode => super.hashCode;
}