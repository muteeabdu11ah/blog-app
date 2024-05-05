part of 'blog_bloc.dart';

@immutable
sealed class BlogState {}

final class BlogInitial extends BlogState {}

final class BlogLoading extends BlogState {}
final class BlogSucess extends BlogState {}
final class BlogUploadSucess extends BlogState {

}
final class BlogDisplaySucess extends BlogState {
 final List<Blog> blogs;

  BlogDisplaySucess(this.blogs);

}

final class BlogFailure extends BlogState {
  final String error;

  BlogFailure({required this.error});
}
