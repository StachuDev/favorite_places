import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class PlaceLocation {
  PlaceLocation(
      {required this.latitude, required this.longitude, required this.address});
  final double latitude;
  final double longitude;
  final String address;
}

class PlaceItem {
  PlaceItem({
    required this.title,
    required this.image,
    required this.location,
  }) : id = uuid.v4();

  final String title;
  final String id;
  final File image;
  final PlaceLocation location;
}
