import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => BlogPage());

  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(BlogFetchedAllBlogs());
  }

  Color getBackgroundColor(int index) {
    if (index % 3 == 0) {
      return const Color.fromARGB(255, 137, 75, 75);
    }
    if (index % 3 == 1) {
      return const Color.fromARGB(255, 79, 88, 146);
    }
    if (index % 3 == 2) {
      return const Color.fromARGB(255, 81, 144, 75);
    }
    return Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Bloggers Blog'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context, AddNewBlogPage.route());
              },
              icon: Icon(
                Icons.add_circle_outline_sharp,
              ),
            ),
          ],
        ),
        body: BlocConsumer<BlogBloc, BlogState>(
          listener: (context, state) {
            if (state is BlogFailure) {
              showSnackBar(context, state.error);
            }
          },
          builder: (context, state) {
            if (state is BlogLoading) {
              return Loader();
            }
            if (state is BlogDisplaySuccess) {
              return ListView.builder(
                itemCount: state.blogs.length,
                padding: EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  final blog = state.blogs[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: BlogCard(
                      blog: blog,
                      color: getBackgroundColor(index),
                    ),
                  );
                },
              );
            }
            return SizedBox();
          },
        ));
  }
}
