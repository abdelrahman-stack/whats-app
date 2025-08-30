import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whats_app_clone/core/extension/custom_theme_extension.dart';
import 'package:whats_app_clone/core/utils/app_colors.dart';
import 'package:whats_app_clone/core/widgets/custom_icon_button.dart';
import 'package:whats_app_clone/feature/auth/controller/auth_controller.dart';
import 'package:whats_app_clone/feature/auth/views/widgets/custom_text_form_field.dart';

class VerificationView extends ConsumerWidget {
  const VerificationView({
    super.key,
    required this.phoneNumber,
    required this.verificationId,
  });
  static const routeName = 'verification';
  final String phoneNumber;
  final String verificationId;

  void verfiySmsCode(String smsCode, BuildContext context, WidgetRef ref) {
    ref
        .read(authControllerProvider)
        .verfiySmsCode(
          smsCodeId: verificationId,
          smsCode: smsCode,
          context: context,
          mounted: true,
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'Verfy your number',
          style: TextStyle(color: context.theme.authAppBarTextColor),
        ),
        centerTitle: true,
        actions: [CustomIconButton(icon: Icons.more_vert, onPressed: () {})],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'WhatsApp will need to verify your phone number. ',
                    style: TextStyle(
                      color: context.theme.grayColor,
                      height: 1.5,
                    ),
                    children: [
                      TextSpan(
                        text: 'What\'s my number?',
                        style: TextStyle(
                          color: context.theme.blueColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ), 
                ),
              ),
              SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: CustomTextFormField(
                  hintText: '- - -  - - -',
                  fontSize: 30,
                  cursorColor: AppColors.greenDrak,
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    if (value.length == 6) {
                      verfiySmsCode(value, context, ref);
                    }
                  },
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Enter 6-digit code',
                style: TextStyle(color: context.theme.grayColor),
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Icon(Icons.message, color: context.theme.grayColor),
                  SizedBox(width: 20),
                  Text(
                    'Resend SMS',
                    style: TextStyle(color: context.theme.grayColor),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Divider(color: context.theme.blueColor!.withValues(alpha: 0.2)),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.phone, color: context.theme.grayColor),
                  SizedBox(width: 20),
                  Text(
                    'Call Me',
                    style: TextStyle(color: context.theme.grayColor),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
