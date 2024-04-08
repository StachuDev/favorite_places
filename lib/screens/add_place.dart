import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/providers/places_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _titleController = TextEditingController();

  void onSubmitPlace() {
    if (_titleController.text.trim().isEmpty) {
      // show Dialog
      return;
    }
    // ubdate riverpod global state
    // add new PlaceItem to List
    ref
        .read(placesProvider.notifier)
        .addPlace(PlaceItem(title: _titleController.text));

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(label: Text('title')),
          controller: _titleController,
        ),
        ElevatedButton.icon(
          icon: const Icon(Icons.add),
          onPressed: onSubmitPlace,
          label: const Text('Dodaj miejsce'),
        ),
      ],
    );
  }
}
