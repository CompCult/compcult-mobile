import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  int userId;
  String email;

  updateUserId(int userId) {
    this.userId = userId;
    notifyListeners();
  }

  updateEmail(String email) {
    this.email = email;
    notifyListeners();
  }
}
