import 'package:flutter/material.dart' ;

class SidebarChart extends StatefulWidget {
  const SidebarChart({super.key});

  @override
  State<SidebarChart> createState() => _SidebarChartState();
}

class _SidebarChartState extends State<SidebarChart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("THIS IS CHART TAB"),
      ),
    );
  }
}
