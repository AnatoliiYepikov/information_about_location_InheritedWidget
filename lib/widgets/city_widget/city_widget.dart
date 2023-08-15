import 'package:flutter/material.dart';
import 'package:information_about_location_inheritedwidget/data/city_from_coordinates/city_model.dart';
import 'package:information_about_location_inheritedwidget/data/city_from_coordinates/city_service.dart';
import 'package:information_about_location_inheritedwidget/main.dart';

import 'package:latlong2/latlong.dart';

class CityWidget extends StatelessWidget {
  const CityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    LatLng coord = FirstPageWidgetProvider.of(context)!.model.coord;
    return FutureBuilder<CityModel>(
        future: fetchCityModel(coord),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.country == '') {
              return const Text('unknown location',
                  style: TextStyle(fontSize: 22), textAlign: TextAlign.center);
            } else {
              return Text(
                  'Country: ${snapshot.data!.country}     City: ${snapshot.data!.city}',
                  style: const TextStyle(fontSize: 22),
                  textAlign: TextAlign.center);
            }
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          return const CircularProgressIndicator();
        });
  }
}

// class CityWidget extends StatefulWidget {
//   const CityWidget({super.key});

//   @override
//   State<CityWidget> createState() => _CityWidgetState();
// }

// class _CityWidgetState extends State<CityWidget> {
//   @override
//   Widget build(BuildContext context) {
//     LatLng coord = FirstPageWidgetProvider.of(context)!.model.coord;
//     return FutureBuilder<CityModel>(
//         future: fetchCityModel(coord),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             if (snapshot.data!.country == '') {
//               return const Text('unknown location',
//                   style: TextStyle(fontSize: 22), textAlign: TextAlign.center);
//             } else {
//               return Text(
//                   'Country: ${snapshot.data!.country}     City: ${snapshot.data!.city}',
//                   style: const TextStyle(fontSize: 22),
//                   textAlign: TextAlign.center);
//             }
//           } else if (snapshot.hasError) {
//             return Text('${snapshot.error}');
//           }

//           return const CircularProgressIndicator();
//         });
//   }
// }
