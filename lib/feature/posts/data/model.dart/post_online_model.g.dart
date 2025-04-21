// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_online_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostOnlineModelImpl _$$PostOnlineModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PostOnlineModelImpl(
      id: (json['id'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      title: json['title'] as String,
      body: json['body'] as String,
    );

Map<String, dynamic> _$$PostOnlineModelImplToJson(
        _$PostOnlineModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'title': instance.title,
      'body': instance.body,
    };
