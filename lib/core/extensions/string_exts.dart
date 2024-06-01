import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

extension UiExtensions on Locale {
  Flag toFlag() {
    return Flag(switch (languageCode) {
      'en' => Flags.united_kingdom,
      'tr' => Flags.turkey,
      'de' => Flags.germany,
      'fr' => Flags.france,
      _ => Flags.turkey,
    });
  }
}
