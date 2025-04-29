// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'core_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$startUpHash() => r'adf267c21014680a89e2adcbc72d73c3b33fdf2a';

/// See also [startUp].
@ProviderFor(startUp)
final startUpProvider = AutoDisposeFutureProvider<void>.internal(
  startUp,
  name: r'startUpProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$startUpHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef StartUpRef = AutoDisposeFutureProviderRef<void>;
String _$authStateHash() => r'56147a4b0fbe147f09418a49041f420139acedc0';

/// See also [AuthState].
@ProviderFor(AuthState)
final authStateProvider = AsyncNotifierProvider<AuthState, bool>.internal(
  AuthState.new,
  name: r'authStateProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$authStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AuthState = AsyncNotifier<bool>;
String _$firstInitStateNotifierHash() =>
    r'e7d5794192758490d5153828e4b83f3a66315e1d';

/// See also [FirstInitStateNotifier].
@ProviderFor(FirstInitStateNotifier)
final firstInitStateNotifierProvider =
    AutoDisposeNotifierProvider<FirstInitStateNotifier, bool>.internal(
  FirstInitStateNotifier.new,
  name: r'firstInitStateNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$firstInitStateNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FirstInitStateNotifier = AutoDisposeNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
