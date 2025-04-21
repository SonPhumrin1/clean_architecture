import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/core/usecases/usecase.dart';
import 'package:clean_architecture/feature/posts/domain/entities/post_entity.dart';
import 'package:clean_architecture/feature/posts/domain/repositories/post_repository.dart';
import 'package:clean_architecture/feature/posts/domain/usecases/get_posts.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

// Generate mocks
@GenerateMocks([PostRepository])
import 'get_posts_test.mocks.mocks.dart';

void main() {
  late GetPosts usecase;
  late MockPostRepository mockPostRepository;

  setUp(() {
    mockPostRepository = MockPostRepository();
    usecase = GetPosts(mockPostRepository);
  });

  final tPosts = [
    const PostEntity(
        id: 1, userId: 1, title: 'Test Title 1', body: 'Test Body 1'),
    const PostEntity(
        id: 2, userId: 1, title: 'Test Title 2', body: 'Test Body 2'),
  ];

  test('should get list of posts from the repository', () async {
    // Arrange
    when(mockPostRepository.getPosts()).thenAnswer((_) async => Right(tPosts));

    // Act
    final result = await usecase(NoParams());

    // Assert
    expect(result, Right(tPosts));
    verify(mockPostRepository.getPosts());
    verifyNoMoreInteractions(mockPostRepository);
  });

  test('should return a failure from the repository', () async {
    // Arrange
    when(mockPostRepository.getPosts())
        .thenAnswer((_) async => Left(ServerFailure(message: 'Server Error')));

    // Act
    final result = await usecase(NoParams());

    // Assert
    expect(result, Left(ServerFailure(message: 'Server Error')));
    verify(mockPostRepository.getPosts());
    verifyNoMoreInteractions(mockPostRepository);
  });
}
