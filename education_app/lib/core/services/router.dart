import 'package:education_app/core/common/views/page_under_construction.dart';
import 'package:education_app/core/services/injection_container.dart';
import 'package:education_app/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:education_app/src/on_boarding/presentation/views/on_boarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case OnBoardingScreen.routeName:
      return _pageBuilder(
        (context) {
          return BlocProvider(
            create: (context) => sl<OnBoardingCubit>(),
            child: const OnBoardingScreen(),
          );
        },
        settings: settings,
      );
    default:
      return _pageBuilder(
        (context) => const PageUnderConstruction(),
        settings: settings,
      );
  }
}

PageRouteBuilder<dynamic> _pageBuilder(
  Widget Function(BuildContext) page, {
  required RouteSettings settings,
}) {
  return PageRouteBuilder(
    pageBuilder: (context, _, __) => page(context),
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(
      opacity: animation,
      child: child,
    ),
    settings: settings,
  );
}
