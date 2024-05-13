import 'package:easy_localization/easy_localization.dart';
import 'package:fitness/core/constants/locales.dart';
import 'package:flutter/material.dart';

class LanguageSelectorView extends StatelessWidget {
  const LanguageSelectorView({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (context.locale == Locales.en) {
          context.setLocale(Locales.tr);
        } else {
          context.setLocale(Locales.en);
        }
      },
      icon: const Icon(Icons.translate),
    );
  }
}
