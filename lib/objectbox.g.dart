// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: camel_case_types

import 'dart:typed_data';

import 'package:objectbox/flatbuffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';

import 'model/exclFee.dart';
import 'model/feeFile.dart';
import 'model/inclFee.dart';
import 'model/inclFeeCatParent.dart';
import 'model/inclFeeCatSubParent.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 666527329346834457),
      name: 'ExclFee',
      lastPropertyId: const IdUid(5, 2083462431503190534),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 7545894885021471048),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 43109064030840952),
            name: 'label',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 5086742235578415318),
            name: 'date',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 5108151095415754544),
            name: 'valid',
            type: 1,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 2083462431503190534),
            name: 'price',
            type: 8,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(2, 80096669195586224),
      name: 'FeeFile',
      lastPropertyId: const IdUid(3, 1890742470366143103),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 1724494222516686992),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 5359979957785263185),
            name: 'created',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 1890742470366143103),
            name: 'edited',
            type: 10,
            flags: 0)
      ],
      relations: <ModelRelation>[
        ModelRelation(
            id: const IdUid(1, 3765544193573741165),
            name: 'incls',
            targetId: const IdUid(3, 4417547793415280261)),
        ModelRelation(
            id: const IdUid(2, 9147344117919616069),
            name: 'excls',
            targetId: const IdUid(1, 666527329346834457))
      ],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(3, 4417547793415280261),
      name: 'InclFee',
      lastPropertyId: const IdUid(6, 3838900854098572514),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 8396308933139088442),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(3, 3845296302142270813),
            name: 'qtt',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 7643725864620769963),
            name: 'date',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 2986690875871064557),
            name: 'valid',
            type: 1,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 3838900854098572514),
            name: 'catId',
            type: 11,
            flags: 520,
            indexId: const IdUid(2, 3570574217388908559),
            relationTarget: 'InclFeeCatSubParent')
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(4, 2212680753863616015),
      name: 'InclFeeCatParent',
      lastPropertyId: const IdUid(2, 2999504017751234245),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 3505160592594309139),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 2999504017751234245),
            name: 'name',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[
        ModelRelation(
            id: const IdUid(3, 8367154258601148559),
            name: 'subs',
            targetId: const IdUid(5, 351448137506912629))
      ],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(5, 351448137506912629),
      name: 'InclFeeCatSubParent',
      lastPropertyId: const IdUid(4, 849039291354334714),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 1822271285776167551),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 4867574303198076419),
            name: 'catId',
            type: 11,
            flags: 520,
            indexId: const IdUid(1, 6180031007655616459),
            relationTarget: 'InclFeeCatParent'),
        ModelProperty(
            id: const IdUid(3, 7638564842653945292),
            name: 'name',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 849039291354334714),
            name: 'price',
            type: 8,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(5, 351448137506912629),
      lastIndexId: const IdUid(2, 3570574217388908559),
      lastRelationId: const IdUid(3, 8367154258601148559),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [6106237145696966782],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    ExclFee: EntityDefinition<ExclFee>(
        model: _entities[0],
        toOneRelations: (ExclFee object) => [],
        toManyRelations: (ExclFee object) => {},
        getId: (ExclFee object) => object.id,
        setId: (ExclFee object, int id) {
          object.id = id;
        },
        objectToFB: (ExclFee object, fb.Builder fbb) {
          final labelOffset =
              object.label == null ? null : fbb.writeString(object.label!);
          fbb.startTable(6);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, labelOffset);
          fbb.addInt64(2, object.date?.millisecondsSinceEpoch);
          fbb.addBool(3, object.valid);
          fbb.addFloat64(4, object.price);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final dateValue =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 8);
          final object = ExclFee(
              label: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 6),
              price: const fb.Float64Reader()
                  .vTableGetNullable(buffer, rootOffset, 12),
              date: dateValue == null
                  ? null
                  : DateTime.fromMillisecondsSinceEpoch(dateValue),
              valid: const fb.BoolReader()
                  .vTableGetNullable(buffer, rootOffset, 10),
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0));

          return object;
        }),
    FeeFile: EntityDefinition<FeeFile>(
        model: _entities[1],
        toOneRelations: (FeeFile object) => [],
        toManyRelations: (FeeFile object) => {
              RelInfo<FeeFile>.toMany(1, object.id): object.incls,
              RelInfo<FeeFile>.toMany(2, object.id): object.excls
            },
        getId: (FeeFile object) => object.id,
        setId: (FeeFile object, int id) {
          object.id = id;
        },
        objectToFB: (FeeFile object, fb.Builder fbb) {
          fbb.startTable(4);
          fbb.addInt64(0, object.id);
          fbb.addInt64(1, object.created.millisecondsSinceEpoch);
          fbb.addInt64(2, object.edited.millisecondsSinceEpoch);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = FeeFile(
              created: DateTime.fromMillisecondsSinceEpoch(
                  const fb.Int64Reader().vTableGet(buffer, rootOffset, 6, 0)),
              edited: DateTime.fromMillisecondsSinceEpoch(
                  const fb.Int64Reader().vTableGet(buffer, rootOffset, 8, 0)))
            ..id = const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          InternalToManyAccess.setRelInfo(object.incls, store,
              RelInfo<FeeFile>.toMany(1, object.id), store.box<FeeFile>());
          InternalToManyAccess.setRelInfo(object.excls, store,
              RelInfo<FeeFile>.toMany(2, object.id), store.box<FeeFile>());
          return object;
        }),
    InclFee: EntityDefinition<InclFee>(
        model: _entities[2],
        toOneRelations: (InclFee object) => [object.cat],
        toManyRelations: (InclFee object) => {},
        getId: (InclFee object) => object.id,
        setId: (InclFee object, int id) {
          object.id = id;
        },
        objectToFB: (InclFee object, fb.Builder fbb) {
          fbb.startTable(7);
          fbb.addInt64(0, object.id);
          fbb.addFloat64(2, object.qtt);
          fbb.addInt64(3, object.date?.millisecondsSinceEpoch);
          fbb.addBool(4, object.valid);
          fbb.addInt64(5, object.cat.targetId);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final dateValue =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 10);
          final object = InclFee(
              qtt: const fb.Float64Reader()
                  .vTableGetNullable(buffer, rootOffset, 8),
              date: dateValue == null
                  ? null
                  : DateTime.fromMillisecondsSinceEpoch(dateValue),
              valid: const fb.BoolReader()
                  .vTableGetNullable(buffer, rootOffset, 12),
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0));
          object.cat.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 14, 0);
          object.cat.attach(store);
          return object;
        }),
    InclFeeCatParent: EntityDefinition<InclFeeCatParent>(
        model: _entities[3],
        toOneRelations: (InclFeeCatParent object) => [],
        toManyRelations: (InclFeeCatParent object) =>
            {RelInfo<InclFeeCatParent>.toMany(3, object.id): object.subs},
        getId: (InclFeeCatParent object) => object.id,
        setId: (InclFeeCatParent object, int id) {
          object.id = id;
        },
        objectToFB: (InclFeeCatParent object, fb.Builder fbb) {
          final nameOffset =
              object.name == null ? null : fbb.writeString(object.name!);
          fbb.startTable(3);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, nameOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = InclFeeCatParent(
              name: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 6))
            ..id = const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          InternalToManyAccess.setRelInfo(
              object.subs,
              store,
              RelInfo<InclFeeCatParent>.toMany(3, object.id),
              store.box<InclFeeCatParent>());
          return object;
        }),
    InclFeeCatSubParent: EntityDefinition<InclFeeCatSubParent>(
        model: _entities[4],
        toOneRelations: (InclFeeCatSubParent object) => [object.cat],
        toManyRelations: (InclFeeCatSubParent object) => {},
        getId: (InclFeeCatSubParent object) => object.id,
        setId: (InclFeeCatSubParent object, int id) {
          object.id = id;
        },
        objectToFB: (InclFeeCatSubParent object, fb.Builder fbb) {
          final nameOffset =
              object.name == null ? null : fbb.writeString(object.name!);
          fbb.startTable(5);
          fbb.addInt64(0, object.id);
          fbb.addInt64(1, object.cat.targetId);
          fbb.addOffset(2, nameOffset);
          fbb.addFloat64(3, object.price);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = InclFeeCatSubParent(
              name: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 8),
              price:
                  const fb.Float64Reader().vTableGet(buffer, rootOffset, 10, 0))
            ..id = const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          object.cat.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 6, 0);
          object.cat.attach(store);
          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [ExclFee] entity fields to define ObjectBox queries.
