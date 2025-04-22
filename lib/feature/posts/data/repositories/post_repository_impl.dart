import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/core/util/network_info.dart';
import 'package:clean_architecture/feature/posts/data/model.dart/post_offline_model.dart';
import 'package:clean_architecture/feature/posts/data/model.dart/post_online_model.dart';
import 'package:dartz/dartz.dart';
import '../../domain/entities/post_entity.dart';
import '../../domain/repositories/post_repository.dart';
import '../datasources/post_local_data_source.dart';
import '../datasources/post_remote_data_source.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remoteDataSource;
  final PostLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PostRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<PostEntity>>> getPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await remoteDataSource.getPosts();
        final realmPosts = remotePosts
            .map((model) => PostOfflineModel.fromEntity(
                PostOnlineModel.toEntity(model) as PostEntity))
            .toList();
        await localDataSource.cachePosts(realmPosts);
        return Right(remotePosts
            .map((model) => PostOnlineModel.toEntity(model) as PostEntity)
            .toList());
      } on Exception {
        return Left(
            ServerFailure(message: 'Failed to fetch posts from server'));
      }
    } else {
      try {
        final localPosts = await localDataSource.getPosts();
        return Right(localPosts.map((model) => model.toEntity()).toList());
      } on CacheFailure {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, PostEntity>> getPost(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final remotePost = await remoteDataSource.getPost(id);
        await localDataSource.cachePost(PostOfflineModel.fromEntity(
            PostOnlineModel.toEntity(remotePost) as PostEntity));
        return Right(PostOnlineModel.toEntity(remotePost) as PostEntity);
      } on Exception {
        return Left(ServerFailure(message: 'Failed to fetch post from server'));
      }
    } else {
      try {
        final localPost = await localDataSource.getPost(id);
        if (localPost != null) {
          return Right(localPost.toEntity());
        } else {
          return Left(CacheFailure());
        }
      } on CacheFailure {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, PostEntity>> createPost(PostEntity post) async {
    if (await networkInfo.isConnected) {
      try {
        final postApiModel = PostOnlineModel(
            id: post.id,
            userId: post.userId,
            title: post.title,
            body: post.body);
        final createdPost = await remoteDataSource.createPost(postApiModel);
        await localDataSource.cachePost(PostOfflineModel.fromEntity(
            PostOnlineModel.toEntity(createdPost) as PostEntity));
        return Right(PostOnlineModel.toEntity(createdPost) as PostEntity);
      } on Exception {
        return Left(ServerFailure(message: 'Failed to create post'));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, PostEntity>> updatePost(PostEntity post) async {
    if (await networkInfo.isConnected) {
      try {
        final postApiModel = PostOnlineModel(
            id: post.id,
            userId: post.userId,
            title: post.title,
            body: post.body);
        final updatedPost = await remoteDataSource.updatePost(postApiModel);
        await localDataSource.cachePost(PostOfflineModel.fromEntity(
            PostOnlineModel.toEntity(updatedPost) as PostEntity));
        return Right(PostOnlineModel.toEntity(updatedPost) as PostEntity);
      } on Exception {
        return Left(ServerFailure(message: 'Failed to update post'));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deletePost(int id) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deletePost(id);
        await localDataSource.deletePost(id);
        return Right(null);
      } on Exception {
        return Left(ServerFailure(message: 'Failed to delete post'));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<PostEntity>>> syncPosts(
      List<PostEntity> posts) async {
    if (await networkInfo.isConnected) {
      try {
        final postApiModels = posts
            .map((post) => PostOfflineModel(
                id: post.id,
                userId: post.userId,
                title: post.title,
                body: post.body))
            .toList();
        final syncedPosts = await remoteDataSource.syncPosts(postApiModels);
        final realmPosts = syncedPosts
            .map((model) => PostOfflineModel.fromEntity(
                PostOnlineModel.toEntity(model) as PostEntity))
            .toList();
        await localDataSource.cachePosts(realmPosts);
        return Right(syncedPosts
            .map((model) => PostOnlineModel.toEntity(model) as PostEntity)
            .toList());
      } on Exception {
        return Left(ServerFailure(message: 'Failed to sync posts'));
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
