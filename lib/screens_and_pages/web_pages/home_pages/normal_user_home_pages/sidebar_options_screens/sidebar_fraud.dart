import 'package:flutter/material.dart' ;

class SidebarFraud extends StatefulWidget {
  const SidebarFraud({super.key});

  @override
  State<SidebarFraud> createState() => _SidebarFraudState();
}

class _SidebarFraudState extends State<SidebarFraud> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("THIS IS FRAUD TAB"),
      ),
    );
  }
}
