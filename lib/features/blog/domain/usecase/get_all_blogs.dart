import 'package:fpdart/fpdart.dart';
import 'package:fyp/core/error/exceptions.dart';
import 'package:fyp/core/error/failure.dart';
import 'package:fyp/core/usecase/usecase.dart';
import 'package:fyp/features/auth/domain/usecases/current_user.dart';
import 'package:fyp/features/blog/domain/entity/blog.dart';
import 'package:fyp/features/blog/domain/repositories/blog_repository.dart';

class getAllBlogs implements usecase<List<Blog>,NoParams>{

  final BlogRepository blogRepository;

  getAllBlogs(this.blogRepository);
  @override
  Future<Either<Failure, List<Blog>>> call(NoParams params) async {
    return await blogRepository.getallblogs();
  
  
  }

}