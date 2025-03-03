import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImageInputWidget extends StatefulWidget {
  const ImageInputWidget({
    super.key,
    required this.onSelectImage,
  });

  final void Function(File image) onSelectImage;

  @override
  State<ImageInputWidget> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInputWidget> {
  File? _selectedImage;

  void _takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 750,
    );

    if (pickedImage == null) {
      return;
    }
    setState(() {
      _selectedImage = File(pickedImage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      onPressed: _takePicture,
      icon: Icon(Icons.camera_alt),
      label: Text('Take Picture'),
    );

    if (_selectedImage != null) {
      content = GestureDetector(
        onTap: _takePicture,
        child: Image.file(
          _selectedImage!,
          fit: BoxFit.contain,
          width: double.infinity,
          height: double.infinity,
        ),
      );
      widget.onSelectImage(_selectedImage!);
    }

    return Container(
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withAlpha(96),
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      child: content,
    );
  }
}
