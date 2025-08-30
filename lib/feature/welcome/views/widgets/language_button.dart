import 'package:flutter/material.dart';
import 'package:whats_app_clone/core/extension/custom_theme_extension.dart';
import 'package:whats_app_clone/core/utils/app_colors.dart';
import 'package:whats_app_clone/core/widgets/custom_icon_button.dart';

class LanguageButton extends StatelessWidget {
  const LanguageButton({super.key});
  showButtomSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 4,
                width: 30,
                decoration: BoxDecoration(
                  color: context.theme.grayColor!.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(width: 20),
                  CustomIconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icons.close_outlined,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'App Language',
                    style: TextStyle(
                      color: context.theme.grayColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Divider(
                color: context.theme.grayColor!.withValues(alpha: 0.3),
                thickness: 0.5,
              ),
              RadioListTile(
                value: true,
                groupValue: true,
                onChanged: (value) {},
                activeColor: AppColors.greenDrak,
                title: Text('English'),
                subtitle: Text(
                  "Phone's language",
                  style: TextStyle(color: context.theme.grayColor),
                ),
              ),
              RadioListTile(
                value: true,
                groupValue: false,
                onChanged: (value) {},
                activeColor: AppColors.greenDrak,
                title: Text('Amharic'),
                subtitle: Text(
                  'Amharic',
                  style: TextStyle(color: context.theme.grayColor),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.theme.langButtonColor,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        splashFactory: NoSplash.splashFactory,
        highlightColor: context.theme.langButtonLightColor,
        borderRadius: BorderRadius.circular(20),
        onTap: () => showButtomSheet(context),

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.language, color: AppColors.greenDrak),
              SizedBox(width: 10),
              Text('English', style: TextStyle(color: AppColors.greenDrak)),
              SizedBox(width: 10),
              Icon(Icons.keyboard_arrow_down, color: AppColors.greenDrak),
            ],
          ),
        ),
      ),
    );
  }
}