class ExclFee_ {
  /// see [ExclFee.id]
  static final id = QueryIntegerProperty<ExclFee>(_entities[0].properties[0]);

  /// see [ExclFee.label]
  static final label = QueryStringProperty<ExclFee>(_entities[0].properties[1]);

  /// see [ExclFee.date]
  static final date = QueryIntegerProperty<ExclFee>(_entities[0].properties[2]);

  /// see [ExclFee.valid]
  static final valid =
      QueryBooleanProperty<ExclFee>(_entities[0].properties[3]);

  /// see [ExclFee.price]
  static final price = QueryDoubleProperty<ExclFee>(_entities[0].properties[4]);
}

/// [FeeFile] entity fields to define ObjectBox queries.
class FeeFile_ {
  /// see [FeeFile.id]
  static final id = QueryIntegerProperty<FeeFile>(_entities[1].properties[0]);

  /// see [FeeFile.created]
  static final created =
      QueryIntegerProperty<FeeFile>(_entities[1].properties[1]);

  /// see [FeeFile.edited]
  static final edited =
      QueryIntegerProperty<FeeFile>(_entities[1].properties[2]);

  /// see [FeeFile.incls]
  static final incls =
      QueryRelationMany<FeeFile, InclFee>(_entities[1].relations[0]);

