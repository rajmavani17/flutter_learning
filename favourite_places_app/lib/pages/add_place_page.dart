import 'dart:io';

import 'package:favourite_places_app/models/place_location_model.dart';
import 'package:favourite_places_app/providers/places_provider.dart';
import 'package:favourite_places_app/widgets/image_input_widget.dart';
import 'package:favourite_places_app/widgets/location_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlacePage extends ConsumerStatefulWidget {
  const AddPlacePage({super.key});

  @override
  ConsumerState<AddPlacePage> createState() => _AddPlacePageState();
}

class _AddPlacePageState extends ConsumerState<AddPlacePage> {
  final TextEditingController _titleEditingController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  File? _selectedImage;
  PlaceLocationModel? _selectedLocation;

  @override
  void dispose() {
    _titleEditingController.dispose();
    super.dispose();
  }

  void onSelectImage(File? image) {
    if (image != null) {
      _selectedImage = image;
    }
  }

  void onSelectLocation(PlaceLocationModel? location) {
    if (location != null) {
      _selectedLocation = location;
    }
  }

  @override
  Widget build(BuildContext context) {
    void addNewPlace() {
      final title = _titleEditingController.text.trim();

      if (_formkey.currentState!.validate()) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('New Place Added Successfully')),
        );
        if (_selectedImage != null && _selectedLocation != null) {
          ref.read(placeProvider.notifier).addPlace(
                title: title,
                image: _selectedImage!,
                location: _selectedLocation!,
              );
        }
        Navigator.of(context).pop();
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Place'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                TextFormField(
                  controller: _titleEditingController,
                  decoration: InputDecoration(
                    label: Text('Title'),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1),
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  autofocus: true,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter a valid name please';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 8,
                ),
                //image input
                ImageInputWidget(
                  onSelectImage: onSelectImage,
                ),
                SizedBox(
                  height: 8,
                ),
                LocationInputWidget(
                  onSelectLocation: onSelectLocation,
                ),
                SizedBox(
                  height: 8,
                ),
                ElevatedButton.icon(
                  onPressed: addNewPlace,
                  style: ButtonStyle(),
                  icon: Icon(
                    Icons.add,
                  ),
                  label: Text(
                    'Add New Place',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
