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

  Future<void> createPost(PostEntity post) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final createPostUseCase = ref.read(createPostUseCaseProvider);
      final result = await createPostUseCase(post);

      return result.fold(
        (failure) {
          Logs.e('Error creating post: $failure');
          throw failure;
        },
        (createdPost) {
          final updatedPosts = [...state.value ?? [], createdPost];
          state = AsyncValue.data(updatedPosts);
          return updatedPosts;
        },
      );
    });
  }
}
