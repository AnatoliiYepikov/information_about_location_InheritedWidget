import 'package:flutter/material.dart';
import 'package:information_about_location_inheritedwidget/data/weather/weather_model.dart';
import 'package:information_about_location_inheritedwidget/data/weather/weather_service.dart';
import 'package:information_about_location_inheritedwidget/main.dart';

import 'package:latlong2/latlong.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    LatLng coord = FirstPageWidgetProvider.of(context)!.model.coord;

    return FutureBuilder<WeatherModel>(
      future: fetchWeatherModel(coord),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              const Text(
                'TEMP:',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              Text(
                'Description: ${snapshot.data!.description}',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              Text(
                'Currently: ${snapshot.data!.currently}',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              Text(
                'Humidity: ${snapshot.data!.humidity}',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              Text(
                'WindSpeed: ${snapshot.data!.windSpeed}',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
