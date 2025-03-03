// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';


class MapPage extends StatefulWidget {
  const MapPage({
    super.key,
    this.location,
    this.isSelecting,
  });

  final location;
  final isSelecting;

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.isSelecting
            ? Text('Pick Your Location')
            : Text('Your Location'),
        actions: [
          if (widget.isSelecting)
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.save),
            ),
        ],
      ),
    );
  }
}
