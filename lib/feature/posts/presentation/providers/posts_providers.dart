import 'package:clean_architecture/core/provider/core_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/datasources/post_local_data_source.dart';
import '../../data/datasources/post_remote_data_source.dart';
import '../../data/repositories/post_repository_impl.dart';
import '../../domain/repositories/post_repository.dart';
import '../../domain/usecases/post_usecases.dart';

part 'posts_providers.g.dart';

// Data Sources Providers
@riverpod
PostRemoteDataSource postRemoteDataSource(Ref ref) {
  return PostRemoteDataSourceImpl(ref.read(dioProvider));
}

@riverpod
PostLocalDataSource postLocalDataSource(Ref ref) {
  return PostLocalDataSourceImpl(ref.read(realmProvider));
}

@riverpod
PostRepository postRepository(Ref ref) {
  return PostRepositoryImpl(
    remoteDataSource: ref.read(postRemoteDataSourceProvider),
    localDataSource: ref.read(postLocalDataSourceProvider),
    networkInfo: ref.read(networkInfoProvider),
  );
}

@riverpod
GetPost getPostUseCase(Ref ref) {
  return GetPost(ref.read(postRepositoryProvider));
}

@riverpod
CreatePost createPostUseCase(Ref ref) {
  return CreatePost(ref.read(postRepositoryProvider));
}

@riverpod
UpdatePost updatePostUseCase(Ref ref) {
  return UpdatePost(ref.read(postRepositoryProvider));
}

@riverpod
DeletePost deletePostUseCase(Ref ref) {
  return DeletePost(ref.read(postRepositoryProvider));
}

@riverpod
GetPosts getPostsUseCase(Ref ref) {
  return GetPosts(ref.read(postRepositoryProvider));
}

@riverpod
SyncPosts syncPostsUseCase(Ref ref) {
  return SyncPosts(ref.read(postRepositoryProvider));
}
