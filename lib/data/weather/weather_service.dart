import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:information_about_location_inheritedwidget/data/weather/weather_model.dart';
import 'package:latlong2/latlong.dart';

Future<WeatherModel> fetchWeatherModel(LatLng coord) async {
  final response = await http.get(Uri.parse(
      'http://api.openweathermap.org/data/2.5/weather?lat=${coord.latitude.toString()}&lon=${coord.longitude.toString()}&APPID=71ecff3581eaee9a512f2979e487432b'));

  if (response.statusCode == 200) {
    return WeatherModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load WeatherModel');
  }
}
