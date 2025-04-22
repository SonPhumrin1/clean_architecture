import 'dart:async';
import 'package:clean_architecture/core/util/logger.dart';
import 'package:clean_architecture/feature/login/presentation/pages/login_page.dart';
import 'package:clean_architecture/feature/posts/presentation/pages/create_post_page.dart';
import 'package:clean_architecture/feature/posts/presentation/pages/post_detail_page.dart';
import 'package:clean_architecture/feature/posts/presentation/pages/posts_page.dart';
import 'package:clean_architecture/feature/startup/presentation/pages/startup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

@TypedGoRoute<SplashRoute>(path: '/splash')
class SplashRoute extends GoRouteData {
  const SplashRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const StartupPage();
  }
}

@TypedGoRoute<LoginRoute>(path: '/login')
class LoginRoute extends GoRouteData {
  const LoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LoginPage();
  }
}

@TypedGoRoute<PostsRoute>(path: '/posts')
class PostsRoute extends GoRouteData {
  const PostsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const PostsPage();
  }
}

@TypedGoRoute<PostDetailRoute>(path: '/post/:postId')
class PostDetailRoute extends GoRouteData {
  const PostDetailRoute({required this.postId});

  final String postId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PostDetailPage(postId: int.parse(postId));
  }
}

@TypedGoRoute<CreatePostRoute>(path: '/create-post')
class CreatePostRoute extends GoRouteData {
  const CreatePostRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CreatePostPage();
  }
}

@riverpod
GoRouter goRouter(Ref ref) {
  final authState = ref.watch(authStateProvider);
  return GoRouter(
    routes: $appRoutes,
    initialLocation: const SplashRoute().location,
    errorBuilder: (context, state) => const Scaffold(
      body: Center(
        child: Text('Page not found!'),
      ),
    ),
    redirect: (BuildContext context, GoRouterState state) {
      final currentLocation = state.matchedLocation;

      final isLoggingIn = currentLocation == const LoginRoute().location;
      final isSplashing = currentLocation == const SplashRoute().location;

      if (authState.isLoading && !authState.hasValue) {
        Logs.e('Splash');
        return isSplashing ? null : const SplashRoute().location;
      }

      if (authState.hasError) {
        Logs.e('Login');
        return isLoggingIn ? null : const LoginRoute().location;
      }

      if (authState.hasValue) {
        final isAuthenticated = authState.value!;

        if (isAuthenticated) {
          if (isLoggingIn || isSplashing) {
            Logs.e('Login');
            return const PostsRoute().location;
          }

          return null;
        } else {
          if (!isLoggingIn) {
            return const LoginRoute().location;
          }

          return null;
        }
      }

      return isSplashing ? null : const SplashRoute().location;
    },
  );
}

@Riverpod(keepAlive: true)
class AuthState extends _$AuthState {
  @override
  FutureOr<bool> build() async {
    await Future.delayed(const Duration(seconds: 5));

    return false;
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
