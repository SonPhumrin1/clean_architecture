import 'package:realm/realm.dart';
import '../../domain/entities/post_entity.dart';

part 'post_offline_model.realm.dart';

@RealmModel()
class _PostOffline {
  @PrimaryKey()
  late int id;
  late int userId;
  late String title;
  late String body;
}

class PostOfflineModel extends PostEntity {
  const PostOfflineModel({
    required super.id,
    required super.userId,
    required super.title,
    required super.body,
  });

  factory PostOfflineModel.fromEntity(PostEntity entity) {
    return PostOfflineModel(
      id: entity.id,
      userId: entity.userId,
      title: entity.title,
      body: entity.body,
    );
  }

  factory PostOfflineModel.fromRealmObject(PostOffline realmObject) {
    return PostOfflineModel(
      id: realmObject.id,
      userId: realmObject.userId,
      title: realmObject.title,
      body: realmObject.body,
    );
  }

  PostOffline toRealmObject() {
    return PostOffline(id, userId, title, body);
  }

  PostEntity toEntity() {
    return PostEntity(
      id: id,
      userId: userId,
      title: title,
      body: body,
    );
  }
}
