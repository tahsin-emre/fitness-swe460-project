import 'package:firebase_core/firebase_core.dart';
import 'package:fitness/core/base/routes.dart';
import 'package:fitness/gitsecret/firebase_options.dart';
import 'package:fitness/services/hive_service.dart';
import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SPLASH'),
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Future<String> initializeApp() async {
    // ConnectivityResult cnnct = await Connectivity().checkConnectivity();
    await HiveService.initialize();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    // UserModel? userModel = await AuthService.getUserModel();
    // if (userModel == null) {
    //   return Routes.auth;
    // } else {
    //   // up.userLogin(userModel);
    //   // HiveService.userBox!.put(0, userModel);
    //   // await BookService.getBooks();
    //   // await DictService.getDict();
    //   // await WordListService.getLists();
    //   // await ProgressService.getProgress();
    //   return Routes.home;
    // }
    return Routes.splash;
  }
}
