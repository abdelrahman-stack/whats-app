import 'package:flutter/material.dart';
import 'package:whats_app_clone/core/extension/custom_theme_extension.dart';
import 'package:whats_app_clone/core/utils/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.keyboardType,
    this.onChanged,
    this.onTap,
    this.controller,
    this.hintText,
    this.readOnly,
    this.textAlign,
    this.prifixText,
    this.suffixIcon,
    this.fontSize,
    this.autofocus,
    this.cursorColor,
  });
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final VoidCallback? onTap;
  final TextEditingController? controller;
  final String? hintText;
  final bool? readOnly;
  final TextAlign? textAlign;
  final String? prifixText;
  final Widget? suffixIcon;
  final double? fontSize;
  final bool? autofocus;
  final Color? cursorColor;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: cursorColor,
      onChanged: onChanged,
      keyboardType: readOnly == null ? keyboardType : null,
      onTap: onTap,
      controller: controller,
      readOnly: readOnly ?? false,
      style: TextStyle(fontSize: fontSize),
      autofocus: autofocus ?? false,
      textAlign: textAlign ?? TextAlign.center,
      decoration: InputDecoration(
        prefixText: prifixText,
        suffixIcon: suffixIcon,
        hintText: hintText,
        isDense: true,
        hintStyle: TextStyle(color: context.theme.grayColor),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.greenDrak),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.greenDrak, width: 2),
        ),
      ),
    );
  }
}
