import 'package:flutter/material.dart';
import 'package:information_about_location_inheritedwidget/data/city_from_coordinates/city_model.dart';

import 'package:information_about_location_inheritedwidget/logic/inherited_notifier.dart';

class CityWidget extends StatelessWidget {
  const CityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    CityModel cityModel = CoordinatesStateNotifier.of(context).cityModel ??
        CityModel(city: 'unloaded', country: 'unloaded');

    if (cityModel.country == '') {
      return const Text('unknown location',
          style: TextStyle(fontSize: 22), textAlign: TextAlign.center);
    } else {
      return Text('Country: ${cityModel.country}     City: ${cityModel.city}',
          style: const TextStyle(fontSize: 22), textAlign: TextAlign.center);
    }
  }
}
