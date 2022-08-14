import 'package:cuaca/constraints.dart';
import 'package:cuaca/model/main_weahter_model.dart';
import 'package:flutter/material.dart';

class HeaderCuaca extends StatelessWidget {
  const HeaderCuaca({Key? key, required this.mainWeather, required this.name})
      : super(key: key);
  final MainWeather mainWeather;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              children: [
                Text('Selamat ${greeting()} $name'),
                Text(
                  '${(mainWeather.main.temp - 273.15).toStringAsFixed(2)} °C',
                  style: const TextStyle(fontSize: 35),
                )
              ],
            ),
            Column(
              children: [
                Text(mainWeather.weather[0].main),
                Image.network(
                  '$urlIcon${mainWeather.weather[0].icon}.png',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  String greeting() {
    var hour = DateTime.now().hour;

    if (hour < 12) {
      return 'pagi';
    }
    if (hour < 15) {
      return 'Siang';
    }

    if (hour < 18) {
      return 'Sore';
    }
    return 'Malam';
  }
}
