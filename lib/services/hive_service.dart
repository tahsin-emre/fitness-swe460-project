import 'package:fitness/models/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  HiveService._();
  static late Box preferences;
  static late Box<UserModel> userBox;
  // static late Box<ExerciseModel> exerciseBox;

  static Future initialize() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserModelAdapter());
    preferences = await Hive.openBox('preferences');
    userBox = await Hive.openBox<UserModel>('user');
    // exerciseBox = await Hive.openBox<ExerciseModel>('exercises');
  }
}
