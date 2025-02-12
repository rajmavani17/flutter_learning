part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

final class BlogUploadRequested extends BlogEvent {
  final String posterId;
  final String title;
  final String content;
  final File image;
  final List<String> topics;

  BlogUploadRequested({
    required this.posterId,
    required this.title,
    required this.content,
    required this.image,
    required this.topics,
  });
}

final class BlogFetchedAllBlogs extends BlogEvent {}
