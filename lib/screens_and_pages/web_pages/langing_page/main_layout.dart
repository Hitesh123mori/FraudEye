import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // GestureDetector(
              //   onTap: () {
              //     context.go('/');
              //   },
              //   child: MouseRegion(
              //     cursor: SystemMouseCursors.click,
              //     child: Text("click me"),
              //   ),
              // ),
            ],
          ),
        ),
        toolbarHeight: 100,
        flexibleSpace: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white
        ),
        elevation: 0,
      ),
      body: widget.child,
    );
  }
}