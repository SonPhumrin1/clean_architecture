import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/core/util/logger.dart';
import 'package:clean_architecture/feature/posts/presentation/providers/posts_providers.dart';
import 'package:dartz/dartz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/post_entity.dart';
import '../../../../core/usecases/usecase.dart';

part 'posts_provider.g.dart';

@riverpod
class PostsNotifier extends _$PostsNotifier {
  @override
  FutureOr<List<PostEntity>> build() {
    return _fetchPosts();
  }

  Future<List<PostEntity>> _fetchPosts() async {
    final getPostsUseCase = ref.read(getPostsUseCaseProvider);
    final result = await getPostsUseCase(NoParams());

    return result.fold(
      (failure) {
        Logs.e('Error fetching posts: $failure');
        throw failure;
      },
      (posts) => posts,
    );
  }

  Future<void> refreshPosts() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchPosts());
  }

  Future<PostEntity> getPost(int id) async {
    final getPostUseCase = ref.read(getPostUseCaseProvider);
    final result = await getPostUseCase(id);

    return result.fold(
      (failure) {
        Logs.e('Error fetching posts: $failure');
        throw failure;
      },
      (post) => post,
    );
  }

  Future<Either<Failure, PostEntity>> createPost(PostEntity post) async {
    final createPostUseCase = ref.read(createPostUseCaseProvider);
    state = const AsyncValue.loading(); // Optional: Show loading while creating

    final result = await createPostUseCase(post);

    result.fold(
      (failure) {
        Logs.e('Error creating post: $failure');
        state = AsyncValue.error(failure, StackTrace.current);
      },
      (newPost) {
        state.whenData((posts) {
          state = AsyncValue.data([...posts, newPost]);
        });
      },
    );

    return result;
  }

  Future<Either<Failure, PostEntity>> updatePost(PostEntity post) async {
    final updatePostUseCase = ref.read(updatePostUseCaseProvider);
    state = const AsyncValue.loading(); // Optional: Show loading

    final result = await updatePostUseCase(post);

    result.fold(
      (failure) {
        Logs.e('Error updating post: $failure');
        state = AsyncValue.error(failure, StackTrace.current);
      },
      (updatedPost) {
        state.whenData((posts) {
          final updatedList = posts
              .map((p) => p.id == updatedPost.id ? updatedPost : p)
              .toList();
          state = AsyncValue.data(updatedList);
        });
      },
    );
    await refreshPosts();

    return result;
  }

  Future<Either<Failure, void>> deletePost(int postId) async {
    final deletePostUseCase = ref.read(deletePostUseCaseProvider);
    state = const AsyncValue.loading(); // Optional: Show loading

    final result = await deletePostUseCase(postId);

    result.fold(
      (failure) {
        Logs.e('Error deleting post: $failure');
        state = AsyncValue.error(failure, StackTrace.current);
      },
      (_) {
        state.whenData((posts) {
          final updatedList = posts.where((p) => p.id != postId).toList();
          state = AsyncValue.data(updatedList);
        });
      },
    );
    await refreshPosts();

    return result;
  }

  Future<void> syncPosts(List<PostEntity> posts) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final syncPostsUseCase = ref.read(syncPostsUseCaseProvider);
      final result = await syncPostsUseCase(posts);

      return result.fold(
        (failure) {
          Logs.e('Error syncing posts: $failure');
          throw failure;
        },
        (syncedPosts) {
          state = AsyncValue.data(syncedPosts);
          return syncedPosts;
        },
      );
    });
  }
}
