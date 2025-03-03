import 'dart:io';

import 'package:chat_app/pages/auth_page.dart';
import 'package:chat_app/widgets/user_image_picker_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/providers/current_user_provider.dart';
import 'package:chat_app/widgets/other_user_list.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({super.key});

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  UserModel? currentUser;
  bool isLoading = false;
  final TextEditingController _userNameController = TextEditingController();
  bool? isImageSelected = false;
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    getCurrentUserDetails(); // ✅ Call it here instead of initState
  }

  // final currentUserData = _firebase.collection('users').where('uid')();
  void getCurrentUserDetails() {
    setState(() {
      isLoading = true;
    });
    final user =
        Provider.of<CurrentUserProvider>(context, listen: false).currentUser;

    setState(() {
      currentUser = user;
      isLoading = false;
    });
  }

  void _pickImage(File? selectedImage) {
    if (selectedImage == null) {
      return;
    }
    _selectedImage = selectedImage;
  }

  Future<String> uploadFile(File file, UserModel user) async {
    try {
      await supabase.storage.from('images').upload('${user.uid}.jpg', file);
      final String publicUrl =
          supabase.storage.from('images/').getPublicUrl('${user.uid}.jpg');
      return publicUrl;
    } catch (e) {
      //
    }
    return '';
  }

  void _updateProfile() async {
    if (_userNameController.text.trim().isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Center(
            child: Text('Image or UserName missing'),
          ),
          elevation: 3,
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }
    final currentUser =
        Provider.of<CurrentUserProvider>(context, listen: false).currentUser;
    String downloadUrl =
        'https://plus.unsplash.com/premium_photo-1664543649372-6e2ec0e0bfff?q=80&w=1976&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';
    if (_selectedImage != null) {
      downloadUrl = await uploadFile(_selectedImage!, currentUser!);
    }

    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .update(
      {
        'username': _userNameController.text.trim(),
        'image_url': downloadUrl,
      },
    );

    // await FirebaseFirestore.instance.collection('chat')
  }

  void _showDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  label: Text('Username'),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blueGrey,
                      width: 1,
                    ),
                  ),
                ),
                controller: _userNameController,
              ),
              SizedBox(
                height: 15,
              ),
              UserImagePickerWidget(onPickedImage: _pickImage),
              SizedBox(
                height: 25,
              ),
              ElevatedButton.icon(
                onPressed: _updateProfile,
                icon: Icon(Icons.update_sharp),
                label: Text('Update'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Container(
        width: 50,
        height: 50,
        constraints: BoxConstraints(
          maxHeight: 50,
          maxWidth: 50,
        ),
        child: CircularProgressIndicator(),
      ),
    );
    if (!isLoading) {
      if (currentUser != null) {
        content = Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(currentUser!.username),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                  currentUser!.imageUrl,
                ),
              ),
              subtitle: Text(currentUser!.email),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: _showDialog,
              ),
            ),
            SizedBox(
              height: 10,
              child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 1,color: Colors.black),
                    )
                  ),
                ),
            ),
            Text('Other Users'),
            SizedBox(
              height: 10,
              child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1,color: Colors.black),
                    )
                  ),
                ),
            ),
            OtherUserList(),
          ],
        );
      } else {
        content = Center(
          child: Text('User Details Not Found'),
        );
      }
    }
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 25.0,
          right: 10,
          left: 10,
        ),
        child: content,
      ),
    );
  }
}
