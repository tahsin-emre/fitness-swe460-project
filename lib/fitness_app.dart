import 'package:easy_localization/easy_localization.dart';
import 'package:fitness/core/base/app_theme.dart';
import 'package:fitness/core/base/routes.dart';
import 'package:fitness/core/constants/texts.dart';
import 'package:flutter/material.dart';

class FitnessApp extends StatelessWidget {
  const FitnessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      title: Texts.fitnessapp,
      initialRoute: Routes.splash,
      theme: appTheme,
      onGenerateRoute: (settings) => Routes.onGenerateRoute(settings),
    );
  }
}
