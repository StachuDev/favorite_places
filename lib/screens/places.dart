import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/providers/places_provider.dart';
import 'package:favorite_places/screens/add_place.dart';
import 'package:favorite_places/screens/place_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesScreen extends ConsumerWidget {
  const PlacesScreen({super.key});
  // void openAddPlaceOverlay() {
  //   showModalBottomSheet(
  //       constraints: const BoxConstraints(
  //         maxWidth: double.infinity,
  //         minHeight: double.infinity,
  //       ),
  //       useSafeArea: true,
  //       context: context,
  //       builder: (ctx) => const AddPlaceScreen());
  // }

  void selectPlace(PlaceItem place, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => PlaceDetailsScreen(place: place),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final places = ref.watch(placesProvider);

    Widget content = ListView.builder(
      itemCount: places.length,
      itemBuilder: (ctx, index) => ListTile(
        title: Text(
          places[index].title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
        onTap: () {
          selectPlace(places[index], context);
        },
      ),
    );

    if (places.isEmpty) {
      content = Center(
        child: Text(
          "Nie dodano żadnych miejsc",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista ulubionych miejsc: '),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const AddPlaceScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: content,
    );
  }
}
