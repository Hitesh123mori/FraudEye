import 'package:flutter/material.dart' ;
import 'package:hack_nu_thon_6/provider/user_provider.dart';
import 'package:provider/provider.dart';

class NormalUserHome extends StatefulWidget {
  static const route = "/home-user";
  static const fullRoute = "//home-user";
  const NormalUserHome({super.key});

  @override
  State<NormalUserHome> createState() => _NormalUserHomeState();
}

class _NormalUserHomeState extends State<NormalUserHome> {

  void init(UserProvider userProvider) async {
    await userProvider.initUser();
  }

  @override
  void initState(){
    super.initState() ;

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    init(userProvider) ;

  }


  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context,userProvider,child){
      return Scaffold(
        body: Container(
          child: Text("hello this is a screen of normal user"),
        ),
      );
    });
  }
}
