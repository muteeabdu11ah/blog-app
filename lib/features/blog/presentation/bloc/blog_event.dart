part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

final class BlogUploadevent extends BlogEvent{
  final String posterId;
  final String title;
  final String content;
  final String userName;
  final List<String> topics;
  final File image;

  BlogUploadevent({required this.posterId, required this.title, required this.content, required this.userName, required this.topics, required this.image});

 
}