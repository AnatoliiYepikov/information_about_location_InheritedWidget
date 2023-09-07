import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:information_about_location_inheritedwidget/data/coordinates/coordinates.dart';
import 'package:information_about_location_inheritedwidget/logic/inherited_notifier.dart';

import 'package:information_about_location_inheritedwidget/widgets/button_widget/button_widget.dart';
import 'package:latlong2/latlong.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  MapController mapController = MapController();

  @override
  Widget build(BuildContext context) {
    LatLng coord = CoordinatesStateNotifier.of(context).coordinates!;
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Row(
            children: [
              LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                return IconButton(
                  iconSize: constraints.maxHeight,
                  onPressed: () async {
                    CoordinatesStateNotifier.of(context).coordinates =
                        await determinePosition().then((LatLng position) {
                      return LatLng(position.latitude, position.longitude);
                    });
                    mapController.move(coord, mapController.zoom);
                    setState(() {});
                  },
                  icon: Image.asset(
                    'assets/icons/earth_arrow.png',
                  ),
                );
              }),
              const ButtonWidget(),
            ],
          ),
        ),
        Expanded(
          flex: 5,
          child: FlutterMap(
            mapController: mapController,
            options: MapOptions(
              onTap: (tapPosition, point) {
                mapController.move(point, mapController.zoom);
                CoordinatesStateNotifier.of(context).coordinates =
                    LatLng(point.latitude, point.longitude);
                setState(() {});
              },
              center: coord,
              zoom: 7,
              maxZoom: 18.0,
            ),
            nonRotatedChildren: [
              AttributionWidget.defaultWidget(
                source: 'OpenStreetMap contributors',
                onSourceTapped: null,
              ),
            ],
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: coord,
                    builder: (context) => const Icon(
                      Icons.pin_drop,
                      color: Colors.green,
                      size: 30.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
