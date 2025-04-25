// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_config_model.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class AppConfig extends _AppConfig
    with RealmEntity, RealmObjectBase, RealmObject {
  static var _defaultsSet = false;

  AppConfig(
    int id,
    bool isDarkMode, {
    bool isFirstTime = true,
    String? accessToken,
    String? refreshToken,
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<AppConfig>({
        'isFirstTime': true,
      });
    }
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'isFirstTime', isFirstTime);
    RealmObjectBase.set(this, 'isDarkMode', isDarkMode);
    RealmObjectBase.set(this, 'accessToken', accessToken);
    RealmObjectBase.set(this, 'refreshToken', refreshToken);
  }

  AppConfig._();

  @override
  int get id => RealmObjectBase.get<int>(this, 'id') as int;
  @override
  set id(int value) => RealmObjectBase.set(this, 'id', value);

  @override
  bool get isFirstTime =>
      RealmObjectBase.get<bool>(this, 'isFirstTime') as bool;
  @override
  set isFirstTime(bool value) =>
      RealmObjectBase.set(this, 'isFirstTime', value);

  @override
  bool get isDarkMode => RealmObjectBase.get<bool>(this, 'isDarkMode') as bool;
  @override
  set isDarkMode(bool value) => RealmObjectBase.set(this, 'isDarkMode', value);

  @override
  String? get accessToken =>
      RealmObjectBase.get<String>(this, 'accessToken') as String?;
  @override
  set accessToken(String? value) =>
      RealmObjectBase.set(this, 'accessToken', value);

  @override
  String? get refreshToken =>
      RealmObjectBase.get<String>(this, 'refreshToken') as String?;
  @override
  set refreshToken(String? value) =>
      RealmObjectBase.set(this, 'refreshToken', value);

  @override
  Stream<RealmObjectChanges<AppConfig>> get changes =>
      RealmObjectBase.getChanges<AppConfig>(this);

  @override
  Stream<RealmObjectChanges<AppConfig>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<AppConfig>(this, keyPaths);

  @override
  AppConfig freeze() => RealmObjectBase.freezeObject<AppConfig>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'isFirstTime': isFirstTime.toEJson(),
      'isDarkMode': isDarkMode.toEJson(),
      'accessToken': accessToken.toEJson(),
      'refreshToken': refreshToken.toEJson(),
    };
  }

  static EJsonValue _toEJson(AppConfig value) => value.toEJson();
  static AppConfig _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'isDarkMode': EJsonValue isDarkMode,
      } =>
        AppConfig(
          fromEJson(id),
          fromEJson(isDarkMode),
          isFirstTime: fromEJson(ejson['isFirstTime'], defaultValue: true),
          accessToken: fromEJson(ejson['accessToken']),
          refreshToken: fromEJson(ejson['refreshToken']),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(AppConfig._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(ObjectType.realmObject, AppConfig, 'AppConfig', [
      SchemaProperty('id', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('isFirstTime', RealmPropertyType.bool),
      SchemaProperty('isDarkMode', RealmPropertyType.bool),
      SchemaProperty('accessToken', RealmPropertyType.string, optional: true),
      SchemaProperty('refreshToken', RealmPropertyType.string, optional: true),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
