import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/calculate_reading_time.dart';
import 'package:blog_app/core/utils/format_date.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:flutter/material.dart';

class BlogViewerPage extends StatelessWidget {
  static route(Blog blog) => MaterialPageRoute(
        builder: (context) => BlogViewerPage(
          blog: blog,
        ),
      );
  final Blog blog;

  const BlogViewerPage({
    super.key,
    required this.blog,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blog.title,
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "By ${blog.posterName}",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '${formateDateByDMMMYYYY(blog.updatedAt)} ${calculateReadingTime(blog.content)} min',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppPallete.greyColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    blog.imageUrl,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  blog.content,
                  style: TextStyle(
                    fontSize: 16,
                    height: 2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
