import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:information_about_location_inheritedwidget/data/city_from_coordinates/city_model.dart';

import 'package:latlong2/latlong.dart';

Future<CityModel> fetchCityModel(LatLng coord) async {
  final response = await http.get(Uri.parse(
      'http://api.openweathermap.org/geo/1.0/reverse?lat=${coord.latitude.toString()}&lon=${coord.longitude.toString()}&limit=5&appid=71ecff3581eaee9a512f2979e487432b'));

  if (response.statusCode == 200) {
    return CityModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load CityModel');
  }
}
