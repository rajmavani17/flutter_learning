import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/services/get_current_user_service.dart';
import 'package:flutter/material.dart';

class CurrentUserProvider extends ChangeNotifier {
  UserModel? currentUser;

  Future<void> getCurrentUserDetails() async {
    currentUser = await GetCurrentUserService.getCurrentUserDetails();
    notifyListeners();
  }

  void setCurrentUser(UserModel user) {
    currentUser = user;
    notifyListeners();
  }
  
}
