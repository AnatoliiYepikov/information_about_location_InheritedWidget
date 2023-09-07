import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:information_about_location_inheritedwidget/data/coordinates/coordinates.dart';
import 'package:information_about_location_inheritedwidget/logic/inherited_notifier.dart';
import 'package:information_about_location_inheritedwidget/widgets/button_widget/button_widget.dart';
import 'package:information_about_location_inheritedwidget/widgets/city_widget/city_widget.dart';
//import 'package:information_about_location_inheritedwidget/widgets/map_widget/map_widget.dart';
import 'package:information_about_location_inheritedwidget/widgets/solar_day_widget/solar_day_widget.dart';
import 'package:information_about_location_inheritedwidget/widgets/weather_widget/weather_widget.dart';

import 'package:latlong2/latlong.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  MapController mapController = MapController();

  @override
  Widget build(BuildContext context) {
    final CoordinatesState coordinatesState = CoordinatesState();
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: CoordinatesStateNotifier(
            coordinates: coordinatesState,
            child: Builder(builder: (context) {
              return CoordinatesStateNotifier(
                coordinates: coordinatesState,
                child: Builder(builder: (context) {
                  return Column(
                    children: [
                      const Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Flexible(child: CityWidget()),
                            Row(
                              children: [
                                Flexible(child: WeatherWidget()),
                                Flexible(child: SolarDayWidget()),
                              ],
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Row(
                                children: [
                                  LayoutBuilder(builder: (BuildContext context,
                                      BoxConstraints constraints) {
                                    return IconButton(
                                      iconSize: constraints.maxHeight,
                                      onPressed: () async {
                                        LatLng coord = await determinePosition()
                                            .then((value) => LatLng(
                                                value.latitude,
                                                value.longitude));
                                        Coordinates coordinates =
                                            Coordinates(coordinates: coord);

                                        coordinatesState
                                            .setCoordinates(coordinates);
                                        mapController.move(
                                            coord, mapController.zoom);
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
                                    mapController.move(
                                        point, mapController.zoom);
                                    Coordinates coordinates =
                                        Coordinates(coordinates: point);
                                    coordinatesState
                                        .setCoordinates(coordinates);
                                  },
                                  center: CoordinatesStateNotifier.of(context)
                                      .coordinates,
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
                                    urlTemplate:
                                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                    userAgentPackageName: 'com.example.app',
                                  ),
                                  MarkerLayer(
                                    markers: [
                                      Marker(
                                        point:
                                            CoordinatesStateNotifier.of(context)
                                                .coordinates!,
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
                        ),
                      ),
                    ],
                  );
                }),
              );
            }),
          ),
        ),
      ),
    );
  }
}

// class FirstPageWidgetModel extends ChangeNotifier {
//   LatLng coord = LatLng(42.7629600, 11.1094100);
// }

// class FirstPageWidgetProvider extends InheritedWidget {
//   final FirstPageWidgetModel model;
//   const FirstPageWidgetProvider(
//       {Key? key, required this.model, required Widget child})
//       : super(key: key, child: child);

//   static FirstPageWidgetProvider? of(BuildContext contex) {
//     return contex.dependOnInheritedWidgetOfExactType<FirstPageWidgetProvider>();
//   }

//   @override
//   bool updateShouldNotify(FirstPageWidgetProvider oldWidget) {
//     return model.coord != oldWidget.model.coord;
//   }
// }
