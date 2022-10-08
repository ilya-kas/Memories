import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Memory{
  LatLng position;
  ImageProvider? image;

  Memory.noImage(this.position);
  Memory(this.position, this.image);
}