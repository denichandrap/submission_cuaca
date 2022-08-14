import 'package:cuaca/model/main_weahter_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailHeader extends StatelessWidget {
  const DetailHeader({Key? key, required this.mainWeather}) : super(key: key);
  final MainWeather mainWeather;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [humidity(), presure(), cloude(), wind()],
        ),
      ),
    );
  }

  Column humidity() {
    return Column(
      children: [
        SvgPicture.asset(
          'assets/icon/humidity.svg',
          color: Colors.white,
          height: 30,
        ),
        Text('${mainWeather.main.humidity} %'),
        const Text('Humidity'),
      ],
    );
  }

  Column presure() {
    return Column(
      children: [
        SvgPicture.asset(
          'assets/icon/pressure.svg',
          color: Colors.white,
          height: 30,
        ),
        Text('${mainWeather.main.pressure} hpa'),
        const Text('Pressure'),
      ],
    );
  }

  Column cloude() {
    return Column(
      children: [
        SvgPicture.asset(
          'assets/icon/cloud.svg',
          color: Colors.white,
          height: 30,
        ),
        Text('${mainWeather.clouds.all} %'),
        const Text('Cloudness'),
      ],
    );
  }

  Column wind() {
    return Column(
      children: [
        SvgPicture.asset(
          'assets/icon/wind.svg',
          color: Colors.white,
          height: 30,
        ),
        Text('${mainWeather.wind.speed} m/s'),
        const Text('Wind'),
      ],
    );
  }
}
