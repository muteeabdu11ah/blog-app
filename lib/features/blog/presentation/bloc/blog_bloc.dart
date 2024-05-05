import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:fyp/features/auth/domain/usecases/current_user.dart';
import 'package:fyp/features/blog/domain/entity/blog.dart';
import 'package:fyp/features/blog/domain/usecase/get_all_blogs.dart';
import 'package:fyp/features/blog/domain/usecase/upload_blog.dart';
import 'package:meta/meta.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final getAllBlogs _getallblogs;
  final UploadBlog _uploadBlog;
  BlogBloc({
    required UploadBlog uploadBlog,
    required getAllBlogs get_all_blogs,
  })  : _getallblogs = get_all_blogs,
        _uploadBlog = uploadBlog,
        super(BlogInitial()) {
    on<BlogEvent>((event, emit) {
      emit(BlogLoading());
    });

    on<BlogUploadevent>(_uploadBlogFun);
    on<bloggetallblogsevent>(_fetchBlocs);
  }

  void _fetchBlocs(bloggetallblogsevent event, Emitter<BlogState> state) async {
    final res = await _getallblogs(NoParams());
    res.fold((l) => emit(BlogFailure(error: l.message)),
        (r) => emit(BlogDisplaySucess(r)));
  }

  void _uploadBlogFun(BlogUploadevent event, Emitter<BlogState> emit) async {
    final res = await _uploadBlog(UploadBlogParams(
      posterId: event.posterId,
      title: event.title,
      content: event.content,
      userName: event.userName,
      topics: event.topics,
      image: event.image,
    ));
    res.fold((l) => emit(BlogFailure(error: l.message)),
        (r) => emit(BlogUploadSucess()));
  }
}
