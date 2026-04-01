// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_collection_literals
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class WidgetMap extends StatelessWidget {
  const WidgetMap({
    super.key,
    this.latLng,
  });

  final LatLng? latLng;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
          target: latLng ?? const LatLng(20.031218147128953, 99.88016169746558),
          zoom: 12),
      onMapCreated: (controller) {},
      zoomControlsEnabled: false,
      markers: <Marker>[
        Marker(
            markerId: const MarkerId('value'),
            position:
                latLng ?? const LatLng(20.031218147128953, 99.88016169746558))
      ].toSet(),
    );
  }
}
