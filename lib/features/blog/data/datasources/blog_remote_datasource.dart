import 'dart:io';

import 'package:fyp/core/error/exceptions.dart';
import 'package:fyp/features/blog/data/model/blog_model.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDataSource{
  Future<BlogModel> uploadBlog(BlogModel blog);
  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blog,
  });

}


class BlogRemoteDataSourceImpl implements BlogRemoteDataSource{
  final SupabaseClient supabaseclient;

  BlogRemoteDataSourceImpl(this.supabaseclient);
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {
     final blogdata = await supabaseclient.from('blogs').insert(blog.toJson()).select();
return BlogModel.fromJson(blogdata.first);
    } catch (e) {
          throw ServerException(e.toString());

    }
  }
  
  @override
  Future<String> uploadBlogImage({required File image, required BlogModel blog,})async {

   try {
     await supabaseclient.storage.from('blog_images').upload(blog.id, image);

     return supabaseclient.storage.from('blog_images').getPublicUrl(blog.id);
   } catch (e) {
     throw ServerException(e.toString());
   }
  }
  
}