import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart' ;
import 'package:flutter/services.dart';
import 'package:hack_nu_thon_6/helper_screens/select_platform.dart';
import 'package:hack_nu_thon_6/provider/normal_user_sidebar_provider.dart';
import 'package:hack_nu_thon_6/provider/router_provider.dart';
import 'package:hack_nu_thon_6/provider/user_provider.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

late Size mq ;

void main()async{

  WidgetsFlutterBinding.ensureInitialized() ;
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]).then((value){
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky) ;
  });

  await _intializeFirebase() ;

  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context)=>RouterProvider()),
            ChangeNotifierProvider(create: (context)=>UserProvider()),
            ChangeNotifierProvider(create: (context)=>NormalUserSidebarProvider()),
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


_intializeFirebase() async {

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

}