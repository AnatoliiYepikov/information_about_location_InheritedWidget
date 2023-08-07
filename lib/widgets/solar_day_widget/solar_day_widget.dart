import 'package:flutter/material.dart';
import 'package:information_about_location_inheritedwidget/data/solar_day/solar_day_model.dart';
import 'package:information_about_location_inheritedwidget/data/solar_day/solar_day_service.dart';
import 'package:information_about_location_inheritedwidget/main.dart';

import 'package:latlong2/latlong.dart';

class SolarDayWidget extends StatelessWidget {
  const SolarDayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    LatLng coord = FirstPageWidgetProvider.of(context)!.model.coord;
    return FutureBuilder<SolarDayModel>(
      future: fetchSolarDayModel(coord),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              const Text(
                'Solar day:',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              Text(
                'Sunrise: ${snapshot.data!.sunrise}',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              Text(
                'Sunset: ${snapshot.data!.sunset}',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              Text(
                'SolarNoon: ${snapshot.data!.solarNoon}',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              Text(
                'DayLength: ${snapshot.data!.dayLength}',
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
