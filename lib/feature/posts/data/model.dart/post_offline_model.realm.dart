// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_offline_model.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class PostOffline extends _PostOffline
    with RealmEntity, RealmObjectBase, RealmObject {
  PostOffline(
    int id,
    int userId,
    String title,
    String body,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'userId', userId);
    RealmObjectBase.set(this, 'title', title);
    RealmObjectBase.set(this, 'body', body);
  }

  PostOffline._();

  @override
  int get id => RealmObjectBase.get<int>(this, 'id') as int;
  @override
  set id(int value) => RealmObjectBase.set(this, 'id', value);

  @override
  int get userId => RealmObjectBase.get<int>(this, 'userId') as int;
  @override
  set userId(int value) => RealmObjectBase.set(this, 'userId', value);

  @override
  String get title => RealmObjectBase.get<String>(this, 'title') as String;
  @override
  set title(String value) => RealmObjectBase.set(this, 'title', value);

  @override
  String get body => RealmObjectBase.get<String>(this, 'body') as String;
  @override
  set body(String value) => RealmObjectBase.set(this, 'body', value);

  @override
  Stream<RealmObjectChanges<PostOffline>> get changes =>
      RealmObjectBase.getChanges<PostOffline>(this);

  @override
  Stream<RealmObjectChanges<PostOffline>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<PostOffline>(this, keyPaths);

  @override
  PostOffline freeze() => RealmObjectBase.freezeObject<PostOffline>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'userId': userId.toEJson(),
      'title': title.toEJson(),
      'body': body.toEJson(),
    };
  }

  static EJsonValue _toEJson(PostOffline value) => value.toEJson();
  static PostOffline _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'userId': EJsonValue userId,
        'title': EJsonValue title,
        'body': EJsonValue body,
      } =>
        PostOffline(
          fromEJson(id),
          fromEJson(userId),
          fromEJson(title),
          fromEJson(body),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(PostOffline._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, PostOffline, 'PostOffline', [
      SchemaProperty('id', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('userId', RealmPropertyType.int),
      SchemaProperty('title', RealmPropertyType.string),
      SchemaProperty('body', RealmPropertyType.string),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
