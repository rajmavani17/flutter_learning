import 'dart:io';

import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/pick_image.dart' as pi;
import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_page.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewBlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => AddNewBlogPage(),
      );
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final List<String> topicList = [
    'Business',
    'Technology',
    'Entertainment',
    'Sports',
    'International'
  ];
  List<String> selectedTopics = [];

  final titleController = TextEditingController();
  final contentController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  File? image;

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  void selectImage() async {
    final selectedImage = await pi.pickImage();
    if (selectedImage != null) {
      setState(() {
        image = selectedImage;
      });
    }
  }

  void validateAndUploadBlog() {
    if (formKey.currentState!.validate() &&
        selectedTopics.isNotEmpty &&
        image != null) {
      final posterId =
          (context.read<AppUserCubit>().state as AppUserLoggedIn).user.id;
      context.read<BlogBloc>().add(
            BlogUploadRequested(
              posterId: posterId,
              title: titleController.text.trim(),
              content: contentController.text.trim(),
              image: image!,
              topics: selectedTopics,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.done_outlined),
            onPressed: validateAndUploadBlog,
          ),
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showSnackBar(context, state.error);
          } else if (state is BlogUploadSuccess) {
            Navigator.pushAndRemoveUntil(
              context,
              BlogPage.route(),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return Loader();
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    image != null
                        ? GestureDetector(
                            onTap: selectImage,
                            child: SizedBox(
                              height: 200,
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(image!),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              selectImage();
                            },
                            child: DottedBorder(
                              color: AppPallete.borderColor,
                              dashPattern: [15, 4],
                              radius: Radius.circular(10),
                              borderType: BorderType.RRect,
                              strokeCap: StrokeCap.round,
                              child: Container(
                                height: 150,
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.folder_open_outlined,
                                      size: 50,
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      "Select an Image",
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: topicList.length,
                        itemBuilder: (context, index) {
                          final topic = topicList[index];
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: GestureDetector(
                              onTap: () {
                                if (selectedTopics.contains(topic)) {
                                  selectedTopics.remove(topic);
                                } else {
                                  selectedTopics.add(topicList[index]);
                                }
                                setState(() {});
                              },
                              child: Chip(
                                color: selectedTopics.contains(topic)
                                    ? WidgetStatePropertyAll(
                                        AppPallete.gradient1,
                                      )
                                    : null,
                                label: Text(
                                  topicList[index],
                                ),
                                side: selectedTopics.contains(topic)
                                    ? null
                                    : BorderSide(
                                        color: AppPallete.borderColor,
                                      ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    BlogEditor(controller: titleController, hintText: 'Title'),
                    SizedBox(
                      height: 10,
                    ),
                    BlogEditor(
                        controller: contentController, hintText: 'Content'),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
