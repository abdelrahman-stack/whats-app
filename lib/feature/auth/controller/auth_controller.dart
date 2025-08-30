import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whats_app_clone/feature/auth/repo/auth_repo.dart';

final authControllerProvider = Provider((ref) {
  final authRepo = ref.watch(authRepoProvider);
  return AuthController(authRepo: authRepo);
});

class AuthController {
  final AuthRepo authRepo;
  AuthController({required this.authRepo});
  void verfiySmsCode({
    required String smsCodeId,
    required String smsCode,
    required BuildContext context,
    required bool mounted,
  }) {
    authRepo.verfiySmsCode(
      smsCodeId: smsCodeId,
      smsCode: smsCode,
      context: context,
      mounted: mounted,
    );
  }

  void sendSmsCode({
    required String phoneNumber,
    required BuildContext context,
  }) {
    authRepo.sendSmsCode(phoneNumber: phoneNumber, context: context);
  }
}
