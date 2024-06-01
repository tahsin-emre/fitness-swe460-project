import 'package:easy_localization/easy_localization.dart';
import 'package:fitness/core/constants/locales.dart';
import 'package:fitness/core/constants/paths.dart';
import 'package:fitness/fitness_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locales.en,
        Locales.tr,
        Locales.de,
        Locales.fr,
      ],
      saveLocale: true,
      path: Paths.localePath,
      useOnlyLangCode: true,
      child: const FitnessApp(),
    ),
  );
}
