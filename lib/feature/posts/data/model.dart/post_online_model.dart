import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/post_entity.dart';

part 'post_online_model.freezed.dart';
part 'post_online_model.g.dart';

@freezed
class PostOnlineModel with _$PostOnlineModel {
  const factory PostOnlineModel({
    required int id,
    required int userId,
    required String title,
    required String body,
  }) = _PostOnlineModel;

  factory PostOnlineModel.fromJson(Map<String, dynamic> json) =>
      _$PostOnlineModelFromJson(json);

  // Mapper to domain entity
  factory PostOnlineModel.toEntity(PostOnlineModel model) {
    return PostEntity(
      id: model.id,
      userId: model.userId,
      title: model.title,
      body: model.body,
    ) as PostOnlineModel; // Cast needed due to different return type
  }
}
