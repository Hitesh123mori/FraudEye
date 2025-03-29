import 'package:flutter/material.dart' ;
import 'package:hack_nu_thon_6/screens_and_pages/mobile_screens/temp_screen_mobile.dart';

class Mobile extends StatefulWidget {
  const Mobile({super.key});

  @override
  State<Mobile> createState() => _MobileState();
}

class _MobileState extends State<Mobile> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:TempScreenMobile(),
    );
  }
}