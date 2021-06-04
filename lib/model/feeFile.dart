import 'package:gsb/model/exclFee.dart';
import 'package:gsb/model/inclFee.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class FeeFile {
  int id = 0;
  final DateTime created;
  DateTime edited;
  final incls = ToMany<InclFee>();
  final excls = ToMany<ExclFee>();

  FeeFile({
    required this.created,
    required this.edited,
  });
}