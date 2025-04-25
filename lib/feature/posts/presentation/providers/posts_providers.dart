import 'package:clean_architecture/core/api/api_service.dart';
import 'package:clean_architecture/core/local/realm_config.dart';
import 'package:clean_architecture/core/network/network_info.dart';
import 'package:clean_architecture/core/provider/sync_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/datasources/post_local_data_source.dart';
import '../../data/datasources/post_remote_data_source.dart';
import '../../data/repositories/post_repository_impl.dart';
import '../../domain/repositories/post_repository.dart';
import '../../domain/usecases/post_usecases.dart';

part 'posts_providers.g.dart';

@riverpod
PostOnlineDataSource postOnlineDataSource(Ref ref) {
  return PostOnlineDataSourceImpl(apiService: ref.watch(apiServiceProvider));
}

@riverpod
PostOfflineDataSource postOfflineDataSource(Ref ref) {
  return PostOfflineDataSourceImpl(realmConfig: ref.watch(realmConfigProvider));
}

@riverpod
PostRepository postRepository(Ref ref) {
  return PostRepositoryImpl(
    onlineDataSource: ref.watch(postOnlineDataSourceProvider),
    offlineDataSource: ref.watch(postOfflineDataSourceProvider),
    networkInfo: ref.watch(networkInfoProvider),
    syncService: ref.watch(syncServiceProvider),
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
