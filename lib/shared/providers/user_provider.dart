import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  int userId;

  updateUserId(int userId) {
    this.userId = userId;
    notifyListeners();
  }
}
