import 'package:flutter/material.dart';

class NavbarButton extends StatefulWidget {
  final String text;
  final Color textColor;
  final Color hoverTextColor;
  final Color lineColor;
  final VoidCallback onTap;
  final bool isEnabled;

  NavbarButton({
    super.key,
    required this.text,
    required this.textColor,
    required this.hoverTextColor,
    required this.lineColor,
    required this.onTap,
    this.isEnabled = false, // Default to false
  });

  @override
  State<NavbarButton> createState() => _NavbarButtonState();
}

class _NavbarButtonState extends State<NavbarButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.text,
              style: TextStyle(
                color: _isHovered || widget.isEnabled
                    ? widget.hoverTextColor
                    : widget.textColor,
                fontSize: 16,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 4),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 2,
              width: (widget.isEnabled || _isHovered) ? 40.0 : 0.0,
              decoration: BoxDecoration(
                color: widget.lineColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}