import 'package:flutter/material.dart' ;


class NormalUserSidebarProvider extends ChangeNotifier{

  Map<String, bool> sidebarOptions = {
    "home": true,
    "chart": false,
    "reports": false,
    "frauds": false,
    "trash": false,
  };

  String current = "home";

  void updateCurrent(String option) {
    sidebarOptions[current] = false;
    current = option;
    sidebarOptions[current] = true;
    notifyListeners();
  }


}