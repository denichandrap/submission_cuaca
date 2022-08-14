import 'package:cuaca/api_service.dart';
import 'package:cuaca/core/connection_checker.dart';
import 'package:cuaca/model/kota_model.dart';
import 'package:cuaca/model/provinsi_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class KotaController with ChangeNotifier {
  final List<Kota> _kota = [];
  Kota _selectedKota = Kota(id: '', provinceId: '', name: '');
  bool _isConnected = false;

  Future initialKota(Provinsi provinsi) async {
    _isConnected = await ConnectionChecker.isConnected();
    if (!_isConnected) return;

    if (provinsi.name == '') return;
    _kota.clear();
    _selectedKota = Kota(id: '', provinceId: '', name: '');

    EasyLoading.show(
      status: 'Pengambilan Data Kota...',
      dismissOnTap: false,
    );

    final List<Kota> kota = await ApiService().getAllKota(provinsi.id);
    for (var i = 0; i < kota.length; i++) {
      final Kota loopKota = kota[i];
      if (loopKota.name.substring(0, 4) == 'KOTA') {
        _kota.add(Kota(
            id: loopKota.id,
            provinceId: loopKota.provinceId,
            name: loopKota.name.substring(5)));
      }
    }
    EasyLoading.dismiss();
    notifyListeners();
  }

  void setKota(Kota kota) {
    _selectedKota = kota;
    notifyListeners();
  }

  Future<List<Kota>> get getAllKota {
    return Future.value(_kota);
  }

  Kota get getKota => _selectedKota;
  bool get getKoneksi => _isConnected;
}
