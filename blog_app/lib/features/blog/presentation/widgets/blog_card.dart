import 'package:blog_app/core/utils/calculate_reading_time.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_viewer_page.dart';
import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;
  final Color color;
  const BlogCard({
    super.key,
    required this.blog,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          BlogViewerPage.route(
            blog,
          ),
        );
      },
      child: Container(
        height: 200,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: blog.topics.length,
                    itemBuilder: (context, index) {
                      final topic = blog.topics[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Chip(
                          label: Text(
                            topic,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Text(
                  blog.title,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Text('${calculateReadingTime(blog.content)} min'),
          ],
        ),
      ),
    );
  }
}
