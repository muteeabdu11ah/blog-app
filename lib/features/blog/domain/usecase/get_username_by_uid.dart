import 'package:fpdart/fpdart.dart';
import 'package:fyp/core/error/failure.dart';
import 'package:fyp/core/usecase/usecase.dart';
import 'package:fyp/features/auth/domain/usecases/current_user.dart';
import 'package:fyp/features/blog/domain/repositories/blog_repository.dart';

class GetUserNameByUid implements usecase<String,NoParams>{

  final BlogRepository blogRepository;

  GetUserNameByUid(this.blogRepository);
  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    return await blogRepository.getUserName();
  
  
  }
}