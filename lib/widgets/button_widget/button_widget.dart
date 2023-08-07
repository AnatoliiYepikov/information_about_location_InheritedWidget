import 'package:flutter/material.dart';
import 'package:information_about_location_inheritedwidget/main.dart';
import 'package:latlong2/latlong.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    LatLng coord = FirstPageWidgetProvider.of(context)!.model.coord;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        const Text(
          'Take the current position.',
          textAlign: TextAlign.left,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Text(
          'Latitude: ${double.parse(coord.latitude.toStringAsFixed(7))}',
          textAlign: TextAlign.left,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Text(
          'Longitude: ${double.parse(coord.longitude.toStringAsFixed(7))}',
          textAlign: TextAlign.left,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ],
    );
  }
}
