import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whats_app_clone/core/helper/show_alert_dialog.dart';
import 'package:whats_app_clone/feature/auth/views/user_info_view.dart';
import 'package:whats_app_clone/feature/auth/views/verification_view.dart';

final authRepoProvider = Provider((ref) {
  return AuthRepo(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  );
});

class AuthRepo {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthRepo({required this.auth, required this.firestore});

  void verfiySmsCode({
    required String smsCodeId,
    required String smsCode,
    required BuildContext context,
    required bool mounted,
  }) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: smsCodeId,
        smsCode: smsCode, 
      );
      await auth.signInWithCredential(credential);
      if (!mounted) return;
      Navigator.of(
        context,
      ).pushNamedAndRemoveUntil(UserInfoView.routeName, (route) => false);
    } on FirebaseAuth catch (e) {
      showAlertDialog(context: context, message: e.toString());
    }
  }

  void sendSmsCode({
    required String phoneNumber,
    required BuildContext context,
  }) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (e) {
          showAlertDialog(context: context, message: e.toString());
        },
        codeSent: (smsCodeId, resendSmsCodeId) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            VerificationView.routeName,
            (route) => false,
            arguments: {'phoneNumber': phoneNumber, 'verificationId': smsCodeId},
          );
        },
        codeAutoRetrievalTimeout: (String smsCodeId) {},
      );
    } on FirebaseAuth catch (e) {
      showAlertDialog(context: context, message: e.toString());
    }
  }
}
