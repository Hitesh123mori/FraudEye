import 'package:flutter/material.dart' ;

class SidebarChartBank extends StatefulWidget {
  const SidebarChartBank({super.key});

  @override
  State<SidebarChartBank> createState() => _SidebarChartBankState();
}

class _SidebarChartBankState extends State<SidebarChartBank> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("THIS IS CHART TAB FOR BANK"),
      ),
    );
  }
}
