import 'dart:convert';
import 'package:clean_architecture/core/error/exception.dart';
import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/core/model/sync_queue_model.dart';
import 'package:clean_architecture/core/network/network_info.dart';
import 'package:clean_architecture/core/provider/sync_provider.dart'; 
import 'package:clean_architecture/core/util/logger.dart';
import 'package:clean_architecture/feature/posts/data/datasources/post_local_data_source.dart';
import 'package:clean_architecture/feature/posts/data/datasources/post_remote_data_source.dart';
import 'package:clean_architecture/feature/posts/data/models/post_model.dart';
import 'package:clean_architecture/feature/posts/domain/entities/post_entity.dart';
import 'package:clean_architecture/feature/posts/domain/repositories/post_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:uuid/uuid.dart';

class PostRepositoryImpl implements PostRepository {
  final PostOnlineDataSource onlineDataSource;
  final PostOfflineDataSource offlineDataSource;
  final NetworkInfo networkInfo;
  final SyncService syncService; 

  PostRepositoryImpl({
    required this.onlineDataSource,
    required this.offlineDataSource,
    required this.networkInfo,
    required this.syncService,
  });

  @override
  Future<Either<Failure, List<PostEntity>>> getPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final onlinePostsDto = await onlineDataSource.getPosts();
        final onlinePosts = onlinePostsDto.map((dto) => dto.toModel()).toList();
        
