import 'package:flutter/material.dart' ;

class SidebarHome extends StatefulWidget {
  const SidebarHome({super.key});

  @override
  State<SidebarHome> createState() => _SidebarHomeState();
}

class _SidebarHomeState extends State<SidebarHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("THIS IS HOME TAB"),
      ),
    );
  }
}
