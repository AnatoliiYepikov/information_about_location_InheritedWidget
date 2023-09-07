import 'package:flutter/material.dart';
import 'package:information_about_location_inheritedwidget/data/weather/weather_model.dart';

import 'package:information_about_location_inheritedwidget/logic/inherited_notifier.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    WeatherModel weatherModel =
        CoordinatesStateNotifier.of(context).weatherModel ??
            WeatherModel(
                temp: 'unloaded',
                description: 'unloaded',
                currently: 'unloaded',
                humidity: 'unloaded',
                windSpeed: 'unloaded');
    if (weatherModel.temp == 'unloaded') {
      return const Text('unloaded information',
          style: TextStyle(fontSize: 22), textAlign: TextAlign.center);
    } else {
      return Column(
        children: [
          const Text(
            'TEMP:',
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          Text(
            'Description: ${weatherModel.description}',
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          Text(
            'Currently: ${weatherModel.currently}',
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          Text(
            'Humidity: ${weatherModel.humidity}',
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          Text(
            'WindSpeed: ${weatherModel.windSpeed}',
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      );
    }
  }
}
