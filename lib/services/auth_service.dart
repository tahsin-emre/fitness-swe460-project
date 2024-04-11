import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/core/enums/auth_enum.dart';
import 'package:fitness/models/user_model.dart';
import 'package:fitness/services/db.dart';
import 'package:fitness/services/user_service.dart';

class AuthService {
  AuthService._();
  static StreamController<AuthEnum> otpStream = StreamController();
  static String vid = '';
  static String error = '';

  static void init() {
    otpStream = StreamController();
    otpStream.sink.add(AuthEnum.phone);
  }

  static Future phoneVerify(String phoneNumber) async {
    try {
      await DB.auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          timeout: const Duration(seconds: 90),
          verificationCompleted: (credential) async {
            await DB.auth.signInWithCredential(credential);
            otpStream.sink.add(AuthEnum.success);
          },
          codeSent: (verificationId, token) {
            vid = verificationId;
            otpStream.sink.add(AuthEnum.otp);
          },
          verificationFailed: (FirebaseAuthException e) {
            error = e.code;
            log(e.toString());
            log('VERFAIL');
            otpStream.sink.add(AuthEnum.error);
          },
          codeAutoRetrievalTimeout: (a) {
            error = a;
            log('TIMEOUT');
            otpStream.sink.add(AuthEnum.error);
          });
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  static Future<UserModel?> otpVerify(String code) async {
    try {
      PhoneAuthCredential credential =
          PhoneAuthProvider.credential(verificationId: vid, smsCode: code);
      await DB.auth.signInWithCredential(credential);
      UserModel? result = await UserService.getUserModel();
      if (result != null) {
        otpStream.sink.add(AuthEnum.success);
      } else {
        otpStream.sink.add(AuthEnum.register);
      }
      return result;
    } on Exception catch (e) {
      log(e.toString());
      otpStream.sink.add(AuthEnum.error);
      return null;
    }
  }
}
