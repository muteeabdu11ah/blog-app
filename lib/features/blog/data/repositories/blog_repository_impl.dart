import 'dart:io';
import 'dart:ui';

import 'package:fpdart/fpdart.dart';
import 'package:fyp/core/error/exceptions.dart';
import 'package:fyp/core/error/failure.dart';
import 'package:fyp/features/blog/data/datasources/blog_remote_datasource.dart';
import 'package:fyp/features/blog/data/model/blog_model.dart';
import 'package:fyp/features/blog/domain/repositories/blog_repository.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;

  BlogRepositoryImpl(this.blogRemoteDataSource);
  
  @override
  Future<Either<Failure, BlogModel>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
    required String userName,
  }) async {
    try {
  BlogModel blogModel = BlogModel(id:const Uuid().v4(), posterId: posterId, title: title, content: content, imageURL: '', topics: topics, updatedAt: DateTime.now(), userName: userName,);
 final url =  await blogRemoteDataSource.uploadBlogImage(image: image, blog: blogModel);
 blogModel = blogModel.copyWith(imageURL: url);
 final res = await blogRemoteDataSource.uploadBlog(blogModel);

 return right(res);
} on ServerException catch (e) {
return left(Failure(e.message));
}
  }

}
