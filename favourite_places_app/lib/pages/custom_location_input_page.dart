import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class CustomLocationInputPage extends StatefulWidget {
  const CustomLocationInputPage({super.key});

  @override
  _MapPickerScreenState createState() => _MapPickerScreenState();
}

class _MapPickerScreenState extends State<CustomLocationInputPage> {
  LatLng? _selectedLocation; // Stores the selected location

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Location")),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: LatLng(20.5937, 78.9629), // Default: India
              initialZoom: 5,
              onTap: (tapPosition, point) {
                setState(() => _selectedLocation = point);
              },
            ),
            children: [
              // OpenStreetMap Tile Layer
              TileLayer(
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
                userAgentPackageName: 'com.example.app',
              ),
              if (_selectedLocation != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 40,
                      height: 40,
                      point: _selectedLocation!,
                      child: const Icon(Icons.location_pin, color: Colors.red, size: 40),
                    ),
                  ],
                ),
            ],
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: _selectedLocation == null
                  ? null
                  : () {
                      Navigator.pop(context, _selectedLocation);
                    },
              child: const Text("Confirm Location"),
            ),
          ),
        ],
      ),
    );
  }
}
