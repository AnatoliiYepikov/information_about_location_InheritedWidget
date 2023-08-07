import 'package:flutter/material.dart';
import 'package:information_about_location_inheritedwidget/widgets/city_widget/city_widget.dart';
import 'package:information_about_location_inheritedwidget/widgets/map_widget/map_widget.dart';
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
  final FirstPageWidgetModel _model = FirstPageWidgetModel();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: FirstPageWidgetProvider(
            model: _model,
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      CityWidget(),
                      Row(
                        children: [
                          WeatherWidget(),
                          SolarDayWidget(),
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: MapWidget(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FirstPageWidgetModel extends ChangeNotifier {
  LatLng coord = LatLng(42.7629600, 11.1094100);
  LatLng coordCheck = LatLng(42.7629600, 11.1094100);
  void check() {
    if (coord != coordCheck) {
      coordCheck = coord;
      notifyListeners();
    }
  }
}

class FirstPageWidgetProvider extends InheritedWidget {
  final FirstPageWidgetModel model;
  const FirstPageWidgetProvider(
      {Key? key, required this.model, required Widget child})
      : super(key: key, child: child);

  static FirstPageWidgetProvider? of(BuildContext contex) {
    return contex.dependOnInheritedWidgetOfExactType<FirstPageWidgetProvider>();
  }

  @override
  bool updateShouldNotify(FirstPageWidgetProvider oldWidget) {
    return model != oldWidget.model;
  }
}
