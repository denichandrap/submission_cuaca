import 'package:flutter/material.dart';

const primaryColor = Color(0xFF2697FF);
const secondaryColor = Color(0xFF2A2D3E);
const bgColor = Color(0xFF212332);

const defaultPadding = 16.0;

const urlApiProvinsi = 'http://www.emsifa.com/api-wilayah-indonesia/api';

const urlApiWeather = 'https://api.openweathermap.org/data/2.5';

const urlIcon = 'http://openweathermap.org/img/w/';

const apiKey = '9ff5ce05572aff7162cbb795b8b01b1d';

const Widget kSpaceHeight = SizedBox(
  height: defaultPadding / 2,
);
final Widget kLoadingSpinner = Center(
  child: Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20.0),
    ),
    width: 150.0,
    height: 150.0,
    alignment: AlignmentDirectional.center,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          strokeWidth: 5,
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
        ),
        kSpaceHeight,
        const Text(
          "Loading",
          style: TextStyle(color: Colors.white),
        ),
      ],
    ),
  ),
);
