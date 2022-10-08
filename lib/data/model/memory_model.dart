import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MemoryModel{
  final LatLng position;
  final ImageProvider image;
  final String link;
  final int num;

  MemoryModel(this.position, this.image, this.link, this.num);
}