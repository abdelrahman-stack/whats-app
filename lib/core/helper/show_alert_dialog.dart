import 'package:flutter/material.dart';
import 'package:whats_app_clone/core/extension/custom_theme_extension.dart';

showAlertDialog({
  required BuildContext context,
  required String message,
  String? buttonText,
}) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Text(message,style: TextStyle(color: context.theme.grayColor,fontSize: 15),),
      contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(buttonText ?? 'OK',style: TextStyle(color: context.theme.circleImageColor),),
        ),
      ],
    ),
  );
}