        await offlineDataSource.cachePosts(onlinePosts);
        return Right(onlinePosts.map((model) => model.toEntity()).toList());
      } on ServerException catch (e) {
        
        Logs.w(
            'Failed to fetch posts online, falling back to cache: ${e.message}');
        return _getPostsFromCache();
      } on CacheException {
        
        
        return Left(CacheFailure());
      } catch (e) {
        
        Logs.e('Unexpected error in getPosts (online path): $e');
        return Left(ServerFailure(message: 'Unexpected error: $e'));
      }
    } else {
      
      return _getPostsFromCache();
    }
  }

  
  Future<Either<Failure, List<PostEntity>>> _getPostsFromCache() async {
    try {
      final localPosts = await offlineDataSource.getPosts();
      return Right(localPosts.map((model) => model.toEntity()).toList());
    } on CacheException {
      return Left(CacheFailure());
    } catch (e) {
      Logs.e('Unexpected error in _getPostsFromCache: $e');
      return Left(CacheFailure()); 
    }
  }

  @override
  Future<Either<Failure, PostEntity>> getPostById(String id) async {
    if (await networkInfo.isConnected) {
      try {
        
        final postDto = await onlineDataSource.getPostById(id);
        final postModel = postDto.toModel();
        
        await offlineDataSource.cachePost(postModel);
        return Right(postModel.toEntity());
      } on ServerException catch (e) {
        Logs.w(
            'Failed to fetch post $id online, falling back to cache: ${e.message}');
        
        return _getPostByIdFromCache(id);
      } on CacheException {
        
        return Left(CacheFailure());
      } catch (e) {
        Logs.e('Unexpected error in getPostById (online path): $e');
        return Left(ServerFailure(message: 'Unexpected error: $e'));
      }
    } else {
      
      return _getPostByIdFromCache(id);
    }
  }

  
  Future<Either<Failure, PostEntity>> _getPostByIdFromCache(String id) async {
    try {
      final localPost = await offlineDataSource.getPostById(id);
      if (localPost != null) {
        return Right(localPost.toEntity());
      } else {
        return Left(CacheFailure()); 
      }
    } on CacheException {
      return Left(CacheFailure());
    } catch (e) {
      Logs.e('Unexpected error in _getPostByIdFromCache: $e');
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, PostEntity>> createPost(PostEntity post) async {
    
    final localId = post.id.isEmpty ? const Uuid().v4().toString() : post.id;
    final postModel = PostModel(
      localId,
      post.title,
      post.body,
      false, 
    );

    try {
      
      await offlineDataSource.cachePost(postModel);

      
      if (await networkInfo.isConnected) {
        try {
          final createdDto = await onlineDataSource.createPost(
              postModel.title, postModel.body);
          final syncedPostModel =
              createdDto.toModel(isSynced: true); 

          
          
          await offlineDataSource.cachePost(syncedPostModel);

          
          if (syncedPostModel.id != localId) {
            await offlineDataSource.deletePost(localId);
          }

          return Right(syncedPostModel.toEntity());
        } on ServerException catch (e) {
          Logs.w(
              'Failed to create post online, adding to sync queue: ${e.message}');
          
          _addCreateToSyncQueue(postModel);
          return Right(postModel.toEntity()); 
        }
      } else {
        
        _addCreateToSyncQueue(postModel);
        return Right(postModel.toEntity()); 
      }
    } on CacheException {
      return Left(CacheFailure());
    } catch (e) {
      Logs.e('Unexpected error in createPost: $e');
      
      return Left(CacheFailure());
    }
  }

  void _addCreateToSyncQueue(PostModel postModel) {
    syncService.addToSyncQueue(
      entityType: 'post',
      entityId: postModel.id, 
      operation: SyncOperation.create,
      payload: jsonEncode({
        'title': postModel.title,
        'body': postModel.body,
      }),
    );
  }

  @override
  Future<Either<Failure, PostEntity>> updatePost(PostEntity post) async {
    try {
      
      final existingModel = await offlineDataSource.getPostById(post.id);
      if (existingModel == null) {
        return Left(CacheFailure()); 
      }

      
      final updatedModel = PostModel(
        post.id,
        post.title,
        post.body,
        false, 
      );

      
      await offlineDataSource.cachePost(updatedModel);

      
      if (await networkInfo.isConnected) {
        try {
          final updatedDto = await onlineDataSource.updatePost(post);
          final syncedModel =
              updatedDto.toModel(isSynced: true); 

          
          await offlineDataSource.cachePost(syncedModel);
          return Right(syncedModel.toEntity());
        } on ServerException catch (e) {
          Logs.w(
              'Failed to update post online, adding to sync queue: ${e.message}');
          
          _addUpdateToSyncQueue(updatedModel);
          return Right(updatedModel.toEntity()); 
        }
      } else {
        
        _addUpdateToSyncQueue(updatedModel);
        return Right(updatedModel.toEntity()); 
      }
    } on CacheException {
      return Left(CacheFailure());
    } catch (e) {
      Logs.e('Unexpected error in updatePost: $e');
      return Left(CacheFailure());
    }
  }

  void _addUpdateToSyncQueue(PostModel postModel) {
    syncService.addToSyncQueue(
      entityType: 'post',
      entityId: postModel.id,
      operation: SyncOperation.update,
      payload: jsonEncode({
        'title': postModel.title,
        'body': postModel.body,
      }),
    );
  }

  @override
  Future<Either<Failure, bool>> deletePost(String id) async {
    try {
      
      await offlineDataSource.deletePost(id);

      
      if (await networkInfo.isConnected) {
        try {
          await onlineDataSource.deletePost(id);
          return const Right(true); 
        } on ServerException catch (e) {
          Logs.w(
              'Failed to delete post online, adding to sync queue: ${e.message}');
          
          _addDeleteToSyncQueue(id);
          return const Right(true); 
        }
      } else {
        
        _addDeleteToSyncQueue(id);
        return const Right(true); 
      }
    } on CacheException {
      
      
      
      return Left(CacheFailure());
    } catch (e) {
      Logs.e('Unexpected error in deletePost: $e');
      return Left(CacheFailure());
    }
  }

  void _addDeleteToSyncQueue(String id) {
    syncService.addToSyncQueue(
      entityType: 'post',
      entityId: id,
      operation: SyncOperation.delete,
      
    );
  }
}
