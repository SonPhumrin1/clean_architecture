import 'package:clean_architecture/core/api/api_service.dart';
import 'package:clean_architecture/core/error/exception.dart';
import 'package:clean_architecture/feature/posts/data/models/post_model.dart';
import 'package:clean_architecture/feature/posts/domain/entities/post_entity.dart';
import 'package:dio/dio.dart';

abstract class PostOnlineDataSource {
  Future<List<PostDto>> getPosts();

  Future<PostDto> getPostById(String id);

  Future<PostDto> createPost(String title, String content);

  Future<PostDto> updatePost(PostEntity post);

  Future<void> deletePost(String id);
}

class PostOnlineDataSourceImpl implements PostOnlineDataSource {
  final ApiService apiService;

  PostOnlineDataSourceImpl({required this.apiService});

  @override
  Future<List<PostDto>> getPosts() async {
    try {
      final response = await apiService.get('posts');
      final List<dynamic> postsJson = response.data['data'];
      return postsJson.map((json) => PostDto.fromJson(json)).toList();
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Failed to fetch posts');
    } catch (e) {
      throw ServerException('An unexpected error occurred: $e');
    }
  }

  @override
  Future<PostDto> getPostById(String id) async {
    try {
      final response = await apiService.get('posts/$id');
      return PostDto.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Failed to fetch post $id');
    } catch (e) {
      throw ServerException('An unexpected error occurred: $e');
    }
  }

  @override
  Future<PostDto> createPost(String title, String content) async {
    try {
      final data = PostEntity(
        id: "${DateTime.now().millisecondsSinceEpoch}",
        content: content,
        title: title,
      );

      final response = await apiService.post(
        'posts',
        data: data.toJson(),
      );

      return PostDto.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Failed to create post');
    } catch (e) {
      throw ServerException('An unexpected error occurred: $e');
    }
  }

  @override
  Future<PostDto> updatePost(PostEntity post) async {
    try {
      final response = await apiService.put(
        'posts/${post.id}',
        data: post.toJson(),
      );

      return PostDto.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Failed to update post ${post.id}');
    } catch (e) {
      throw ServerException('An unexpected error occurred: $e');
    }
  }

  @override
  Future<void> deletePost(String id) async {
    try {
      await apiService.delete('posts/$id');
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Failed to delete post $id');
    } catch (e) {
      throw ServerException('An unexpected error occurred: $e');
    }
  }
}
