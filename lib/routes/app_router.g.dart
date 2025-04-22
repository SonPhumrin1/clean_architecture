// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $splashRoute,
      $loginRoute,
      $postsRoute,
      $postDetailRoute,
      $createPostRoute,
    ];

RouteBase get $splashRoute => GoRouteData.$route(
      path: '/splash',
      factory: $SplashRouteExtension._fromState,
    );

extension $SplashRouteExtension on SplashRoute {
  static SplashRoute _fromState(GoRouterState state) => const SplashRoute();

  String get location => GoRouteData.$location(
        '/splash',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $loginRoute => GoRouteData.$route(
      path: '/login',
      factory: $LoginRouteExtension._fromState,
    );

extension $LoginRouteExtension on LoginRoute {
  static LoginRoute _fromState(GoRouterState state) => const LoginRoute();

  String get location => GoRouteData.$location(
        '/login',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $postsRoute => GoRouteData.$route(
      path: '/posts',
      factory: $PostsRouteExtension._fromState,
    );

extension $PostsRouteExtension on PostsRoute {
  static PostsRoute _fromState(GoRouterState state) => const PostsRoute();

  String get location => GoRouteData.$location(
        '/posts',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $postDetailRoute => GoRouteData.$route(
      path: '/post/:postId',
      factory: $PostDetailRouteExtension._fromState,
    );

extension $PostDetailRouteExtension on PostDetailRoute {
  static PostDetailRoute _fromState(GoRouterState state) => PostDetailRoute(
        postId: state.pathParameters['postId']!,
      );

  String get location => GoRouteData.$location(
        '/post/${Uri.encodeComponent(postId)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $createPostRoute => GoRouteData.$route(
      path: '/create-post',
      factory: $CreatePostRouteExtension._fromState,
    );

extension $CreatePostRouteExtension on CreatePostRoute {
  static CreatePostRoute _fromState(GoRouterState state) =>
      const CreatePostRoute();

  String get location => GoRouteData.$location(
        '/create-post',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$goRouterHash() => r'1efac74fd5452c759fc4b800c3b9ac9c5e12223d';

/// See also [goRouter].
@ProviderFor(goRouter)
final goRouterProvider = AutoDisposeProvider<GoRouter>.internal(
  goRouter,
  name: r'goRouterProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$goRouterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GoRouterRef = AutoDisposeProviderRef<GoRouter>;
String _$authStateHash() => r'47ebe91354dbe0708ea8f8d1a22badb44cee6f75';

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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
