import 'package:fitness/core/enums/equipment_enum.dart';
import 'package:fitness/core/enums/gender_enum.dart';
import 'package:fitness/core/enums/muscle_enum.dart';
import 'package:fitness/models/exercise_model.dart';
import 'package:fitness/models/food_model.dart';
import 'package:fitness/models/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  HiveService._();
  static late Box preferences;
  static late Box<UserModel> userBox;
  static late Box<ExerciseModel> exerciseBox;
  static late Box<FoodModel> foodBox;

  static Future initialize() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(ExerciseModelAdapter());
    Hive.registerAdapter(EquipmentsAdapter());
    Hive.registerAdapter(GendersAdapter());
    Hive.registerAdapter(MusclesAdapter());
    Hive.registerAdapter(FoodModelAdapter());
    preferences = await Hive.openBox('preferences');
    userBox = await Hive.openBox<UserModel>('user');
    exerciseBox = await Hive.openBox<ExerciseModel>('exercises');
    foodBox = await Hive.openBox<FoodModel>('foods');
  }
}
