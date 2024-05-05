import 'package:fyp/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:fyp/core/secrets/app_secrets.dart';
import 'package:fyp/features/auth/data/datasources/auth_remote_data_sources.dart';
import 'package:fyp/features/auth/data/repositories/auth_repository_implementation.dart';
import 'package:fyp/features/auth/domain/repository/auth_repository.dart';
import 'package:fyp/features/auth/domain/usecases/current_user.dart';
import 'package:fyp/features/auth/domain/usecases/user_log_in.dart';
import 'package:fyp/features/auth/domain/usecases/user_sign_up.dart';
import 'package:fyp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fyp/features/blog/data/datasources/blog_remote_datasource.dart';
import 'package:fyp/features/blog/data/repositories/blog_repository_impl.dart';
import 'package:fyp/features/blog/domain/repositories/blog_repository.dart';
import 'package:fyp/features/blog/domain/usecase/get_all_blogs.dart';
import 'package:fyp/features/blog/domain/usecase/upload_blog.dart';
import 'package:fyp/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final servicelocator = GetIt.instance;

Future<void> initdependencies() async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
      url: AppSecrets.url, anonKey: AppSecrets.anonKey);

  servicelocator.registerLazySingleton(() => supabase.client);

  servicelocator.registerLazySingleton(() => AppUserCubit());
}

void _initBlog() {
  servicelocator
    ..registerFactory<BlogRemoteDataSource>(() => BlogRemoteDataSourceImpl(
          servicelocator(),
        ))
    ..registerFactory<BlogRepository>(() => BlogRepositoryImpl(
          servicelocator(),
        ))
    ..registerFactory(() => UploadBlog(
          servicelocator(),
        ))
    ..registerFactory(() => getAllBlogs(
          servicelocator(),
        ))
    ..registerLazySingleton(() => BlogBloc(
          uploadBlog: servicelocator(),
          get_all_blogs: servicelocator(),
        ));
}

void _initAuth() {
  servicelocator
    ..registerFactory<AuthRemoteDataource>(
      () => AuthRemoteDataourceImplementation(
        servicelocator(),
      ),
    )
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryiterface(
        servicelocator(),
      ),
    )
    ..registerFactory(
      () => UserSignUp(servicelocator()),
    )
    ..registerFactory(
      () => UserSignIn(servicelocator()),
    )
    ..registerFactory(() => CurrentUser(servicelocator()))
    ..registerLazySingleton(
      () => AuthBloc(
        usersignup: servicelocator(),
        userlogin: servicelocator(),
        currentuser: servicelocator(),
        appUserCubit: servicelocator(),
      ),
    );
}
