import 'package:fitness/models/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  HiveService._();
  static Box? preferences;
  static Box<UserModel>? userBox;

  static Future initialize() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserModelAdapter());
    preferences = await Hive.openBox('preferences');
    userBox = await Hive.openBox<UserModel>('user');
  }
}
