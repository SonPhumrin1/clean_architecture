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

  Future<void> login() async {
    state = const AsyncLoading();
    try {
      await Future.delayed(const Duration(seconds: 5));

      state = const AsyncData(true);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> logout() async {
    state = const AsyncLoading();
    try {
      await Future.delayed(const Duration(seconds: 5));

      state = const AsyncData(false);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
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
    ref.read(authStateProvider.notifier).login();
  }
}
