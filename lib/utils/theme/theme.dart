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
      "deepPurpleColor" :hexStringToColors("#8300CE"),
      "secondaryColor":hexStringToColors("#6E7076"),
      "ghostWhiteColor":hexStringToColors("#F5F5F5"),
      "podcastColor":hexStringToColors("#C93224"),
    },
  };


}