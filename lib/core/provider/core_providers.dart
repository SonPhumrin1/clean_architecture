import 'package:clean_architecture/core/local/realm_config.dart';
import 'package:clean_architecture/core/model/app_config_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'core_providers.g.dart';

@Riverpod(keepAlive: true)
class AuthState extends _$AuthState {
  @override
  FutureOr<bool> build() async {
    await Future.delayed(const Duration(seconds: 5));

    return true;
  }

  void setAuthState(bool value) {
    state = AsyncData(value);
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

@riverpod
Future<void> startUp(Ref ref) async {
  final realmDb = ref.watch(realmConfigProvider);
  final appConfig = realmDb.realm.all<AppConfig>().firstOrNull;
  final accessToken = appConfig?.accessToken;

  if (accessToken != null && accessToken.isNotEmpty) {
    ref.read(authStateProvider.notifier).setAuthState(true);
  } else {
    ref.read(authStateProvider.notifier).setAuthState(false);
  }
}
