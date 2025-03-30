import 'package:flutter/material.dart';

hexStringToColors(String hexColor){
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
  }

  return Color(int.parse(hexColor, radix: 16));
}


class  AppColors {
  static Map theme = themes["theme1"];

  static Map themes = {

    "theme1": {
      "backgroundColor" :hexStringToColors("#FFFEFA"),
      "primaryColor" :hexStringToColors("#305CDE"),
      "secondaryColor":hexStringToColors("#6E7076"),
      "ghostWhiteColor":hexStringToColors("#F5F5F5"),

      "op1" : hexStringToColors("#C9E4DE"),
      "op2" : hexStringToColors("#C6DEF1"),
      "op3" : hexStringToColors("#DBCDF0"),
      "op4" : hexStringToColors("#F2C6DE"),
      
      
      "red" :hexStringToColors("#FF7F7F"),
      "green" : hexStringToColors("#A8DCAB"),

    },
  };


}