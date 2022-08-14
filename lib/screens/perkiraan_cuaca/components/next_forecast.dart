import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:cuaca/api_service.dart';
import 'package:cuaca/constraints.dart';
import 'package:cuaca/model/forecast_model.dart';
import 'package:cuaca/model/forecast_view_model.dart';
import 'package:cuaca/model/main_weahter_model.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

class NextForecast extends StatelessWidget {
  const NextForecast({Key? key, required this.mainWeather}) : super(key: key);
  final MainWeather mainWeather;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: FutureBuilder(
          future: ApiService().getForecast(mainWeather.coord.lat.toString(),
              mainWeather.coord.lon.toString()),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return kLoadingSpinner;
              default:
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  if (snapshot.data == null) return Container();
                  final Forecast respon = snapshot.data;
                  return isi(context, respon);
                }
            }
          },
        ),
      ),
    );
  }

  Widget isi(BuildContext context, Forecast forecast) {
    List<ForecastView> forecastView = [];
    for (var i = 0; i < forecast.list.length; i++) {
      var element = forecast.list[i];
      forecastView.add(ForecastView(
          celcius: '${(element.main.temp - 273.15).toStringAsFixed(2)} °C',
          icon: element.weather[0].icon,
          date: element.dtTxt));
    }

    final groupByDate = groupBy(forecastView, (ForecastView fv) {
      return json.encode(formatDate(fv.date, [' ', D, '\n', dd, '/', mm]));
    });

    final keyList = groupByDate.keys.toList();

    return Column(children: [
      for (String thisKeyList in keyList)
        SizedBox(
          height: 100,
          child: Row(
            children: [
              Text(json.decode(thisKeyList)),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    for (ForecastView forecast in groupByDate[thisKeyList]!)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(formatDate(forecast.date, [HH, ':', nn])),
                            Image.network(
                              '$urlIcon${forecast.icon}.png',
                              height: 30,
                            ),
                            Text(forecast.celcius)
                          ],
                        ),
                      )
                  ],
                ),
              )
            ],
          ),
        ),
    ]);
  }
}
