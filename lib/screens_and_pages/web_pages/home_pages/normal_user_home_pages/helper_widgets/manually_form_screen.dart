import 'package:flutter/material.dart' ;

class ManuallyFormScreen extends StatefulWidget {
  const ManuallyFormScreen({super.key});

  @override
  State<ManuallyFormScreen> createState() => _ManuallyFormScreenState();
}

class _ManuallyFormScreenState extends State<ManuallyFormScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("This is Option 1's screen."),
      ],
    );
  }
}
