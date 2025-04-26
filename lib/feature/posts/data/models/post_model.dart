import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:realm/realm.dart';
import '../../domain/entities/post_entity.dart';

part 'post_model.freezed.dart';
part 'post_model.g.dart';
part 'post_model.realm.dart';

@RealmModel()
class _PostModel {
  @PrimaryKey()
  late String id;
  late String title;
  late String content;
  late bool isSynced;
}

extension PostModelExtension on PostModel {
  PostEntity toEntity() {
    return PostEntity(
      id: id,
      title: title,
      content: content,
    );
  }
}

@freezed
class PostDto with _$PostDto {
  factory PostDto({
    required String id,
    required String title,
    required String content,
  }) = _PostDto;

  factory PostDto.fromJson(Map<String, dynamic> json) =>
      _$PostDtoFromJson(json);
}

extension PostDtoExtension on PostDto {
  PostModel toModel({bool isSynced = true}) {
    return PostModel(
      id,
      title,
      content,
      isSynced,
    );
  }
}
