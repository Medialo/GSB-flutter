import 'package:gsb/model/inclFeeCatParent.dart';
import 'package:gsb/model/inclFeeCatSubParent.dart';
import 'package:gsb/objectbox.g.dart';

@Deprecated("non implémenté")
class DataInit {
  //todo ref
  const DataInit();

  static void initData(Store store){
    final Box box = store.box<InclFeeCatParent>();
    final Box boxSub = store.box<InclFeeCatSubParent>();
    InclFeeCatParent parent = InclFeeCatParent()..id=1;

    InclFeeCatSubParent sp1 = InclFeeCatSubParent(name: "Ordinateur", price: 250)..id=1..cat.target = parent;
    parent.subs.add(sp1);
    boxSub.put(sp1);

    box.put(parent);
    parent = InclFeeCatParent(name: "Restoration")..id=2;
    InclFeeCatSubParent sp2 = InclFeeCatSubParent(name: "Repas", price: 8.5)..id=2..cat.target = parent;
    parent.subs.add(sp2);
    boxSub.put(sp2);

    box.put(parent);
    parent = InclFeeCatParent(name: "Trajet")..id=3;
    InclFeeCatSubParent sp3 = InclFeeCatSubParent(name: "Diesel", price: 0.75)..id=3..cat.target = parent;
    parent.subs.add(sp3);
    boxSub.put(sp3);

    box.put(parent);

  }
}