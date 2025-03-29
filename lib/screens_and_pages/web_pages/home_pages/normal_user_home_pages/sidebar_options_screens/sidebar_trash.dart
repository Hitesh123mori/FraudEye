
import 'package:flutter/material.dart' ;

class SidebarTrash extends StatefulWidget {
  const SidebarTrash({super.key});

  @override
  State<SidebarTrash> createState() => _SidebarTrashState();
}

class _SidebarTrashState extends State<SidebarTrash> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("THIS IS TRASH TAB"),
      ),
    );
  }
}
