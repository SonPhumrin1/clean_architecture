import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/post_entity.dart';

abstract class PostRepository {
  Future<Either<Failure, List<PostEntity>>> getPosts();
  Future<Either<Failure, PostEntity>> getPost(int id);
  Future<Either<Failure, PostEntity>> createPost(PostEntity post);
  Future<Either<Failure, PostEntity>> updatePost(PostEntity post);
  Future<Either<Failure, void>> deletePost(int id);
  Future<Either<Failure, List<PostEntity>>> syncPosts(List<PostEntity> posts);
}
