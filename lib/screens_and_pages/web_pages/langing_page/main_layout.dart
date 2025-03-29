import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hack_nu_thon_6/provider/router_provider.dart';
import 'package:hack_nu_thon_6/provider/user_provider.dart';
import 'package:hack_nu_thon_6/utils/logo.dart';
import 'package:hack_nu_thon_6/utils/theme/theme.dart';
import 'package:hack_nu_thon_6/utils/widgets/navbar/custom_button2.dart';
import 'package:hack_nu_thon_6/utils/widgets/navbar/navbar_item.dart';
import 'package:provider/provider.dart';


class MainLayout extends StatefulWidget {
  final Widget child;
  static const route = "/";
  static const fullRoute = "/";
  const MainLayout({super.key, required this.child});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {

  @override
  Widget build(BuildContext context) {
    return Consumer<RouterProvider>(builder: (context, routerProvider, child) {
      return Scaffold(
        backgroundColor: AppColors.theme['backgroundColor'],
        appBar: AppBar(
          backgroundColor: AppColors.theme['backgroundColor'],
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    context.go('/');
                    routerProvider.isLoginEnabled = false;
                  },
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Logo(),
                  ),
                ),
                Row(
                  children: [
                    NavbarButton(
                        text: "Login",
                        textColor: AppColors.theme['primaryColor'],
                        hoverTextColor: Colors.black,
                        lineColor: AppColors.theme['primaryColor'],
                        isEnabled: routerProvider.isLoginEnabled,
                        onTap: () {
                          context.go('/login');
                          routerProvider.isLoginEnabled = true;
                          setState(() {});
                        }),
                    const SizedBox(width: 20),
                    CustomButton2(
                      text: 'Register',
                      onTap: () {
                        context.go('/register');
                        routerProvider.isLoginEnabled = false;
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          toolbarHeight: 100,
          flexibleSpace: Container(
            height: double.infinity,
            width: double.infinity,
            color: AppColors.theme['backgroundColor'],
          ),
          elevation: 0,
        ),
        body: widget.child,
      );
    });
  }
}
