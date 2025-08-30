
import 'package:flutter/material.dart';
import 'package:whats_app_clone/core/extension/custom_theme_extension.dart';

class PrivacyAndTerms extends StatelessWidget {
  const PrivacyAndTerms({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 20,
      ),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'Read our ',
          style: TextStyle(
            color: context.theme.grayColor,
            height: 1.5,
            
          ),
          children: [
            TextSpan(
              text: 'Privacy Policy.',
              style: TextStyle(
                color: context.theme.blueColor,
                
              ),
            ),
            TextSpan(
              text: 'Tap "Agree and continue" to accept the ',
              
              children: [
                TextSpan(
                  text: 'Terms of Service',
                  style: TextStyle(
                    color: context.theme.blueColor,
                    
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
