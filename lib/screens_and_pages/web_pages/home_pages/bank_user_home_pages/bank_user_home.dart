import 'package:flutter/material.dart' ;
import 'package:hack_nu_thon_6/provider/user_provider.dart';
import 'package:provider/provider.dart';

class BankUserHome extends StatefulWidget {
  static const route = "/home-bank";
  static const fullRoute = "//home-bank";
  const BankUserHome({super.key});

  @override
  State<BankUserHome> createState() => _BankUserHomeState();
}

class _BankUserHomeState extends State<BankUserHome> {


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
          child: Text("hello this is a screen of bank user"),
        ),
      );
    }) ;
  }
}
