import 'package:brew/models/brew_model.dart';
import 'package:flutter/material.dart';

class BrewTile extends StatelessWidget {
  final BrewModel brew;
  const BrewTile({super.key, required this.brew});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(
              'assets/coffee_icon.png',
            ),
            radius: 25,
            backgroundColor: Colors.brown[brew.strength ?? 0],
          ),
          title: Text(
            brew.name ?? '',
          ),
          subtitle: Text(
            "Takes ${brew.sugars} sugar(s)",
          ),
        ),
      ),
    );
  }
}
