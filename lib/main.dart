import 'package:flutter/material.dart' ;
import 'package:hack_nu_thon_6/helper_screens/select_platform.dart';
import 'package:hack_nu_thon_6/provider/router_provider.dart';
import 'package:provider/provider.dart';

late Size? mq ;

void main(){
  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context)=>RouterProvider()),
          ],
          child: MyApp())
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
