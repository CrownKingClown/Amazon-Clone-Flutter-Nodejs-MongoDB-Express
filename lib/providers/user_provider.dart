import 'package:flutter/material.dart';
import './../models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    name: '',
    password: '',
    email: '',
    address: '',
    id: '',
    token: '',
    type: '',
  ); // this is the user object

  User get user => _user; // getter

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners(); //all the widgets that are listening to this provider will be notified and rebuilt
  } // setter
}
