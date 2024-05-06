import 'package:fitness/core/constants/hive_types.dart';
import 'package:hive_flutter/adapters.dart';

part 'food_model.g.dart';

@HiveType(typeId: HiveTypes.foodModel)
class FoodModel {
  @HiveField(0)
  String name = '';
  @HiveField(1)
  num gram = 0;
  @HiveField(2)
  num calorie = 0;
  @HiveField(3)
  num fat = 0;
  @HiveField(4)
  num carb = 0;
  @HiveField(5)
  num protein = 0;

  FoodModel();

  FoodModel.fromApi(Map response) {
    var data = response['items'][0] as dynamic;
    name = data['name'] ?? 'NAME';
    gram = data['serving_size_g'] ?? 5;
    calorie = data['calories'] ?? 5;
    fat = data['fat_total_g'];
    carb = data['carbohydrates_total_g'];
    protein = data['protein_g'];
  }

  FoodModel.fromUser(this.name, this.calorie, this.fat, this.carb, this.protein);
}
