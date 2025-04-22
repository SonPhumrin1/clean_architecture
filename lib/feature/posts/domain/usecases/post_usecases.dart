import 'package:clean_architecture/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/post_entity.dart';
import '../repositories/post_repository.dart';

class GetPosts implements UseCase<List<PostEntity>, NoParams> {
  final PostRepository repository;

  GetPosts(this.repository);

  @override
  Future<Either<Failure, List<PostEntity>>> call(NoParams params) async {
    return await repository.getPosts();
  }
}

class GetPost implements UseCase<PostEntity, int> {
  final PostRepository repository;

  GetPost(this.repository);

  @override
  Future<Either<Failure, PostEntity>> call(int params) async {
    return await repository.getPost(params);
  }
}

class CreatePost implements UseCase<PostEntity, PostEntity> {
  final PostRepository repository;

  CreatePost(this.repository);

  @override
  Future<Either<Failure, PostEntity>> call(PostEntity params) async {
    return await repository.createPost(params);
  }
}

class UpdatePost implements UseCase<PostEntity, PostEntity> {
  final PostRepository repository;

  UpdatePost(this.repository);

  @override
  Future<Either<Failure, PostEntity>> call(PostEntity params) async {
    return await repository.updatePost(params);
  }
}

class DeletePost implements UseCase<void, int> {
  final PostRepository repository;

  DeletePost(this.repository);

  @override
  Future<Either<Failure, void>> call(int params) async {
    return await repository.deletePost(params);
  }
}

class SyncPosts implements UseCase<List<PostEntity>, List<PostEntity>> {
  final PostRepository repository;

  SyncPosts(this.repository);

  @override
  Future<Either<Failure, List<PostEntity>>> call(
      List<PostEntity> params) async {
    return await repository.syncPosts(params);
  }
}
