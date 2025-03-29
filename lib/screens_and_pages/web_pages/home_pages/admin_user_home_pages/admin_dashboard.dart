import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' ;
import 'package:hack_nu_thon_6/provider/user_provider.dart';
import 'package:provider/provider.dart';

class AdminDashboard extends StatefulWidget {
  static const route = "/home-bank";
  static const fullRoute = "//home-bank";
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {


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
    return Consumer<UserProvider>(builder: (context,userProvider,child){
      return Scaffold(
        body: Container(
          child: Text("hello this is a screen of admin dashboard"),
        ),
      );
    });
  }
}
