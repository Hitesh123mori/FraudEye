import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouterProvider extends ChangeNotifier {
  bool isLoginEnabled = false ;

  void notify() {
    notifyListeners();
  }

}