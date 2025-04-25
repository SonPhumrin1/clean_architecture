// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'core_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$startUpHash() => r'22d3149633dc830616d1237a3fa4af8bb8dbe940';

/// See also [startUp].
@ProviderFor(startUp)
final startUpProvider = FutureProvider<void>.internal(
  startUp,
  name: r'startUpProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$startUpHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef StartUpRef = FutureProviderRef<void>;
String _$authStateNotifierHash() => r'e9481a8e92ce5a72e34bd99fdf686667bd125c4c';

/// See also [AuthStateNotifier].
@ProviderFor(AuthStateNotifier)
final authStateNotifierProvider =
    AutoDisposeNotifierProvider<AuthStateNotifier, bool>.internal(
  AuthStateNotifier.new,
  name: r'authStateNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authStateNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AuthStateNotifier = AutoDisposeNotifier<bool>;
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
