import 'package:flutter/material.dart';
import 'package:whats_app_clone/core/extension/custom_theme_extension.dart';

class ShortHeaderBar extends StatelessWidget {
  const ShortHeaderBar({super.key, this.height, this.width, this.color});
  final double? height;
  final double? width;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(
      width: width ?? 25,
      height: height ?? 4,
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: color ?? context.theme.grayColor!.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(5),
      )
    ));
  }
}
