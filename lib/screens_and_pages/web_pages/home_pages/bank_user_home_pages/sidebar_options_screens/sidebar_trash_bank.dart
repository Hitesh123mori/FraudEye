
import 'package:flutter/material.dart' ;

class SidebarTrashBank extends StatefulWidget {
  const SidebarTrashBank({super.key});

  @override
  State<SidebarTrashBank> createState() => _SidebarTrashBankState();
}

class _SidebarTrashBankState extends State<SidebarTrashBank> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("THIS IS TRASH BANK TAB"),
      ),
    );
  }
}
