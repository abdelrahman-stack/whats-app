import 'package:flutter/material.dart';
import 'package:whats_app_clone/core/extension/custom_theme_extension.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.iconColor,
    this.iconSize,
    this.minWidth,
    this.backgroundColor,
    this.border,
  });
  final VoidCallback onPressed;
  final IconData icon;
  final Color? iconColor;
  final double? iconSize;
  final double? minWidth;
  final Color? backgroundColor;
  final BoxBorder? border;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        border: border,
      ),
      child: IconButton(
        onPressed: onPressed,
        splashColor: Colors.transparent,
        padding: EdgeInsets.zero,
        splashRadius: (minWidth ?? 45) - 25,
        iconSize: iconSize ?? 22,
        constraints: BoxConstraints(minWidth: minWidth ?? 45, minHeight: minWidth ?? 45),
        icon: Icon(icon, color: iconColor ?? context.theme.grayColor),
      ),
    );
  }
}
