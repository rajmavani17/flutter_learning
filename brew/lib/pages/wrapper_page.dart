import 'package:brew/models/user_model.dart';
import 'package:brew/pages/authenticate/authenticate_page.dart';
import 'package:brew/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WrapperPage extends StatelessWidget {
  const WrapperPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    print("Wrapper page => $user");

    Widget getPage() {
      if (user == null)
        return AuthenticatePage();
      else
        return HomePage();
    }

    return getPage();
  }
}
