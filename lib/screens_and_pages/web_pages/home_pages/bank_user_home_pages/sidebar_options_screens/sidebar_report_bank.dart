import 'package:flutter/material.dart' ;

class SidebarReportBank extends StatefulWidget {
  const SidebarReportBank({super.key});

  @override
  State<SidebarReportBank> createState() => _SidebarReportBankState();
}

class _SidebarReportBankState extends State<SidebarReportBank> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("THIS IS REPORT BANK TAB"),
      ),
    );
  }
}
