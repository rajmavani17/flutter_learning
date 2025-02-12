import 'package:brew/models/brew_model.dart';
import 'package:brew/pages/home/brew_list.dart';
import 'package:brew/pages/home/setting_forms.dart';
import 'package:brew/services/auth_service.dart';
import 'package:brew/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    void showSettingPanels() {
      showModalBottomSheet(
        context: context,
        enableDrag: true,
        builder: (context) {
          return SettingForms();
        },
      );
    }

    return StreamProvider<List<BrewModel>?>.value(
      value: DatabaseService(null).brews,
      initialData: null,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Brew With Crew",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          actions: <Widget>[
            Tooltip(
              message: 'Setting',
              child: IconButton(
                onPressed: () {
                  showSettingPanels();
                },
                icon: Icon(
                  Icons.settings,
                  color: Colors.black,
                  size: 30,
                ),
              ),
            ),
            Tooltip(
              message: 'Logout',
              child: IconButton(
                onPressed: () async {
                  try {
                    await _authService.signOut();
                  } catch (e) {
                    throw Exception(e.toString());
                  }
                },
                icon: Icon(
                  Icons.logout,
                  color: Colors.black,
                  size: 30,
                ),
              ),
            ),
          ],
          backgroundColor: Colors.brown[400],
        ),
        backgroundColor: Colors.brown[50],
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                'assets/coffee_bg.png',
              ),
            ),
          ),
          child: BrewList(),
        ),
      ),
    );
  }
}
