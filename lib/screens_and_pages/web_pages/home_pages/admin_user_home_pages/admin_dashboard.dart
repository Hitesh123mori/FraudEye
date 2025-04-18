import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hack_nu_thon_6/provider/router_provider.dart';
import 'package:hack_nu_thon_6/provider/user_provider.dart';
import 'package:hack_nu_thon_6/utils/theme/theme.dart';
import 'package:provider/provider.dart';

class AdminDashboard extends StatefulWidget {
  static const route = "/dashboard";
  static const fullRoute = "/dashboard";
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  void init(UserProvider userProvider) async {
    await userProvider.initUser();
  }

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    init(userProvider);
  }

  // void _showLoginAlert(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (context) {
  //       return AlertDialog(
  //         backgroundColor: AppColors.theme['backgroundColor'],
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(20),
  //         ),
  //         title: Text("Not Logged In", style: TextStyle(fontWeight: FontWeight.bold)),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Icon(Icons.warning_amber_rounded, color: Colors.red, size: 50),
  //             SizedBox(height: 10),
  //             Text("You are not logged in. Please log in to continue."),
  //           ],
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               final routerProvider = Provider.of<RouterProvider>(context, listen: false);
  //               Future.delayed(Duration.zero, () {
  //                 context.go('/login');
  //               });
  //               routerProvider.isLoginEnabled = true;
  //             },
  //             child: Text("Go to Login", style: TextStyle(color: AppColors.theme['primaryColor'])),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {


        return Scaffold(
          body: Column(
            children: [
              Center(
                child: Text("Hello, this is the admin dashboard"),
              ),

              ElevatedButton(onPressed: ()async{
                await userProvider.logOut();
              }, child: Text("log out"))

            ],
          ),
        );
      },
    );
  }
}