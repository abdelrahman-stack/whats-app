import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whats_app_clone/core/extension/custom_theme_extension.dart';
import 'package:whats_app_clone/core/helper/show_alert_dialog.dart';
import 'package:whats_app_clone/core/utils/app_colors.dart';
import 'package:whats_app_clone/core/widgets/custom_elevated_button.dart';
import 'package:whats_app_clone/core/widgets/custom_icon_button.dart';
import 'package:whats_app_clone/feature/auth/controller/auth_controller.dart';
import 'package:whats_app_clone/feature/auth/views/widgets/custom_text_form_field.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  static const String routeName = 'login-view';

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  late TextEditingController countryNameController;
  late TextEditingController phoneNumberController;
  late TextEditingController countryCodeController;

  sendCodeToPhoneNumber() {
    final phoneNumber = phoneNumberController.text;
    final countryName = countryCodeController.text;
    final countryCode = countryCodeController.text;
    if (phoneNumber.isEmpty) {
      return showAlertDialog(
        context: context,
        message: 'Please enter phone number',
      );
    } else if (phoneNumber.length < 9) {
      return showAlertDialog(
        context: context,
        message:
            'The phone number is too short for the country: $countryName.\n\n include your area code .',
      );
    } else if (phoneNumber.length > 10) {
      return showAlertDialog(
        context: context,
        message:
            'The phone number is too long for the country: $countryName.\n\n include your area code .',
      );
    }
    ref.read(authControllerProvider).sendSmsCode(
          phoneNumber: '+$countryCode$phoneNumber',
          context: context,
        );
  }

  showCountryCodePicker() {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      favorite: ['EG', 'US', 'SA'],
      countryListTheme: CountryListThemeData(
        bottomSheetHeight: 600,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        flagSize: 22,
        borderRadius: BorderRadius.circular(20),
        textStyle: TextStyle(color: context.theme.grayColor),
        inputDecoration: InputDecoration(
          labelStyle: TextStyle(color: context.theme.grayColor),
          prefixIcon: Icon(Icons.language, color: AppColors.greenDrak),
          hintText: 'Search country Code or name',
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: context.theme.grayColor!.withValues(alpha: 0.2),
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.greenDrak),
          ),
        ),
      ),
      onSelect: (country) {
        countryNameController.text = country.name;
        countryCodeController.text = country.phoneCode;
      },
    );
  }

  @override
  void initState() {
    countryNameController = TextEditingController(text: 'Egypt');
    phoneNumberController = TextEditingController();
    countryCodeController = TextEditingController(text: '20');
    super.initState();
  }

  @override
  void dispose() {
    countryNameController.dispose();
    phoneNumberController.dispose();
    countryCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'Enter your phone number',
          style: TextStyle(color: context.theme.authAppBarTextColor),
        ),
        centerTitle: true,
        actions: [CustomIconButton(icon: Icons.more_vert, onPressed: () {})],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'WhatsApp will need to verify your phone number. ',
                style: TextStyle(color: context.theme.grayColor, height: 1.5),
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
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: CustomTextFormField(
              onTap: showCountryCodePicker,
              controller: countryNameController,
              readOnly: true,
              suffixIcon: Icon(
                Icons.arrow_drop_down,
                color: AppColors.greenDrak,
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Row(
              children: [
                SizedBox(
                  width: 70,
                  child: CustomTextFormField(
                    onTap: showCountryCodePicker,
                    prifixText: '+',
                    controller: countryCodeController,
                    readOnly: true,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: CustomTextFormField(
                    onTap: () {},
                    controller: phoneNumberController,
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.number,
                    hintText: 'phone number',
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Text(
              'Carrier messages may apply',
              style: TextStyle(color: context.theme.grayColor),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomElevatedButton(
        text: 'NEXT',
        onPressed: sendCodeToPhoneNumber,
        buttonWidth: 90,
      ),
    );
  }
}
