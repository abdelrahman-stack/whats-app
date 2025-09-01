import 'package:flutter/material.dart';
import 'package:whats_app_clone/feature/auth/views/home_view.dart';
import 'package:whats_app_clone/feature/auth/views/login_view.dart';
import 'package:whats_app_clone/feature/auth/views/user_info_view.dart';
import 'package:whats_app_clone/feature/auth/views/verification_view.dart';
import 'package:whats_app_clone/feature/welcome/views/welcome_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case WelcomeView.routeName:
      return MaterialPageRoute(builder: (context) => const WelcomeView());
    case LoginView.routeName:
      return MaterialPageRoute(builder: (context) => const LoginView());

    case VerificationView.routeName:
  final args = settings.arguments as Map<String, dynamic>?; // nullable
  if (args == null) {
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Center(child: Text("No arguments passed")),
      ),
    );
  }
  return MaterialPageRoute(
    builder: (context) => VerificationView(
      phoneNumber: args['phoneNumber'] as String? ?? "",
      verificationId: args['verificationId'] as String? ?? "",
    ),
  );

    case UserInfoView.routeName:
      return MaterialPageRoute(builder: (context) => const UserInfoView());
        case HomeView.routeName:
      return MaterialPageRoute(builder: (context) => const HomeView());


    default:
      return MaterialPageRoute(builder: (context) => const Scaffold());
  }
}
