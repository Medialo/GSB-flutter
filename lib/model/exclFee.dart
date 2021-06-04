import 'package:objectbox/objectbox.dart';

@Entity()
class ExclFee {
  int id;
  String? label;
  double? price;
  DateTime? date;
  bool? valid;

  ExclFee({this.label,this.price,this.date,this.valid,this.id = 0});

// ExclFee(this.label, this.price, this.date, this.valid);



}