import 'package:flutter/material.dart' ;

class TempPageDart extends StatefulWidget {
  static const route = "/firstpage";
  static const fullRoute = "/firstpage";
  const TempPageDart({super.key});

  @override
  State<TempPageDart> createState() => _TempPageDartState();
}

class _TempPageDartState extends State<TempPageDart> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Text("This is temp screen"),
      ),
    );
  }
}
