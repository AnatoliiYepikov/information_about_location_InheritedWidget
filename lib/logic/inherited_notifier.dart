import 'package:flutter/material.dart';
import 'package:information_about_location_inheritedwidget/data/city_from_coordinates/city_model.dart';
import 'package:information_about_location_inheritedwidget/data/city_from_coordinates/city_service.dart';

import 'package:information_about_location_inheritedwidget/data/solar_day/solar_day_model.dart';
import 'package:information_about_location_inheritedwidget/data/solar_day/solar_day_service.dart';
import 'package:information_about_location_inheritedwidget/data/weather/weather_model.dart';
import 'package:information_about_location_inheritedwidget/data/weather/weather_service.dart';
import 'package:latlong2/latlong.dart';

class Coordinates {
  LatLng? coordinates;
  CityModel? cityModel;
  SolarDayModel? solarDayModel;
  WeatherModel? weatherModel;
  Coordinates(
      {this.coordinates,
      this.cityModel,
      this.solarDayModel,
      this.weatherModel});
}

class CoordinatesState with ChangeNotifier {
  Coordinates _coordinates = Coordinates(coordinates: LatLng(42, 11));
  Coordinates get coordinates => _coordinates;

  void setCoordinates(Coordinates updateCoordinates) async {
    final CityModel cityModel =
        await fetchCityModel(updateCoordinates.coordinates!);
    final SolarDayModel solarDayModel =
        await fetchSolarDayModel(updateCoordinates.coordinates!);
    final WeatherModel weatherModel =
        await fetchWeatherModel(updateCoordinates.coordinates!);
    _coordinates = Coordinates(
        coordinates: updateCoordinates.coordinates,
        cityModel: cityModel,
        solarDayModel: solarDayModel,
        weatherModel: weatherModel);
    notifyListeners();
  }
}

class CoordinatesStateNotifier extends InheritedNotifier<CoordinatesState> {
  const CoordinatesStateNotifier(
      {super.key, required super.child, required CoordinatesState coordinates})
      : super(notifier: coordinates);

  static Coordinates of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<CoordinatesStateNotifier>()!
        .notifier!
        .coordinates;
  }

  @override
  bool updateShouldNotify(
      covariant InheritedNotifier<CoordinatesState> oldWidget) {
    return notifier!.coordinates != oldWidget.notifier!.coordinates;
  }
}
