
import 'package:flutter/material.dart' ;
import 'package:go_router/go_router.dart';

class TempScreenMobile extends StatefulWidget {
  const TempScreenMobile({super.key});

  @override
  State<TempScreenMobile> createState() => _TempScreenMobileState();
}

class _TempScreenMobileState extends State<TempScreenMobile> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Text("hello this is mobile screen"),
        ),
      ),
    );
  }
}
