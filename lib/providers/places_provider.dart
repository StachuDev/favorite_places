import 'package:favorite_places/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesNotifier extends StateNotifier<List<PlaceItem>> {
  PlacesNotifier() : super(const []);

  void addPlace(PlaceItem place) {
    state = [place, ...state].toList();
  }
}

final placesProvider =
    StateNotifierProvider<PlacesNotifier, List<PlaceItem>>((ref) {
  return PlacesNotifier();
});
