import 'package:favourite_places_app/pages/add_place_page.dart';
import 'package:favourite_places_app/providers/places_provider.dart';
import 'package:favourite_places_app/widgets/places_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlaceListPage extends ConsumerStatefulWidget {
  const PlaceListPage({super.key});

  @override
  ConsumerState<PlaceListPage> createState() => _PlaceListPageState();
}

class _PlaceListPageState extends ConsumerState<PlaceListPage> {
  late Future<void> _placesFuture;

  @override
  void initState() {
    super.initState();
    _placesFuture = ref.read(placeProvider.notifier).loadPlace();
  }

  void _addNewPlacePage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return AddPlacePage();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final placesList = ref.watch(placeProvider);

    Widget content = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: FutureBuilder(
        future: _placesFuture,
        builder: (context,snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator.adaptive(),);
          }
          return PlacesListWidget(
            placesList: placesList,
          );
        }
      ),
    );

    if (placesList.isEmpty) {
      content = Center(
        child: Text(
          'No Places Added yet!!',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Favourite Places'),
        actions: [
          IconButton(
            onPressed: _addNewPlacePage,
            icon: Icon(
              Icons.add,
            ),
            tooltip: 'Add',
          ),
        ],
      ),
      body: content,
    );
  }
}
