import 'dart:convert';

import 'package:favourite_places_app/pages/custom_location_input_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

import 'package:favourite_places_app/constants.dart';
import 'package:favourite_places_app/models/place_location_model.dart';

class LocationInputWidget extends StatefulWidget {
  const LocationInputWidget({
    super.key,
    required this.onSelectLocation,
  });

  final void Function(PlaceLocationModel location) onSelectLocation;

  @override
  State<LocationInputWidget> createState() => _LocationInputWidgetState();
}

class _LocationInputWidgetState extends State<LocationInputWidget> {
  PlaceLocationModel? _selectedLocationData;
  bool isFetchingLocation = false;
  LatLng? _customSelectedLocation;

  String get locationImage {
    final lat = _selectedLocationData!.latitude;
    final lon = _selectedLocationData!.longitude;
    final url =
        'https://maptoolkit.p.rapidapi.com/staticmap/?maptype=terrain&size=750x300&center=$lat,$lon&zoom=13&marker=center:$lat,$lon|anchor:bottom&rapidapi-key=${Constants.MAPTOOLKIT_API_KEY}';
    return url;
  }

  Future<String> getAddressFromLatLng(double latitude, double longitude) async {
    final url = Uri.https(
      'nominatim.openstreetmap.org',
      '/reverse',
      {
        'lat': latitude.toString(),
        'lon': longitude.toString(),
        'zoom': '10',
        'format': 'json',
      },
    );

    final response = await http.get(url);
    final data = json.decode(response.body);
    final address = data['display_name'] as String;
    return address;
  }

  void _getCurrentLocation() async {
    setState(() {
      isFetchingLocation = true;
      _selectedLocationData = null;
    });

    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();

    final address = await getAddressFromLatLng(
        locationData.latitude!, locationData.longitude!);
    setState(() {
      _selectedLocationData = PlaceLocationModel(
        address: address,
        latitude: locationData.latitude!,
        longitude: locationData.longitude!,
      );
      isFetchingLocation = false;
    });
  }

  void _getCustomLocation() async {
    final customSelectedLocation =
        await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return CustomLocationInputPage();
    }));

    final address = await getAddressFromLatLng(
        customSelectedLocation.latitude!, customSelectedLocation.longitude!);
    setState(() {
      _selectedLocationData = PlaceLocationModel(
        address: address,
        latitude: customSelectedLocation.latitude!,
        longitude: customSelectedLocation.longitude!,
      );
      isFetchingLocation = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget locationContent = Center(
      child: Text(
        'No Location Chosen Yet!!',
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
      ),
    );

    if (isFetchingLocation) {
      locationContent = Center(
        child: SizedBox(
          height: 50,
          width: 50,
          child: CircularProgressIndicator.adaptive(),
        ),
      );
    }
    if (_selectedLocationData != null) {
      widget.onSelectLocation(_selectedLocationData!);
      locationContent = Image.network(
        locationImage,
        fit: BoxFit.cover,
      );
    }
    //  else if (_selectedLocationData == null ) {
    //   locationContent = Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         Text(
    //           '  latitude  : ${_selectedLocationData?.latitude}',
    //           style: Theme.of(context).textTheme.bodyLarge!.copyWith(
    //                 color: Theme.of(context).colorScheme.onSurface,
    //               ),
    //         ),
    //         Text(
    //           'longitude : ${_selectedLocationData?.longitude}',
    //           style: Theme.of(context).textTheme.bodyLarge!.copyWith(
    //                 color: Theme.of(context).colorScheme.onSurface,
    //               ),
    //         ),
    //         Text(
    //           'Address : ${_selectedLocationData?.address}',
    //           style: Theme.of(context).textTheme.bodyLarge!.copyWith(
    //                 color: Theme.of(context).colorScheme.onSurface,
    //               ),
    //         ),
    //       ],
    //     ),
    //   );
    // }
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.primary.withAlpha(96),
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          width: double.infinity,
          height: 170,
          child: locationContent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              icon: Icon(Icons.location_on),
              label: Text(
                'Get Current Location',
              ),
              onPressed: () {
                _getCurrentLocation();
              },
            ),
            TextButton.icon(
              icon: Icon(Icons.map),
              label: Text(
                'Select Custom Location',
              ),
              onPressed: () {
                _getCustomLocation();
              },
            ),
          ],
        ),
      ],
    );
  }
}
/* 
{"place_id":230539542,"licence":"Data © OpenStreetMap contributors, ODbL 1.0. http://osm.org/copyright","osm_type":"relation","osm_id":10351626,"lat":"18.5213738","lon":"73.8545071","class":"boundary","type":"administrative","place_rank":12,"importance":0.635982384834216,"addresstype":"city","name":"Pune City","display_name":"Pune City, Pune, Maharashtra, India","address":{"city":"Pune City","state_district":"Pune","state":"Maharashtra","ISO3166-2-lvl4":"IN-MH","country":"India","country_code":"in"},"boundingbox":["18.4294970","18.6208699","73.7498473","74.0202140"]}

 */
