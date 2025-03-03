import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePickerWidget extends StatefulWidget {
  const UserImagePickerWidget({
    super.key,
    required this.onPickedImage,
  });

  final void Function(File? selectedImage) onPickedImage;
  @override
  State<UserImagePickerWidget> createState() => _UserImagePickerWidgetState();
}

class _UserImagePickerWidgetState extends State<UserImagePickerWidget> {
  File? _pickedImageFile;

  void _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );

    if (pickedImage == null) {
      return;
    }

    setState(() {
      _pickedImageFile = File(pickedImage.path);
      widget.onPickedImage(_pickedImageFile);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // show preview of image
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey,
          foregroundImage:
              _pickedImageFile != null ? FileImage(_pickedImageFile!) : null,
        ),

        TextButton.icon(
          onPressed: _pickImage,
          icon: Icon(Icons.camera_alt),
          label: Text(
            'Add Image',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
