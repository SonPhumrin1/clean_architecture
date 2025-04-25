import 'package:clean_architecture/core/local/realm_config.dart';
import 'package:clean_architecture/core/model/app_config_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'core_providers.g.dart';

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
  final realmDb = ref.watch(realmConfigProvider);
  final appConfig = realmDb.realm.all<AppConfig>().firstOrNull;
  final accessToken = appConfig?.accessToken;

  if (accessToken != null && accessToken.isNotEmpty) {
    ref.read(authStateNotifierProvider.notifier).setAuthState(true);
  }
}
