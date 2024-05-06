import 'dart:convert';
import 'dart:developer';

import 'package:fitness/gitsecret/api_options.dart';
import 'package:fitness/models/food_model.dart';
import 'package:fitness/services/hive_service.dart';
import 'package:http/http.dart' as http;

class FoodService {
  static Future foodReq(String query) async {
    Uri uri = Uri.parse('https://api.calorieninjas.com/v1/nutrition?query=$query');
    var response = await http.get(uri, headers: {'X-Api-Key': ApiOptions.calorieApiKey});
    log(response.body);
    HiveService.foodBox.add(
      FoodModel.fromApi(
        jsonDecode(response.body),
      ),
    );
  }

  static Future getUserFoods() async {}
}
