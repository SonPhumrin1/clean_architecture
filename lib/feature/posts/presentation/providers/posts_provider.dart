import 'package:clean_architecture/core/util/logger.dart';
import 'package:clean_architecture/feature/posts/presentation/providers/posts_providers.dart';
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

  Future<PostEntity> getPost(String id) async {
    final getPostUseCase = ref.read(getPostUseCaseProvider);
    final result = await getPostUseCase(id);

    return result.fold(
      (failure) {
        Logs.e('Error fetching post $id: $failure');
        throw failure;
      },
      (post) => post,
    );
  }

  Future<void> createPost(PostEntity post) async {
    final AsyncValue<List<PostEntity>> previousState = state;

    state = const AsyncValue<List<PostEntity>>.loading()
        .copyWithPrevious(previousState);

    final createPostUseCase = ref.read(createPostUseCaseProvider);

    try {
      final result = await createPostUseCase(post);

      result.fold(
        (failure) {
          Logs.e('Error creating post: $failure');

          state = AsyncError<List<PostEntity>>(failure, StackTrace.current)
              .copyWithPrevious(previousState);
        },
        (newPost) {
          final List<PostEntity> currentPosts =
              previousState.valueOrNull ?? <PostEntity>[];
          final List<PostEntity> updatedPosts = [...currentPosts, newPost];
          state = AsyncValue<List<PostEntity>>.data(updatedPosts);
        },
      );
    } catch (e, st) {
      Logs.e('Unexpected error creating post: $e');

      state =
          AsyncError<List<PostEntity>>(e, st).copyWithPrevious(previousState);
    }
  }

  Future<void> updatePost(PostEntity post) async {
    final AsyncValue<List<PostEntity>> previousState = state;
    state = const AsyncValue<List<PostEntity>>.loading()
        .copyWithPrevious(previousState);

    final updatePostUseCase = ref.read(updatePostUseCaseProvider);

    try {
      final result = await updatePostUseCase(post);

      result.fold(
        (failure) {
          Logs.e('Error updating post: $failure');

          state = AsyncError<List<PostEntity>>(failure, StackTrace.current)
              .copyWithPrevious(previousState);
        },
        (updatedPost) {
          final List<PostEntity> currentPosts =
              previousState.valueOrNull ?? <PostEntity>[];
          final List<PostEntity> updatedList = currentPosts
              .map((p) => p.id == updatedPost.id ? updatedPost : p)
              .toList();
          state = AsyncValue<List<PostEntity>>.data(updatedList);
        },
      );
    } catch (e, st) {
      Logs.e('Unexpected error updating post: $e');

      state =
          AsyncError<List<PostEntity>>(e, st).copyWithPrevious(previousState);
    }
  }

  Future<void> deletePost(String postId) async {
    final AsyncValue<List<PostEntity>> previousState = state;
    state = const AsyncValue<List<PostEntity>>.loading()
        .copyWithPrevious(previousState);

    final deletePostUseCase = ref.read(deletePostUseCaseProvider);

    try {
      final result = await deletePostUseCase(postId);

      result.fold(
        (failure) {
          Logs.e('Error deleting post: $failure');

          state = AsyncError<List<PostEntity>>(failure, StackTrace.current)
              .copyWithPrevious(previousState);
        },
        (_) {
          final List<PostEntity> currentPosts =
              previousState.valueOrNull ?? <PostEntity>[];
          final List<PostEntity> updatedList =
              currentPosts.where((p) => p.id != postId).toList();
          state = AsyncValue<List<PostEntity>>.data(updatedList);
        },
      );
    } catch (e, st) {
      Logs.e('Unexpected error deleting post: $e');

      state =
          AsyncError<List<PostEntity>>(e, st).copyWithPrevious(previousState);
    }
  }
}
