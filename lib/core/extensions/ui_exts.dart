import 'package:flutter/material.dart';

extension UiExtensions on int {
  BorderRadius toRadiusAll() {
    return BorderRadius.all(Radius.circular(toDouble()));
  }

  EdgeInsets toEdgeAll() {
    return EdgeInsets.all(toDouble());
  }
}
