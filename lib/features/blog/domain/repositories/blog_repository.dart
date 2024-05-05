import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:fyp/core/error/failure.dart';
import 'package:fyp/features/blog/data/model/blog_model.dart';

abstract interface class BlogRepository{
  Future<Either<Failure,BlogModel>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
    required String userName,

  });
    Future<Either<Failure,List<BlogModel>>> getallblogs();

}