import 'package:easy_localization/easy_localization.dart';
import 'package:fitness/core/constants/locales.dart';
import 'package:fitness/core/extensions/string_exts.dart';
import 'package:restart_app/restart_app.dart';
import 'package:flutter/material.dart';

class LanguageSelectorView extends StatelessWidget {
  const LanguageSelectorView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) {
        return [
          ...Locales.list.map(
            (e) => PopupMenuItem(
              value: e,
              child: Row(children: [
                e.toFlag(),
                const SizedBox(width: 10),
                Text(
                  e.languageCode.toUpperCase(),
                  style: const TextStyle(fontSize: 18),
                ),
              ]),
            ),
          )
        ];
      },
      onSelected: (value) {
        context.setLocale(value);
        Restart.restartApp();
      },
      icon: const Icon(Icons.translate),
    );
  }
}
