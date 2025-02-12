import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_respository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllBlogs implements Usecase<List<Blog>, NoParams> {
  final BlogRespository blogRespository;

  GetAllBlogs(this.blogRespository);

  @override
  Future<Either<Failure, List<Blog>>> call(NoParams params) async {
    return await blogRespository.getAllBlogs();
  }
}
