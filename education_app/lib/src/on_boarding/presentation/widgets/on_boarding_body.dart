import 'package:education_app/core/extensions/context_extension.dart';
import 'package:education_app/core/res/colors.dart';
import 'package:education_app/core/res/fonts.dart';
import 'package:education_app/src/on_boarding/domain/entities/page_content.dart';
import 'package:education_app/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnBoardingBody extends StatelessWidget {
  const OnBoardingBody({required this.pageContent, super.key});

  final PageContent pageContent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          pageContent.image,
          height: context.height * 0.45,
          fit: BoxFit.cover,
        ),
        SizedBox(height: context.height * 0.03),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            children: [
              Text(
                pageContent.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 40,
                  fontFamily: Fonts.aeonik,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: context.height * 0.025),
              Text(
                pageContent.description,
                style: const TextStyle(
                  fontSize: 25,
                  fontFamily: Fonts.aeonik,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: context.height * 0.025,
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<OnBoardingCubit>().cacheFirstTimer();
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 17),
                  backgroundColor: Colours.primaryColor,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Get Started'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
