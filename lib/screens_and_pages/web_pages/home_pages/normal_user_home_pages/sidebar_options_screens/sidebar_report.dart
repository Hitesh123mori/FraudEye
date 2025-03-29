import 'package:flutter/material.dart' ;

class SidebarReport extends StatefulWidget {
  const SidebarReport({super.key});

  @override
  State<SidebarReport> createState() => _SidebarReportState();
}

class _SidebarReportState extends State<SidebarReport> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("THIS IS REPORT TAB"),
      ),
    );
  }
}
