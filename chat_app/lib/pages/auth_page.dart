import 'dart:convert';
import 'dart:io';

import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/providers/current_user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:chat_app/constants.dart';
import 'package:chat_app/widgets/user_image_picker_widget.dart';

final _firebase = FirebaseAuth.instance;
final supabase = SupabaseClient(Constants.SUPABASE_URL, Constants.ANON_KEY);

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();

  bool isLogin = true;
  String _enteredEmail = '';
  String _enteredPassword = '';
  String _enteredUsername = '';
  File? _selectedImage;
  bool isAuthenticating = false;

  void onSelectImage(File? selectedImage) {
    if (selectedImage == null) {
      return;
    }
    _selectedImage = selectedImage;
  }

  Future<String> uploadFile(File file, UserCredential userCred) async {
    try {
      await supabase.storage
          .from('images')
          .upload('${userCred.user!.uid}.jpg', file);
      final String publicUrl = supabase.storage
          .from('images/')
          .getPublicUrl('${userCred.user!.uid}.jpg');
      // final url = Uri.https('api.unsplash.com/photos/random', '', {
      //   'client_id': 'MtcX1FcKlzC6zxvJ1VXQbv-VBtAlgf_VNMQum8lcTFk',
      // });
      // final unsplashResponse = await http.get(url);

      // final data = json.decode(unsplashResponse.body);
      // final String publicUrl = data['urls']['full'];
      return publicUrl;
    } catch (e) {
      //
    }
    return '';
  }

  void _submit() async {
    bool isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    // if (!isLogin && _selectedImage == null) {
    //   ScaffoldMessenger.of(context).clearSnackBars();
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text(
    //         'Please Select an Profile Image',
    //         style: Theme.of(context).textTheme.bodyLarge!.copyWith(
    //               fontSize: 14,
    //               color: Colors.white,
    //             ),
    //       ),
    //       backgroundColor: const Color.fromARGB(255, 127, 1, 1),
    //     ),
    //   );
    //   return;
    // }

    setState(() {
      isAuthenticating = true;
    });

    _formKey.currentState!.save();
    try {
      if (isLogin) {
        final userCredential = await _firebase.signInWithEmailAndPassword(
          email: _enteredEmail,
          password: _enteredPassword,
        );
      } else {
        final userCredential = await _firebase.createUserWithEmailAndPassword(
          email: _enteredEmail,
          password: _enteredPassword,
        );

        String downloadUrl =
            'https://plus.unsplash.com/premium_photo-1664543649372-6e2ec0e0bfff?q=80&w=1976&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';
        if (_selectedImage != null) {
          downloadUrl = await uploadFile(_selectedImage!, userCredential);
        }

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set(
          {
            'username': _enteredUsername,
            'email': _enteredEmail,
            'image_url': downloadUrl,
            'uid': userCredential.user!.uid
          },
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == '') {}
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.message ?? 'An Unexpected error occurred',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 14,
                  color: Colors.white,
                ),
          ),
          backgroundColor: const Color.fromARGB(255, 255, 66, 66),
        ),
      );
      setState(() {
        isAuthenticating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Super Chat',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
        ),
        centerTitle: true,
        // backgroundColor: Theme.of(context).colorScheme.primary,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin:
                    EdgeInsets.only(top: 30, bottom: 20, left: 20, right: 20),
                child: Image.asset('assets/images/chat.png'),
              ),
              Card(
                margin: EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AnimatedSize(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.decelerate,
                            child: !isLogin
                                ? UserImagePickerWidget(
                                    onPickedImage: onSelectImage,
                                  )
                                : SizedBox(), // Adjusts smoothly
                          ),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            decoration: InputDecoration(
                              label: Text('Email Address'),
                            ),
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  !value.contains('@')) {
                                return 'Please Enter an valid email';
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              _enteredEmail = newValue!;
                            },
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          ...(!isLogin
                              ? [
                                  TextFormField(
                                    decoration: InputDecoration(
                                      label: Text('Username'),
                                    ),
                                    enableSuggestions: false,
                                    validator: (value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          value.trim().length < 4) {
                                        return 'Please Enter a Valid Username of at least 4 characters';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      _enteredUsername = value!;
                                    },
                                  ),
                                  SizedBox(height: 12),
                                ]
                              : []),
                          TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            obscureText: true,
                            obscuringCharacter: '*',
                            decoration: InputDecoration(
                              label: Text('Password'),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().length < 6) {
                                return 'Please enter a password of at least 6 characters';
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              _enteredPassword = newValue!;
                            },
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          if (isAuthenticating)
                            CircularProgressIndicator.adaptive(),
                          if (!isAuthenticating)
                            ElevatedButton(
                              onPressed: _submit,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                              ),
                              child: Text(isLogin ? 'Login' : 'Signup'),
                            ),
                          if (!isAuthenticating)
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  isLogin = !isLogin;
                                });
                              },
                              child: Text(
                                isLogin
                                    ? 'Create an Account'
                                    : 'I Already have an Account.',
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
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

"https://bbpthavdzqriklvmqzxn.supabase.co/storage/v1/object/public/images/HcqGoKmsVQc63di42V7l6vhqA1x2.jpg"
https://bbpthavdzqriklvmqzxn.supabase.co/storage/v1/object/public/images//HcqGoKmsVQc63di42V7l6vhqA1x2.jpg
 */