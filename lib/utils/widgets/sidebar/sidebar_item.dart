import 'package:flutter/material.dart';
import 'package:hack_nu_thon_6/provider/normal_user_sidebar_provider.dart';
import 'package:provider/provider.dart';

class SidebarItem extends StatelessWidget {
  final String optionKey;
  final VoidCallback onTap;
  final IconData icon;
  final String text;

  const SidebarItem({
    Key? key,
    required this.optionKey,
    required this.onTap,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NormalUserSidebarProvider>(context);
    bool isSelected = provider.current == optionKey;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: onTap,
        child: Row(
          children: [
            if (isSelected)
              Container(
                width: 5,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            AnimatedContainer(
              width: isSelected ? 215 : 215,
              duration: Duration(milliseconds: 300),
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue.withOpacity(0.2) : Colors.transparent,
                borderRadius: isSelected
                    ? BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                )
                    : BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Icon(icon, color: Colors.black),
                  SizedBox(width: 12),
                  Text(
                    text,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
