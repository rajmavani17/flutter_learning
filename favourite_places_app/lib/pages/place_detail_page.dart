import 'package:favourite_places_app/constants.dart';
import 'package:flutter/material.dart';

import 'package:favourite_places_app/models/place_model.dart';

class PlaceDetailPage extends StatelessWidget {
  final PlaceModel place;

  const PlaceDetailPage({
    super.key,
    required this.place,
  });

  String get locationImage {
    final lat = place.location.latitude;
    final lon = place.location.longitude;
    final url =
        'https://maptoolkit.p.rapidapi.com/staticmap/?maptype=terrain&size=750x300&center=$lat,$lon&zoom=13&marker=center:$lat,$lon|anchor:bottom&rapidapi-key=${Constants.MAPTOOLKIT_API_KEY}';
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Stack(
        children: [
          Hero(
            tag: place.id,
            child: Image.file(
              place.image,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundImage: NetworkImage(locationImage),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.black54,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Text(
                    place.location.address,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/* 
Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 600,
          width: double.infinity,
          child: Image.file(place.image),
        ),
      ),
 */
