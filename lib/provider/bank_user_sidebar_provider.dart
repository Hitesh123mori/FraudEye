import 'package:flutter/material.dart' ;


class BankUserSidebarProvider extends ChangeNotifier{


  Map<String, bool> sidebarOptions = {
    "bhome": true,
    "bchart": false,
    "breports": false,
    "bfrauds": false,
    "btrash": false,
  };

  String current = "bhome";

  void updateCurrent(String option) {
    sidebarOptions[current] = false;
    current = option;
    sidebarOptions[current] = true;
    notifyListeners();
  }


}