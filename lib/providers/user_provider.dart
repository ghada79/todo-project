import 'package:flutter/material.dart';
import 'package:todoapp/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  Myuser? currentUser;

  void updateUser(Myuser newUser) {
    currentUser = newUser;
    notifyListeners();

  }
}