import 'package:flutter/material.dart' ;
import 'package:hack_nu_thon_6/helper_screens/select_platform.dart';


void main(){
  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SelectPlatform(),
    );
  }
}
