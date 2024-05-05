import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:fyp/features/blog/domain/usecase/upload_blog.dart';
import 'package:meta/meta.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog uploadBlog;
  BlogBloc(this.uploadBlog) : super(BlogInitial()) {
    on<BlogEvent>((event, emit) {
      emit(BlogLoading());
    });

    on<BlogUploadevent>(_uploadBlogFun);
  }

  void _uploadBlogFun(BlogUploadevent event, Emitter<BlogState> emit) async {
    final res = await uploadBlog(UploadBlogParams(
      posterId: event.posterId,
      title: event.title,
      content: event.content,
      userName: event.userName,
      topics: event.topics,
      image: event.image,
    ));
    res.fold(
        (l) => emit(BlogFailure(error: l.message)), (r) => emit(BlogSucess()));
  }
}
