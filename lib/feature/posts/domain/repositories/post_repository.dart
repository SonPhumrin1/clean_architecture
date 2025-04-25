import 'package:clean_architecture/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../entities/post_entity.dart';

abstract class PostRepository {
  Future<Either<Failure, List<PostEntity>>> getPosts();
  Future<Either<Failure, PostEntity>> getPostById(String id);
  Future<Either<Failure, PostEntity>> createPost(PostEntity post);
  Future<Either<Failure, PostEntity>> updatePost(PostEntity post);
  Future<Either<Failure, bool>> deletePost(String id);
}
