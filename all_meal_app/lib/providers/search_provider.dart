
import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier {
  String searchText = '';

  void setSearchText(String text) {
    searchText = text;
    notifyListeners();
  }

  String getSearchText() {
    return searchText;
  }
}
