import 'package:brew/pages/authenticate/register_page.dart';
import 'package:brew/pages/authenticate/signin_page.dart';
import 'package:flutter/material.dart';

class AuthenticatePage extends StatefulWidget {
  const AuthenticatePage({super.key});

  @override
  State<AuthenticatePage> createState() => _AuthenticatePageState();
}

class _AuthenticatePageState extends State<AuthenticatePage> {
  bool showSignIn = true;

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: showSignIn ? SigninPage(toggleView: toggleView) : RegisterPage(toggleView: toggleView),
    );
  }
}
