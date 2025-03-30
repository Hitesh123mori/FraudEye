import 'package:flutter/material.dart' ;

class SidebarFraudBank extends StatefulWidget {
  const SidebarFraudBank({super.key});

  @override
  State<SidebarFraudBank> createState() => _SidebarFraudBankState();
}

class _SidebarFraudBankState extends State<SidebarFraudBank> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("THIS IS FRAUD BANK TAB"),
      ),
    );
  }
}
