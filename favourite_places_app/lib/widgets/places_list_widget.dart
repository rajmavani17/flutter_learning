import 'package:flutter/material.dart';

import 'package:favourite_places_app/models/place_model.dart';
import 'package:favourite_places_app/pages/place_detail_page.dart';

class PlacesListWidget extends StatelessWidget {
  const PlacesListWidget({
    super.key,
    required this.placesList,
  });
  final List<PlaceModel> placesList;

  void _navigateToPlaceDetailPage(BuildContext context, PlaceModel place) {
    Navigator.of(context).push(
      // MaterialPageRoute(
      //   builder: (context) {
      //     return PlaceDetailPage(place: place);
      //   },
      // ),
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 450), // Smoother animation
        pageBuilder: (_, animation, secondaryAnimation) => PlaceDetailPage(
          place: place,
        ),
        transitionsBuilder: (_, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: placesList.length,
      itemBuilder: (context, index) {
        final place = placesList[index];
        return ListTile(
          title: Text(
            place.title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
          subtitle: Text(
            place.location.address,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
          leading: Hero(
            tag: place.id,
            child: CircleAvatar(
              backgroundImage: FileImage(place.image),
              radius: 25,
            ),
          ),
          onTap: () {
            _navigateToPlaceDetailPage(context, place);
          },
        );
      },
    );
  }
}
