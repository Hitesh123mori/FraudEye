import 'package:flutter/material.dart' ;
import 'package:hack_nu_thon_6/helper_screens/web.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'mobile.dart';

class SelectPlatform extends StatefulWidget {
  const SelectPlatform({super.key});

  @override
  State<SelectPlatform> createState() => _SelectPlatformState();
}

class _SelectPlatformState extends State<SelectPlatform> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ScreenTypeLayout.builder(
          mobile:(BuildContext context) => Mobile(),
          desktop: (BuildContext context) =>Web(),
        ),
      ),
    );
  }
}