// lib/injection/injection.dart (Example)
import 'package:clean_architecture/core/util/network_info.dart';
import 'package:clean_architecture/feature/posts/data/datasources/post_local_data_source.dart';
import 'package:clean_architecture/feature/posts/data/datasources/post_remote_data_source.dart';
import 'package:clean_architecture/feature/posts/data/model.dart/post_offline_model.dart';
import 'package:clean_architecture/feature/posts/data/repositories/post_repository_impl.dart';
import 'package:clean_architecture/feature/posts/domain/repositories/post_repository.dart';
import 'package:clean_architecture/feature/posts/domain/usecases/get_posts.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realm/realm.dart';

// Realm Configuration
final config =
    Configuration.local([PostOffline.schema]); // Include all Realm models

final realmProvider = Provider<Realm>((ref) {
  final realm = Realm(config);
  ref.onDispose(() => realm.close());
  return realm;
});

// Dio Provider
final dioProvider = Provider<Dio>((ref) => Dio());

// Network Info Provider
final networkInfoProvider = Provider<NetworkInfo>((ref) {
  final connectivity = Connectivity(); // Create Connectivity instance
  return NetworkInfoImpl(connectivity);
});

// Data Sources Providers
final postRemoteDataSourceProvider = Provider<PostRemoteDataSource>((ref) {
  return PostRemoteDataSourceImpl(ref.read(dioProvider));
});

final postLocalDataSourceProvider = Provider<PostLocalDataSource>((ref) {
  return PostLocalDataSourceImpl(ref.read(realmProvider));
});

// Repository Provider
final postRepositoryProvider = Provider<PostRepository>((ref) {
  return PostRepositoryImpl(
    remoteDataSource: ref.read(postRemoteDataSourceProvider),
    localDataSource: ref.read(postLocalDataSourceProvider),
    networkInfo: ref.read(networkInfoProvider),
  );
});

// Use Cases Providers
final getPostsUseCaseProvider = Provider<GetPosts>((ref) {
  return GetPosts(ref.read(postRepositoryProvider));
});
