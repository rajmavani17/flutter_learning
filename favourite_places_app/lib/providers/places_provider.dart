import 'dart:ffi';
import 'dart:io';

import 'package:favourite_places_app/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:favourite_places_app/models/place_location_model.dart';
import 'package:favourite_places_app/models/place_model.dart';

Future<sqflite.Database> _getDatabase() async {
  final dbPath = await sqflite.getDatabasesPath();
  print(dbPath);
  final db = await sqflite.openDatabase(
    path.join(dbPath, Constants.DB_NAME),
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT,image TEXT, lat REAL, lng REAL, address Text)');
    },
    version: 1,
  );
  return db;
}

class PlacesNotifier extends StateNotifier<List<PlaceModel>> {
  PlacesNotifier() : super([]);

  Future<void> loadPlace() async {
    final db = await _getDatabase();
    final data = await db.query('user_places');

    final List<PlaceModel> places = data.map((row) {
      return PlaceModel(
        id: row['id'] as String,
        title: row['title'] as String,
        image: File(row['image'] as String),
        location: PlaceLocationModel(
          address: row['address'] as String,
          latitude: row['lat'] as double,
          longitude: row['lng'] as double,
        ),
      );
    }).toList();

    state = places;
  }

  void addPlace({
    required String title,
    required File image,
    required PlaceLocationModel location,
  }) async {
    final appDir = await syspath.getApplicationDocumentsDirectory();
    final filename = path.basename(image.path);
    final copyPath = '${appDir.path}/$filename';
    final updatedImage = await image.copy(copyPath);

    final PlaceModel model = PlaceModel(
      title: title,
      image: updatedImage,
      location: location,
    );

    final db = await _getDatabase(); 
  

    db.insert('user_places', {
      'id': model.id,
      'title': model.title,
      'image': model.image.path,
      'address': model.location.address,
      'lat': model.location.latitude,
      'lng': model.location.longitude,
    });
    state = [model, ...state];
  }
}

final placeProvider =
    StateNotifierProvider<PlacesNotifier, List<PlaceModel>>((ref) {
  return PlacesNotifier();
});
