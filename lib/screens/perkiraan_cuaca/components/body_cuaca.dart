import 'package:cuaca/api_service.dart';
import 'package:cuaca/constraints.dart';
import 'package:cuaca/model/main_weahter_model.dart';
import 'package:cuaca/screens/perkiraan_cuaca/components/detail_header.dart';
import 'package:cuaca/screens/perkiraan_cuaca/components/header.dart';
import 'package:cuaca/screens/perkiraan_cuaca/components/next_forecast.dart';
import 'package:flutter/cupertino.dart';

class BodyCuaca extends StatelessWidget {
  const BodyCuaca({Key? key, required this.kota, required this.nama})
      : super(key: key);
  final String kota;
  final String nama;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: FutureBuilder(
      future: ApiService().getMainWeather(kota),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            // return Container();
            return kLoadingSpinner;
          default:
            if (snapshot.hasError) {
              // print(snapshot.error);
              return Text('Error: ${snapshot.error}');
            } else {
              if (snapshot.data == null) return Container();
              final MainWeather respon = snapshot.data;
              return isi(respon, nama);
            }
        }
      },
    ));
  }

  Widget isi(MainWeather respon, String name) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: ListView(
        children: [
          HeaderCuaca(
            mainWeather: respon,
            name: name,
          ),
          DetailHeader(mainWeather: respon),
          NextForecast(
            mainWeather: respon,
          )
        ],
      ),
    );
  }
}