  /// see [FeeFile.excls]
  static final excls =
      QueryRelationMany<FeeFile, ExclFee>(_entities[1].relations[1]);
}

/// [InclFee] entity fields to define ObjectBox queries.
class InclFee_ {
  /// see [InclFee.id]
  static final id = QueryIntegerProperty<InclFee>(_entities[2].properties[0]);

  /// see [InclFee.qtt]
  static final qtt = QueryDoubleProperty<InclFee>(_entities[2].properties[1]);

  /// see [InclFee.date]
  static final date = QueryIntegerProperty<InclFee>(_entities[2].properties[2]);

  /// see [InclFee.valid]
  static final valid =
      QueryBooleanProperty<InclFee>(_entities[2].properties[3]);

  /// see [InclFee.cat]
  static final cat = QueryRelationProperty<InclFee, InclFeeCatSubParent>(
      _entities[2].properties[4]);
}

/// [InclFeeCatParent] entity fields to define ObjectBox queries.
class InclFeeCatParent_ {
  /// see [InclFeeCatParent.id]
  static final id =
      QueryIntegerProperty<InclFeeCatParent>(_entities[3].properties[0]);

  /// see [InclFeeCatParent.name]
  static final name =
      QueryStringProperty<InclFeeCatParent>(_entities[3].properties[1]);

  /// see [InclFeeCatParent.subs]
  static final subs = QueryRelationMany<InclFeeCatParent, InclFeeCatSubParent>(
      _entities[3].relations[0]);
}

/// [InclFeeCatSubParent] entity fields to define ObjectBox queries.
class InclFeeCatSubParent_ {
  /// see [InclFeeCatSubParent.id]
  static final id =
      QueryIntegerProperty<InclFeeCatSubParent>(_entities[4].properties[0]);

  /// see [InclFeeCatSubParent.cat]
  static final cat =
      QueryRelationProperty<InclFeeCatSubParent, InclFeeCatParent>(
          _entities[4].properties[1]);

  /// see [InclFeeCatSubParent.name]
  static final name =
      QueryStringProperty<InclFeeCatSubParent>(_entities[4].properties[2]);

  /// see [InclFeeCatSubParent.price]
  static final price =
      QueryDoubleProperty<InclFeeCatSubParent>(_entities[4].properties[3]);
}
