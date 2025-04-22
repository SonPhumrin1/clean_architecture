import 'package:clean_architecture/core/util/constants.dart';
import 'package:clean_architecture/feature/posts/data/model.dart/post_offline_model.dart';
import 'package:clean_architecture/feature/posts/data/model.dart/post_online_model.dart';
import 'package:dio/dio.dart';

abstract class PostRemoteDataSource {
  Future<List<PostOnlineModel>> getPosts();
  Future<PostOnlineModel> getPost(int id);
  Future<PostOnlineModel> createPost(PostOnlineModel post);
  Future<PostOnlineModel> updatePost(PostOnlineModel post);
  Future<void> deletePost(int id);
  Future<List<PostOnlineModel>> syncPosts(List<PostOfflineModel> posts);
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final Dio dio;

  PostRemoteDataSourceImpl(this.dio);

  @override
  Future<List<PostOnlineModel>> getPosts() async {
    final response =
        await dio.get(AppConstants.apiBaseUrl + AppConstants.postsEndpoint);
    if (response.statusCode == 200) {
      return (response.data as List)
          .map((json) => PostOnlineModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load posts'); // Or a custom ServerException
    }
  }

  @override
  Future<PostOnlineModel> getPost(int id) async {
    final response =
        await dio.get('https://jsonplaceholder.typicode.com/posts/$id');
    if (response.statusCode == 200) {
      return PostOnlineModel.fromJson(response.data);
    } else {
      throw Exception('Failed to load post');
    }
  }

  @override
  Future<PostOnlineModel> createPost(PostOnlineModel post) async {
    final response = await dio.post(
      AppConstants.apiBaseUrl + AppConstants.postsEndpoint,
      data: post.toJson(),
    );
    if (response.statusCode == 201) {
      return PostOnlineModel.fromJson(response.data);
    } else {
      throw Exception('Failed to create post');
    }
  }

  @override
  Future<PostOnlineModel> updatePost(PostOnlineModel post) async {
    final response = await dio.put(
      '${AppConstants.apiBaseUrl}${AppConstants.postsEndpoint}${post.id}',
      data: post.toJson(),
    );
    if (response.statusCode == 200) {
      return PostOnlineModel.fromJson(response.data);
    } else {
      throw Exception('Failed to update post');
    }
  }

  @override
  Future<void> deletePost(int id) async {
    final response = await dio.delete(
        AppConstants.apiBaseUrl + AppConstants.postsEndpoint + id.toString());
    if (response.statusCode != 200) {
      throw Exception('Failed to delete post');
    }
  }

  @override
  Future<List<PostOnlineModel>> syncPosts(List<PostOfflineModel> posts) async {
    final response = await dio.post(
      AppConstants.apiBaseUrl + AppConstants.postsEndpoint,
      data: posts.map((post) => post.toEntity()).toList(),
    );
    if (response.statusCode == 200) {
      return (response.data as List)
          .map((json) => PostOnlineModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to sync posts');
    }
  }
}
