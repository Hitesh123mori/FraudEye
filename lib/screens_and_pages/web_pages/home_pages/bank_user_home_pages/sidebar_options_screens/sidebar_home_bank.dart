import 'package:flutter/material.dart' ;

class SidebarHomeBank extends StatefulWidget {
  const SidebarHomeBank({super.key});

  @override
  State<SidebarHomeBank> createState() => _SidebarHomeBankState();
}

class _SidebarHomeBankState extends State<SidebarHomeBank> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("THIS IS HOME BANK TAB"),
      ),
    );
  }
}
