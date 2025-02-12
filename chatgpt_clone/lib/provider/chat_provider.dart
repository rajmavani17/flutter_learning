import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier{
  List<Map<String,dynamic>> chats = [];


  void addMessage (Map<String,dynamic> message) {
    chats.add(message);
    notifyListeners();
  }

  void clearAllMessage() {
    chats.clear();
  }
}