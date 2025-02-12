import 'package:brew/models/user_model.dart';
import 'package:brew/pages/authenticate/input_decoration.dart';
import 'package:brew/pages/loading.dart';
import 'package:brew/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingForms extends StatefulWidget {
  const SettingForms({super.key});

  @override
  State<SettingForms> createState() => _SettingFormsState();
}

class _SettingFormsState extends State<SettingForms> {
  final _formkey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4', '5'];

  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

    return StreamBuilder<UserDataModel>(
      stream: DatabaseService(user.uid).userData,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          UserDataModel? userData = snapshot.data;
          return SizedBox(
            width: double.infinity,
            height: 375,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 30, horizontal: 15.0),
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    Text(
                      'Update Your Brew setting',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      initialValue: userData?.name,
                      decoration: getTextFieldDecoration(hintText: 'Name'),
                      validator: (val) =>
                          val!.isEmpty ? 'Please Enter a name' : null,
                      onChanged: (val) {
                        setState(() {
                          _currentName = val;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        fillColor: Colors.brown[200],
                        filled: true,
                      ),
                      value: _currentSugars ?? userData?.sugars ?? '0',
                      items: sugars.map((sugar) {
                        return DropdownMenuItem(
                          value: sugar,
                          child: Text('$sugar sugars'),
                        );
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          _currentSugars = val;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Slider(
                      min: 100,
                      max: 900,
                      value: _currentStrength?.toDouble() ??
                          userData?.strength.toDouble() ??
                          100,
                      activeColor: Colors.brown[_currentStrength ?? 100],
                      divisions: 4,
                      onChanged: (value) {
                        setState(() {
                          _currentStrength = value.toInt();
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formkey.currentState!.validate()) {
                          await DatabaseService(userData?.uid).updateUserData(
                            _currentSugars ?? userData?.sugars ?? '',
                            _currentName ?? userData?.name ?? '',
                            _currentStrength ?? userData?.strength ?? 0,
                          );
                          Navigator.pop(context);
                        }

                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          Colors.brown[200],
                        ),
                      ),
                      child: Text(
                        'Update',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Loader();
        }
      },
    );
  }
}
