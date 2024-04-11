import 'dart:developer';

import 'package:http/http.dart' as http;

class FoodService {
  static Future foodReq() async {
    Uri uri = Uri.parse('');
    var response = await http.get(uri);
    log(response.body);
  }
}
