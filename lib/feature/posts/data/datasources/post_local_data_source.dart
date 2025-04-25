import 'package:clean_architecture/core/util/logger.dart';
import 'package:realm/realm.dart';
import 'package:clean_architecture/feature/posts/data/models/post_model.dart';
import 'package:clean_architecture/core/error/exception.dart';
import 'package:clean_architecture/core/local/realm_config.dart';

abstract class PostOfflineDataSource {
  Future<List<PostModel>> getPosts();
  Future<PostModel?> getPostById(String id);
  Future<void> cachePost(PostModel post);
  Future<void> cachePosts(List<PostModel> posts);
  Future<void> deletePost(String id);
  Future<void> deleteAllPosts();
}

class PostOfflineDataSourceImpl implements PostOfflineDataSource {
  final RealmConfig realmConfig;

  Realm get realm => realmConfig.realm;

  PostOfflineDataSourceImpl({required this.realmConfig});

  @override
  Future<List<PostModel>> getPosts() async {
    try {
      return realm.all<PostModel>().toList();
    } catch (e) {
      Logs.e('Error fetching posts from local database: $e');
      throw CacheException("$e");
    }
  }

  @override
  Future<PostModel?> getPostById(String id) async {
    try {
      return realm.find<PostModel>(id);
    } catch (e) {
      Logs.e('Error finding post $id from local database: $e');
      throw CacheException("$e");
    }
  }

  @override
  Future<void> cachePost(PostModel post) async {
    try {
      realm.write(() {
        realm.add(post, update: true);
      });
    } catch (e) {
      Logs.e('Error caching post ${post.id}: $e');
      throw CacheException("$e");
    }
  }

  @override
  Future<void> cachePosts(List<PostModel> posts) async {
    try {
      realm.write(() {
        for (var post in posts) {
          realm.add(post, update: true);
        }
      });
    } catch (e) {
      Logs.e('Error caching posts batch: $e');
      throw CacheException("$e");
    }
  }

  @override
  Future<void> deletePost(String id) async {
    try {
      realm.write(() {
        final postToDelete = realm.find<PostModel>(id);
        if (postToDelete != null) {
          realm.delete(postToDelete);
        }
      });
    } catch (e) {
      Logs.e('Error deleting post $id from cache: $e');
      throw CacheException("$e");
    }
  }

  @override
  Future<void> deleteAllPosts() async {
    try {
      realm.write(() {
        realm.deleteAll<PostModel>();
      });
    } catch (e) {
      Logs.e('Error deleting all posts from cache: $e');
      throw CacheException("$e");
    }
  }
}
