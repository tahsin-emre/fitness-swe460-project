import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:fitness/core/base/routes.dart';
import 'package:fitness/gitsecret/firebase_options.dart';
import 'package:fitness/models/user_model.dart';
import 'package:fitness/services/auth_service.dart';
import 'package:fitness/services/hive_service.dart';
import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    initializeApp().then((value) {
      if (value != null) {
        Navigator.pushNamedAndRemoveUntil(context, value, (route) => false);
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('SPLASH'),
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Future<String?> initializeApp() async {
    // ConnectivityResult cnnct = await Connectivity().checkConnectivity();
    try {
      await HiveService.initialize();
      HiveService.userBox.clear();
      await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
      UserModel? userModel = await AuthService.getUserModel();
      if (userModel == null) {
        return Routes.auth;
      } else {
        // HiveService.userBox.put(0, userModel);
        return Routes.home;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }
}
