import 'dart:convert';

import 'package:all_meal_app/models/area_model.dart';
import 'package:http/http.dart' as http;

class FilterServices {
  static Future<List<AreaModel>> getAllAreas() async {
    final url = Uri.https('www.themealdb.com', 'api/json/v1/1/list.php', {
      'a': 'list',
    });

    final response = await http.get(url);

    final data = json.decode(response.body);

    final areaData = data['meals'];

    final List<AreaModel> areaList = [];

    for (final area in areaData) {
      areaList.add(AreaModel(area: area['strArea']));
    }
    return areaList;
  }
}
