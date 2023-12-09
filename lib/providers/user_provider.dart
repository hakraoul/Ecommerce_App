import 'package:ecommerce_app/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: "",
    email: "",
    name: "",
    password: "",
    address: "",
    type: "",
    token: "",
  );

  //_user is private variable so you need to add getter
  User get user => _user;

  //update user
  void setUser(String user) {
    print("User: ${user}");
    _user = User.fromJson(user);
    print("User provider: ${_user.toJson()}");
    notifyListeners(); //notify the listener that user has been change and it will rebuld.
  }
}
