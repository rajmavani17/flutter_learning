import 'dart:io';

import 'package:favourite_places_app/models/place_location_model.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class PlaceModel {
  final String id;
  final String title;
  final File image;
  final PlaceLocationModel location;

  PlaceModel({
    required this.title,
    required this.image,
    required this.location,
    String? id,
  }) : id = id ?? uuid.v4();
}
