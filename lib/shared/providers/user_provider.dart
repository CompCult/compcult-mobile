import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  int userId;
  String email;
  String name;
  String institution;

  updateUserId(int userId) {
    this.userId = userId;
    notifyListeners();
  }

  updateEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  updateName(String name) {
    this.name = name;
    notifyListeners();
  }

  updateInstitution(String institution) {
    this.institution = institution;
    notifyListeners();
  }
}
