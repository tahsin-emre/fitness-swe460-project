import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  HiveService._();
  static Box? preferences;

  static Future initialize() async {
    await Hive.initFlutter();
  }
}
