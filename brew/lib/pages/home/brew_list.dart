import 'package:brew/models/brew_model.dart';
import 'package:brew/pages/home/brew_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  const BrewList({super.key});

  @override
  State<BrewList> createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<BrewModel>>(context) ?? [];
    brews.forEach(
      (brew) {
        print(brew.name);
        print(brew.sugars);
        print(brew.strength);
      },
    );
    return ListView.builder(
        itemCount: brews.length, itemBuilder: (context, index) {
          return BrewTile(brew: brews[index]);
        });
  }
}
