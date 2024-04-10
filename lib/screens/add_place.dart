import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/providers/places_provider.dart';
import 'package:favorite_places/widgets/image_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _titleController = TextEditingController();

  void _showDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Niewłaściwe dane'),
        content: const Text('Upewnij się, że wprowadzone dane są poprawne!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
            },
            child: Text(
              "Okej",
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onSecondary),
            ),
          ),
        ],
      ),
    );
  }

  void onSubmitPlace() {
    if (_titleController.text.trim().isEmpty) {
      _showDialog();
      return;
    }
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dodaj nowe miejsce'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onBackground),
              decoration: const InputDecoration(labelText: 'title'),
              controller: _titleController,
            ),
            const SizedBox(height: 10),
            const ImageInput(),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: onSubmitPlace,
              icon: const Icon(Icons.add),
              label: const Text('Dodaj miejsce'),
            ),
          ],
        ),
      ),
    );
  }
}
