import 'package:clean_architecture/core/config/app_config_model.dart';
import 'package:clean_architecture/core/util/logger.dart';
import 'package:clean_architecture/core/util/network_info.dart';
import 'package:clean_architecture/feature/posts/data/model.dart/post_offline_model.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:realm/realm.dart';

part 'core_providers.g.dart';

final config = Configuration.local([PostOffline.schema, AppConfig.schema]);

@Riverpod(keepAlive: true)
Realm realm(Ref ref) {
  final realm = Realm(config);
  ref.onDispose(() {
    Logs.t("Closing Realm...");
    realm.close();
  });
  Logs.t("Realm Provider Initialized");
  return realm;
}

@riverpod
Dio dio(Ref ref) {
  final dio = Dio();
  return dio;
}

@riverpod
NetworkInfo networkInfo(Ref ref) {
  final connectivity = Connectivity();
  return NetworkInfoImpl(connectivity);
}

@riverpod
class AuthStateNotifier extends _$AuthStateNotifier {
  @override
  bool build() {
    return false;
  }

  void setAuthState(bool value) {
    state = value;
  }
}

@riverpod
class FirstInitStateNotifier extends _$FirstInitStateNotifier {
  @override
  bool build() {
    return true;
  }

  void setFirstInitState(bool value) {
    state = value;
  }
}

@Riverpod(keepAlive: true)
Future<void> startUp(Ref ref) async {
  final realmDb = ref.watch(realmProvider);
  final appConfig = realmDb.all<AppConfig>().firstOrNull;
  final accessToken = appConfig?.accessToken;

  if (accessToken != null && accessToken.isNotEmpty) {
    ref.read(authStateNotifierProvider.notifier).setAuthState(true);
  }
}
