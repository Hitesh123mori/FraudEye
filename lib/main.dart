import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' ;
import 'package:flutter/services.dart';
import 'package:hack_nu_thon_6/helper_screens/select_platform.dart';
import 'package:hack_nu_thon_6/provider/bank_user_sidebar_provider.dart';
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
            ChangeNotifierProvider(create: (context)=>BankUserSidebarProvider()),
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

  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  if (defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.windows) {
    await Firebase.initializeApp(
        name: 'hacknuthon_1',
        options: const FirebaseOptions(
          apiKey: 'AIzaSyAn9hrLrjtwQ16E-ZSanmZnCYCi0HTu1E0',
          appId: '1:296920310204:web:6341bdaf50474684db4bb9',
          messagingSenderId: '296920310204',
          projectId: 'hacknuthon-5ae21',
          storageBucket: 'hacknuthon-5ae21.firebasestorage.app',
        ));
  }

  if (defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.windows) {
    await Firebase.initializeApp(
        name: 'hacknuthon_2',
        options: const FirebaseOptions(
          apiKey: 'AIzaSyCDoxpe3BSbOqy-aA4I2iLmuPS2j5J3HHU',
          appId: '1:1011888016997:android:77bf8f56888fb1a0ac008c',
          messagingSenderId: '1011888016997',
          projectId: 'mori-hitesh',
          storageBucket: 'mori-hitesh.appspot.com',
        )
    );
  }
}