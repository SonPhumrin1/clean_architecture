import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/core/util/logger.dart';
import 'package:clean_architecture/feature/posts/data/model.dart/post_offline_model.dart';
import 'package:realm/realm.dart';

abstract class PostLocalDataSource {
  Future<List<PostOfflineModel>> getPosts();
  Future<void> cachePosts(List<PostOfflineModel> posts);
  Future<PostOfflineModel?> getPost(int id);
  Future<void> cachePost(PostOfflineModel post);
  Future<void> deletePost(int id);
}

class PostLocalDataSourceImpl implements PostLocalDataSource {
  final Realm realm;

  PostLocalDataSourceImpl(this.realm);

  @override
  Future<List<PostOfflineModel>> getPosts() async {
    try {
      final posts = realm.all<PostOffline>().toList();
      return posts
          .map((post) => PostOfflineModel.fromRealmObject(post))
          .toList();
    } catch (e) {
      throw CacheFailure();
    }
  }

  @override
  Future<void> cachePosts(List<PostOfflineModel> posts) async {
    try {
      realm.write(() {
        realm.deleteAll<PostOffline>();
        for (var post in posts) {
          realm.add(post.toRealmObject(), update: true); // Add or update
        }
      });
    } catch (e) {
      Logs.e('Error fetching posts from local database: $e');
      throw CacheFailure();
    }
  }

  @override
  Future<PostOfflineModel?> getPost(int id) async {
    try {
      final post = realm.find<PostOffline>(id);
      return post != null ? PostOfflineModel.fromRealmObject(post) : null;
    } catch (e) {
      throw CacheFailure();
    }
  }

  @override
  Future<void> cachePost(PostOfflineModel post) async {
    try {
      realm.write(() {
        realm.add(post.toRealmObject(), update: true); // Add or update
      });
    } catch (e) {
      throw CacheFailure();
    }
  }

  @override
  Future<void> deletePost(int id) async {
    try {
      realm.write(() {
        final postToDelete = realm.find<PostOffline>(id);
        if (postToDelete != null) {
          realm.delete(postToDelete);
        }
      });
    } catch (e) {
      throw CacheFailure();
    }
  }
}
