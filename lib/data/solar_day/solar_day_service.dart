import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:information_about_location_inheritedwidget/data/solar_day/solar_day_model.dart';

import 'package:latlong2/latlong.dart';

Future<SolarDayModel> fetchSolarDayModel(LatLng coord) async {
  var response = await http.get(Uri.parse(
      'https://api.sunrise-sunset.org/json?lat=${coord.latitude.toString()}&lng=${coord.longitude.toString()}'));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return SolarDayModel.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load SolarDayModel');
  }
}
