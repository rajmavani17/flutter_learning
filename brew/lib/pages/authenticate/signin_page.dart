import 'package:brew/pages/authenticate/input_decoration.dart';
import 'package:brew/pages/loading.dart';
import 'package:brew/services/auth_service.dart';
import 'package:flutter/material.dart';

class SigninPage extends StatefulWidget {
  final Function toggleView;
  const SigninPage({
    super.key,
    required this.toggleView,
  });

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loader()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: Text(
                "Sign in to Brew Crew",
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    widget.toggleView();
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.app_registration_rounded,
                        color: Colors.black,
                        size: 30,
                      ),
                      Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 20,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter an valid Email";
                        }
                        return null;
                      },
                      decoration: getTextFieldDecoration(hintText: 'Email'),
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.length < 6) {
                          return "please enter at least 6 characters";
                        }
                        return null;
                      },
                      obscureText: true,
                      obscuringCharacter: '*',
                      decoration: getTextFieldDecoration(hintText: 'Password'),
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });
                          dynamic result = await _auth.signinWithEmailPassword(
                            email,
                            password,
                          );
                          if (result == null) {
                            setState(() {
                              error =
                                  "Incorrect Email/Password\nPlease Try Again";
                              loading = false;
                            });
                          } else {
                            setState(() {
                              loading = false;
                            });
                          }
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          Colors.brown[400],
                        ),
                      ),
                      child: Text(
                        "Sign in",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      error,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

/*

ElevatedButton(
          onPressed: () async {
            dynamic result = await _auth.signinAnonymous();
            if (result == null) {
              print('Sigin Page => sign in failed');
            } else {
              print("Sigin Page => ${result.uid}");
            }
          },
          child: Text(
            'Sign in Anonymously',
          ),
        ),
      

*/
