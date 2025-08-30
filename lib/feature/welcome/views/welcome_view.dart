import 'package:flutter/material.dart';
import 'package:whats_app_clone/core/extension/custom_theme_extension.dart';

import 'package:whats_app_clone/core/widgets/custom_elevated_button.dart';
import 'package:whats_app_clone/feature/auth/views/login_view.dart';
import 'package:whats_app_clone/feature/welcome/views/widgets/language_button.dart';
import 'package:whats_app_clone/feature/welcome/views/widgets/privacy_and_terms.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});
  static const String routeName = 'welcome';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 10,
                ),
                child: Image.asset(
                  'assets/images/circle.png',
                  color: context.theme.circleImageColor,
                ),
              ),
            ),
          ),
          SizedBox(height: 40),
          Expanded(
            child: Column(
              children: [
                Text(
                  'Welcome to WhatsApp',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                PrivacyAndTerms(),

                SizedBox(height: 40),
                CustomElevatedButton(
                  text: 'AGREE AND CONTINUE',
                  onPressed: () => Navigator.pushReplacementNamed(
                    context,
                    LoginView.routeName,
                  ),
                ),
                SizedBox(height: 50),
                LanguageButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
