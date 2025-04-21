// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_online_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PostOnlineModel _$PostOnlineModelFromJson(Map<String, dynamic> json) {
  return _PostOnlineModel.fromJson(json);
}

/// @nodoc
mixin _$PostOnlineModel {
  int get id => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;

  /// Serializes this PostOnlineModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PostOnlineModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PostOnlineModelCopyWith<PostOnlineModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostOnlineModelCopyWith<$Res> {
  factory $PostOnlineModelCopyWith(
          PostOnlineModel value, $Res Function(PostOnlineModel) then) =
      _$PostOnlineModelCopyWithImpl<$Res, PostOnlineModel>;
  @useResult
  $Res call({int id, int userId, String title, String body});
}

/// @nodoc
class _$PostOnlineModelCopyWithImpl<$Res, $Val extends PostOnlineModel>
    implements $PostOnlineModelCopyWith<$Res> {
  _$PostOnlineModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PostOnlineModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? title = null,
    Object? body = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PostOnlineModelImplCopyWith<$Res>
    implements $PostOnlineModelCopyWith<$Res> {
  factory _$$PostOnlineModelImplCopyWith(_$PostOnlineModelImpl value,
          $Res Function(_$PostOnlineModelImpl) then) =
      __$$PostOnlineModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, int userId, String title, String body});
}

/// @nodoc
class __$$PostOnlineModelImplCopyWithImpl<$Res>
    extends _$PostOnlineModelCopyWithImpl<$Res, _$PostOnlineModelImpl>
    implements _$$PostOnlineModelImplCopyWith<$Res> {
  __$$PostOnlineModelImplCopyWithImpl(
      _$PostOnlineModelImpl _value, $Res Function(_$PostOnlineModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of PostOnlineModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? title = null,
    Object? body = null,
  }) {
    return _then(_$PostOnlineModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PostOnlineModelImpl implements _PostOnlineModel {
  const _$PostOnlineModelImpl(
      {required this.id,
      required this.userId,
      required this.title,
      required this.body});

  factory _$PostOnlineModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostOnlineModelImplFromJson(json);

  @override
  final int id;
  @override
  final int userId;
  @override
  final String title;
  @override
  final String body;

  @override
  String toString() {
    return 'PostOnlineModel(id: $id, userId: $userId, title: $title, body: $body)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostOnlineModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, title, body);

  /// Create a copy of PostOnlineModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostOnlineModelImplCopyWith<_$PostOnlineModelImpl> get copyWith =>
      __$$PostOnlineModelImplCopyWithImpl<_$PostOnlineModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PostOnlineModelImplToJson(
      this,
    );
  }
}

abstract class _PostOnlineModel implements PostOnlineModel {
  const factory _PostOnlineModel(
      {required final int id,
      required final int userId,
      required final String title,
      required final String body}) = _$PostOnlineModelImpl;

  factory _PostOnlineModel.fromJson(Map<String, dynamic> json) =
      _$PostOnlineModelImpl.fromJson;

  @override
  int get id;
  @override
  int get userId;
  @override
  String get title;
  @override
  String get body;

  /// Create a copy of PostOnlineModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostOnlineModelImplCopyWith<_$PostOnlineModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
