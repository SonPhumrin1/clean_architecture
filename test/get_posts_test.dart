import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/core/usecases/usecase.dart';
import 'package:clean_architecture/core/util/logger.dart';
import 'package:clean_architecture/feature/posts/domain/entities/post_entity.dart';
import 'package:clean_architecture/feature/posts/domain/repositories/post_repository.dart';
import 'package:clean_architecture/feature/posts/domain/usecases/post_usecases.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'get_posts_test.mocks.dart';

@GenerateMocks([PostRepository])
void main() {
  late GetPosts usecaseGetPosts;
  late DeletePost usecaseDeletePost;
  late GetPost usecaseGetPost;
  late CreatePost usecaseCreatePost;
  late UpdatePost usecaseUpdatePost;
  late MockPostRepository mockPostRepository;

  setUp(() {
    mockPostRepository = MockPostRepository();
    usecaseGetPosts = GetPosts(mockPostRepository);
    usecaseDeletePost = DeletePost(mockPostRepository);
    usecaseGetPost = GetPost(mockPostRepository);
    usecaseCreatePost = CreatePost(mockPostRepository);
    usecaseUpdatePost = UpdatePost(mockPostRepository);
  });

  final tPosts = [
    const PostEntity(
        id: "123456", title: 'Test Title 1', content: 'Test Body 1'),
    const PostEntity(
        id: "123789", title: 'Test Title 2', content: 'Test Body 2'),
  ];
  const tPostId = '123456';
  const tPost = PostEntity(
    id: tPostId,
    title: 'Test Title',
    content: 'Test Body',
  );
  final tFailure = ServerFailure(message: 'Server Error');

  group('GetPosts UseCase', () {
    test('should get list of posts from the repository', () async {
      when(mockPostRepository.getPosts())
          .thenAnswer((_) async => Right(tPosts));

      final result = await usecaseGetPosts(NoParams());

      Logs.t('GetPosts Success result: $result');
      expect(result, Right(tPosts));
      verify(mockPostRepository.getPosts());
      verifyNoMoreInteractions(mockPostRepository);
    });

    test('should return a failure when getting posts fails', () async {
      when(mockPostRepository.getPosts())
          .thenAnswer((_) async => Left(tFailure));

      final result = await usecaseGetPosts(NoParams());

      Logs.e('GetPosts Failure result: $result');
      expect(result, Left(tFailure));
      verify(mockPostRepository.getPosts());
      verifyNoMoreInteractions(mockPostRepository);
    });
  });

  group('GetPost UseCase', () {
    test('should get a single post from the repository', () async {
      when(mockPostRepository.getPostById(tPostId))
          .thenAnswer((_) async => const Right(tPost));

      final result = await usecaseGetPost(tPostId);

      Logs.t('GetPost Success result: $result');
      expect(result, const Right(tPost));
      verify(mockPostRepository.getPostById(tPostId));
      verifyNoMoreInteractions(mockPostRepository);
    });

    test('should return a failure when getting a single post fails', () async {
      when(mockPostRepository.getPostById(tPostId))
          .thenAnswer((_) async => Left(tFailure));

      final result = await usecaseGetPost(tPostId);

      Logs.e('GetPost Failure result: $result');
      expect(result, Left(tFailure));
      verify(mockPostRepository.getPostById(tPostId));
      verifyNoMoreInteractions(mockPostRepository);
    });
  });

  group('CreatePost UseCase', () {
    test('should create a post in the repository', () async {
      when(mockPostRepository.createPost(tPost))
          .thenAnswer((_) async => const Right(tPost));

      final result = await usecaseCreatePost(tPost);

      Logs.t('CreatePost Success result: $result');
      expect(result, const Right(tPost));
      verify(mockPostRepository.createPost(tPost));
      verifyNoMoreInteractions(mockPostRepository);
    });

    test('should return a failure when creating a post fails', () async {
      when(mockPostRepository.createPost(tPost))
          .thenAnswer((_) async => Left(tFailure));

      final result = await usecaseCreatePost(tPost);

      Logs.e('CreatePost Failure result: $result');
      expect(result, Left(tFailure));
      verify(mockPostRepository.createPost(tPost));
      verifyNoMoreInteractions(mockPostRepository);
    });
  });

  group('UpdatePost UseCase', () {
    test('should update a post in the repository', () async {
      when(mockPostRepository.updatePost(tPost))
          .thenAnswer((_) async => const Right(tPost));

      final result = await usecaseUpdatePost(tPost);

      Logs.t('UpdatePost Success result: $result');
      expect(result, const Right(tPost));
      verify(mockPostRepository.updatePost(tPost));
      verifyNoMoreInteractions(mockPostRepository);
    });

    test('should return a failure when updating a post fails', () async {
      when(mockPostRepository.updatePost(tPost))
          .thenAnswer((_) async => Left(tFailure));

      final result = await usecaseUpdatePost(tPost);

      Logs.e('UpdatePost Failure result: $result');
      expect(result, Left(tFailure));
      verify(mockPostRepository.updatePost(tPost));
      verifyNoMoreInteractions(mockPostRepository);
    });
  });

  group('DeletePost UseCase', () {
    test('should delete a post from the repository', () async {
      when(mockPostRepository.deletePost(tPostId))
          .thenAnswer((_) async => const Right(true));

      final result = await usecaseDeletePost(tPostId);

      Logs.t('DeletePost Success result: $result');
      expect(result, const Right(true));
      verify(mockPostRepository.deletePost(tPostId));
      verifyNoMoreInteractions(mockPostRepository);
    });

    test('should return a failure when deleting a post fails', () async {
      when(mockPostRepository.deletePost(tPostId))
          .thenAnswer((_) async => Left(tFailure));

      final result = await usecaseDeletePost(tPostId);

      Logs.e('DeletePost Failure result: $result');
      expect(result, Left(tFailure));
      verify(mockPostRepository.deletePost(tPostId));
      verifyNoMoreInteractions(mockPostRepository);
    });
  });
}
