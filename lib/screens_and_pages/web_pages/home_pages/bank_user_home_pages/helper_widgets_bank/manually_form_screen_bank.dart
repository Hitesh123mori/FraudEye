import 'package:flutter/material.dart' ;

class ManuallyFormScreenBank extends StatefulWidget {
  const ManuallyFormScreenBank({super.key});

  @override
  State<ManuallyFormScreenBank> createState() => _ManuallyFormScreenBankState();
}

class _ManuallyFormScreenBankState extends State<ManuallyFormScreenBank> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("This is Option 1's screen bank."),
      ],
    );
  }
}
