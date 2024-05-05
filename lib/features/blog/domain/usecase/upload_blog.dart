import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:fyp/core/error/failure.dart';
import 'package:fyp/core/usecase/usecase.dart';
import 'package:fyp/features/blog/domain/entity/blog.dart';
import 'package:fyp/features/blog/domain/repositories/blog_repository.dart';

class UploadBlog implements usecase<Blog, UploadBlogParams> {
  final BlogRepository blogRepository;

  UploadBlog(this.blogRepository);
  @override
  Future<Either<Failure, Blog>> call(UploadBlogParams params) async {
    return await blogRepository.uploadBlog(
      image: params.image,
      title: params.title,
      content: params.content,
      posterId: params.posterId,
      topics: params.topics,
      userName: params.userName,
    );
  }
}

class UploadBlogParams {
  final String posterId;
  final String title;
  final String content;
  final String userName;
  final List<String> topics;
  final File image;

  UploadBlogParams(
      {required this.posterId,
      required this.title,
      required this.content,
      required this.userName,
      required this.topics,
      required this.image});
}
