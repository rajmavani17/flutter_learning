import 'package:all_meal_app/models/area_model.dart';
import 'package:all_meal_app/services/filter_services.dart';
import 'package:flutter/material.dart';

class FilterProvider extends ChangeNotifier {
  List<AreaModel> areas = [];

  Future<void> getAllAreas() async {
    areas = await FilterServices.getAllAreas();
  }

  bool isAreasPresent() {
    return areas.isNotEmpty;
  }
}
