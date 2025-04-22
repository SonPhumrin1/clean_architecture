// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'core_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$realmHash() => r'5e5a4f1cefe0ce7d7cb018c2152009a979b5a51b';

/// See also [realm].
@ProviderFor(realm)
final realmProvider = Provider<Realm>.internal(
  realm,
  name: r'realmProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$realmHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RealmRef = ProviderRef<Realm>;
String _$dioHash() => r'752e988f9490880f64bef088652cc7723ff31e0b';

/// See also [dio].
@ProviderFor(dio)
final dioProvider = AutoDisposeProvider<Dio>.internal(
  dio,
  name: r'dioProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$dioHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DioRef = AutoDisposeProviderRef<Dio>;
String _$networkInfoHash() => r'c36d599ff7bfed4dc812e38ff10e9137f8503c00';

/// See also [networkInfo].
@ProviderFor(networkInfo)
final networkInfoProvider = AutoDisposeProvider<NetworkInfo>.internal(
  networkInfo,
  name: r'networkInfoProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$networkInfoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NetworkInfoRef = AutoDisposeProviderRef<NetworkInfo>;
String _$startUpHash() => r'd103c7fbb075ecd3a5245310f7a37dac0d784cc3';

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
