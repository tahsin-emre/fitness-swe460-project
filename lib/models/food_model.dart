class FoodModel {
  String name = '';
  num gram = 0;
  num calorie = 0;
  num fat = 0;
  num carb = 0;
  num protein = 0;

  FoodModel();

  FoodModel.fromUser(this.name, this.calorie, this.fat, this.carb, this.protein);
}
