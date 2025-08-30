import 'package:flutter/material.dart';
import 'package:whats_app_clone/core/utils/app_colors.dart';

extension CustomTheme on BuildContext {
  CustomThemeExtension get theme {
    return Theme.of(this).extension<CustomThemeExtension>()!;
  }
}

class CustomThemeExtension extends ThemeExtension<CustomThemeExtension> {
  static const lightMode = CustomThemeExtension(
    circleImageColor: Color(0xff25d366),
    grayColor: AppColors.grayLight,
    blueColor: AppColors.blueLight,
    langButtonColor: Color(0xffF7F8FA),
    langButtonLightColor: Color(0xffe8e8ed),
    authAppBarTextColor: AppColors.greenLight,
    photoIconBackgroundColor: Color(0xfff0f2f3),
    photoIconColor: Color(0xff9daab3),
  );
  static const darkMode = CustomThemeExtension(
    circleImageColor: AppColors.greenDrak,
    grayColor: AppColors.grayDark,
    blueColor: AppColors.blueDark,
    langButtonColor: Color(0xff182229),
    langButtonLightColor: Color(0xff09140A),
    authAppBarTextColor: Color(0xffe9edef),
    photoIconBackgroundColor: Color(0xff283339),
    photoIconColor: Color(0xff61717b),
  );
  final Color? circleImageColor;
  final Color? grayColor;
  final Color? blueColor;
  final Color? langButtonColor;
  final Color? langButtonLightColor;
  final Color? authAppBarTextColor;
  final Color? photoIconBackgroundColor;
  final Color? photoIconColor;

  const CustomThemeExtension({
    this.circleImageColor,
    this.grayColor,
    this.blueColor,
    this.langButtonColor,
    this.langButtonLightColor,
    this.authAppBarTextColor,
    this.photoIconBackgroundColor,
    this.photoIconColor,
  });

  @override
  ThemeExtension<CustomThemeExtension> copyWith({
    Color? circleImageColor,
    Color? grayColor,
    Color? blueColor,
    Color? langButtonColor,
    Color? langButtonLightColor,
    Color? authAppBarTextColor,
    Color? photoIconBackgroundColor,
    Color? photoIconColor,
  }) {
    return CustomThemeExtension(
      circleImageColor: circleImageColor ?? this.circleImageColor,
      grayColor: grayColor ?? this.grayColor,
      blueColor: blueColor ?? this.blueColor,
      langButtonColor: langButtonColor ?? this.langButtonColor,
      langButtonLightColor: langButtonLightColor ?? this.langButtonLightColor,
      authAppBarTextColor: authAppBarTextColor ?? this.authAppBarTextColor,
      photoIconBackgroundColor:
          photoIconBackgroundColor ?? this.photoIconBackgroundColor,
      photoIconColor: photoIconColor ?? this.photoIconColor,
    );
  }

  @override
  ThemeExtension<CustomThemeExtension> lerp(
    covariant ThemeExtension<CustomThemeExtension>? other,
    double t,
  ) {
    if (other is! CustomThemeExtension) return this;
    {
      return CustomThemeExtension(
        circleImageColor: Color.lerp(
          circleImageColor,
          other.circleImageColor,
          t,
        ),
        grayColor: Color.lerp(grayColor, other.grayColor, t),
        blueColor: Color.lerp(blueColor, other.blueColor, t),
        authAppBarTextColor: Color.lerp(
          authAppBarTextColor,
          other.authAppBarTextColor,
          t,
        ),
        langButtonColor: Color.lerp(langButtonColor, other.langButtonColor, t),
        langButtonLightColor: Color.lerp(
          langButtonLightColor,
          other.langButtonLightColor,
          t,
        ),
        photoIconBackgroundColor: Color.lerp(
          photoIconBackgroundColor,
          other.photoIconBackgroundColor,
          t,
        ),
        photoIconColor: Color.lerp(photoIconColor, other.photoIconColor, t),
      );
    }
  }
}
