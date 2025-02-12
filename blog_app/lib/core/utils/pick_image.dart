import 'dart:io';

import 'package:image_picker/image_picker.dart';
// import 'package:image_picker_android/image_picker_android.dart';
Future<File?> pickImage() async {
  try {
    ImagePicker picker = ImagePicker();
    final xFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (xFile != null) {
      return File(xFile.path);
    }
    return null;
  } catch (e) {
    return null;
  }
}
