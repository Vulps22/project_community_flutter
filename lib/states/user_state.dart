import 'package:flutter/material.dart';
import '../models/user.dart'; // Adjust the path according to your project structure

class UserState extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(User? user) {
    _user = user;
    notifyListeners();
  }
}
