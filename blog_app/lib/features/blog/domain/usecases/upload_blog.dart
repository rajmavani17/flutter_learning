import 'dart:io';

import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_respository.dart';
import 'package:fpdart/fpdart.dart';

class UploadBlog implements Usecase<Blog, UploadBlogParams> {
  final BlogRespository blogRespository;

  UploadBlog(this.blogRespository);

  @override
  Future<Either<Failure, Blog>> call(UploadBlogParams params) async {
    return await blogRespository.uploadBlog(
      image: params.image,
      title: params.title,
      content: params.content,
      posterId: params.posterId,
      topics: params.topics,
    );
  }
}

final class UploadBlogParams {
  final String posterId;
  final String title;
  final String content;
  final File image;
  final List<String> topics;

  UploadBlogParams({
    required this.posterId,
    required this.title,
    required this.content,
    required this.image,
    required this.topics,
  });
}
