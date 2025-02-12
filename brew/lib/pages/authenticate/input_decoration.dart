import 'package:flutter/material.dart';

InputDecoration getTextFieldDecoration(
    {required String hintText}) {
  return InputDecoration(
    hintText: hintText,
    filled: true,
    fillColor: Colors.brown[200],
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide.none,
    ),
  );
}
