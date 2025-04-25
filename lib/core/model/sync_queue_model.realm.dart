// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_queue_model.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class SyncQueueItem extends _SyncQueueItem
    with RealmEntity, RealmObjectBase, RealmObject {
  SyncQueueItem(
    ObjectId id,
    String entityType,
    String entityId,
    String operation,
    DateTime createdAt,
    bool isSynced, {
    String? payload,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'entityType', entityType);
    RealmObjectBase.set(this, 'entityId', entityId);
    RealmObjectBase.set(this, 'operation', operation);
    RealmObjectBase.set(this, 'payload', payload);
    RealmObjectBase.set(this, 'createdAt', createdAt);
    RealmObjectBase.set(this, 'isSynced', isSynced);
  }

  SyncQueueItem._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, 'id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get entityType =>
      RealmObjectBase.get<String>(this, 'entityType') as String;
  @override
  set entityType(String value) =>
      RealmObjectBase.set(this, 'entityType', value);

  @override
  String get entityId =>
      RealmObjectBase.get<String>(this, 'entityId') as String;
  @override
  set entityId(String value) => RealmObjectBase.set(this, 'entityId', value);

  @override
  String get operation =>
      RealmObjectBase.get<String>(this, 'operation') as String;
  @override
  set operation(String value) => RealmObjectBase.set(this, 'operation', value);

  @override
  String? get payload =>
      RealmObjectBase.get<String>(this, 'payload') as String?;
  @override
  set payload(String? value) => RealmObjectBase.set(this, 'payload', value);

  @override
  DateTime get createdAt =>
      RealmObjectBase.get<DateTime>(this, 'createdAt') as DateTime;
  @override
  set createdAt(DateTime value) =>
      RealmObjectBase.set(this, 'createdAt', value);

  @override
  bool get isSynced => RealmObjectBase.get<bool>(this, 'isSynced') as bool;
  @override
  set isSynced(bool value) => RealmObjectBase.set(this, 'isSynced', value);

  @override
  Stream<RealmObjectChanges<SyncQueueItem>> get changes =>
      RealmObjectBase.getChanges<SyncQueueItem>(this);

  @override
  Stream<RealmObjectChanges<SyncQueueItem>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<SyncQueueItem>(this, keyPaths);

  @override
  SyncQueueItem freeze() => RealmObjectBase.freezeObject<SyncQueueItem>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'entityType': entityType.toEJson(),
      'entityId': entityId.toEJson(),
      'operation': operation.toEJson(),
      'payload': payload.toEJson(),
      'createdAt': createdAt.toEJson(),
      'isSynced': isSynced.toEJson(),
    };
  }

  static EJsonValue _toEJson(SyncQueueItem value) => value.toEJson();
  static SyncQueueItem _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'entityType': EJsonValue entityType,
        'entityId': EJsonValue entityId,
        'operation': EJsonValue operation,
        'createdAt': EJsonValue createdAt,
        'isSynced': EJsonValue isSynced,
      } =>
        SyncQueueItem(
          fromEJson(id),
          fromEJson(entityType),
          fromEJson(entityId),
          fromEJson(operation),
          fromEJson(createdAt),
          fromEJson(isSynced),
          payload: fromEJson(ejson['payload']),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(SyncQueueItem._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, SyncQueueItem, 'SyncQueueItem', [
      SchemaProperty('id', RealmPropertyType.objectid, primaryKey: true),
      SchemaProperty('entityType', RealmPropertyType.string),
      SchemaProperty('entityId', RealmPropertyType.string),
      SchemaProperty('operation', RealmPropertyType.string),
      SchemaProperty('payload', RealmPropertyType.string, optional: true),
      SchemaProperty('createdAt', RealmPropertyType.timestamp),
      SchemaProperty('isSynced', RealmPropertyType.bool),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
