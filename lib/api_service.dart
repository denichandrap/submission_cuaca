import 'dart:convert';

import 'package:cuaca/constraints.dart';
import 'package:cuaca/model/forecast_model.dart';
import 'package:cuaca/model/main_weahter_model.dart';
import 'package:cuaca/model/provinsi_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

import 'model/kota_model.dart';

class ApiService {
  Future<List<Provinsi>> getAllProvinsi() async {
    try {
      const String url = '$urlApiProvinsi/provinces.json';
      debugPrint(url);
      final response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );

      if (response.statusCode == 200) {
        final result = provinsiFromJson(response.body);

        return result;
      } else {
        debugPrint("error getAllProvinsi");
        return [];
      }
    } catch (e) {
      debugPrint("catch error getAllProvinsi");
      return [];
    }
  }

  Future<List<Kota>> getAllKota(String idProvinsi) async {
    try {
      String url = '$urlApiProvinsi/regencies/$idProvinsi.json';
      debugPrint(url);
      final response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );

      if (response.statusCode == 200) {
        final result = kotaFromJson(response.body);

        return result;
      } else {
        debugPrint("error getAllKota");
        return [];
      }
    } catch (e) {
      debugPrint("catch error getAllKota");
      return [];
    }
  }

  Future<dynamic> getMainWeather(String kota) async {
    try {
      String url = '$urlApiWeather/weather?q=$kota&appid=$apiKey';
      debugPrint(url);
      final response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );

      if (response.statusCode == 200) {
        final result = mainWeatherFromJson(response.body);

        return result;
      } else {
        final result = jsonDecode(response.body);
        Map<String, dynamic> _result = result;
        final result_ = _result['message'];
        EasyLoading.showError(result_);
        debugPrint("error getMainWeather");
        return;
      }
    } catch (e) {
      EasyLoading.showError("catch error getMainWeather");
      debugPrint("catch error getMainWeather");
      return;
    }
  }

  Future<dynamic> getForecast(String lat, String lon) async {
    // api.openweathermap.org/data/2.5/forecast?lat=-6.9039&lon=107.6186&appid=9ff5ce05572aff7162cbb795b8b01b1d
    // try {
    String url = '$urlApiWeather/forecast?lat=$lat&&lon=$lon&appid=$apiKey';
    debugPrint(url);
    final response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );

    if (response.statusCode == 200) {
      final result = forecastFromJson(response.body);

      return result;
    } else {
      final result = jsonDecode(response.body);
      Map<String, dynamic> _result = result;
      final result_ = _result['message'];
      EasyLoading.showError(result_);
      debugPrint("error getForecast");
      return;
    }
    // } catch (e) {
    //   print(e);
    //   EasyLoading.showError("catch error getForecast");
    //   debugPrint("catch error getForecast");
    //   return;
    // }
  }
}
