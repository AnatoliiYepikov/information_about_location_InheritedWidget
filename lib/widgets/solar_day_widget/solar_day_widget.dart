import 'package:flutter/material.dart';
import 'package:information_about_location_inheritedwidget/data/solar_day/solar_day_model.dart';

import 'package:information_about_location_inheritedwidget/logic/inherited_notifier.dart';

class SolarDayWidget extends StatelessWidget {
  const SolarDayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    SolarDayModel solarDayModel =
        CoordinatesStateNotifier.of(context).solarDayModel ??
            SolarDayModel(
                sunrise: 'unloaded',
                sunset: 'unloaded',
                solarNoon: 'unloaded',
                dayLength: 'unloaded');
    if (solarDayModel.dayLength == 'unloaded') {
      return const Text('unloaded information',
          style: TextStyle(fontSize: 22), textAlign: TextAlign.center);
    } else {
      return Column(
        children: [
          const Text(
            'Solar day:',
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          Text(
            'Sunrise: ${solarDayModel.sunrise}',
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          Text(
            'Sunset: ${solarDayModel.sunset}',
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          Text(
            'SolarNoon: ${solarDayModel.solarNoon}',
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          Text(
            'DayLength: ${solarDayModel.dayLength}',
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      );
    }
  }
}
