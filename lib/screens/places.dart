import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/providers/places_provider.dart';
import 'package:favorite_places/screens/add_place.dart';
import 'package:favorite_places/screens/place_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesScreen extends ConsumerStatefulWidget {
  const PlacesScreen({super.key});

  @override
  ConsumerState<PlacesScreen> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends ConsumerState<PlacesScreen> {
  void openAddPlaceOverlay() {
    showModalBottomSheet(
        constraints: const BoxConstraints(
          maxWidth: double.infinity,
          minHeight: double.infinity,
        ),
        useSafeArea: true,
        context: context,
        builder: (ctx) => const AddPlaceScreen());
  }

  void selectPlace(PlaceItem place) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => PlaceDetailsScreen(place: place),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final places = ref.watch(placesProvider);

    Widget content = ListView.builder(
      itemCount: places.length,
      itemBuilder: (ctx, index) => ListTile(
        title: Text(places[index].title),
        onTap: () {
          selectPlace(places[index]);
        },
      ),
    );

    if (places.isEmpty) {
      content = const Center(
        child: Text("Nie dodano żadnych miejsc"),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista ulubionych miejsc: '),
        actions: [
          IconButton(
              onPressed: openAddPlaceOverlay, icon: const Icon(Icons.add))
        ],
      ),
      body: content,
    );
  }
}
