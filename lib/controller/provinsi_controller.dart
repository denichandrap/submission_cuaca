import 'package:cuaca/api_service.dart';
import 'package:cuaca/core/connection_checker.dart';
import 'package:cuaca/model/provinsi_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ProvinsiController with ChangeNotifier {
  List<Provinsi> _provinsi = [];
  Provinsi _selectedProvinsi = Provinsi(id: '', name: '');
  bool _isConnected = false;

  Future<void> initialProvinsi() async {
    _isConnected = await ConnectionChecker.isConnected();
    if (!_isConnected) return;

    _provinsi.clear();
    EasyLoading.show(
      status: 'Pengambilan Data Kota...',
      dismissOnTap: false,
    );

    _provinsi = await ApiService().getAllProvinsi();
    EasyLoading.dismiss();
    notifyListeners();
  }

  void setProvinsi(Provinsi provinsi) {
    // print(_selectedProvinsi.id);
    _selectedProvinsi = provinsi;
    // print(_selectedProvinsi.id);
    notifyListeners();
  }

  Future<List<Provinsi>> get getAllProvinsi {
    return Future.value(_provinsi);
  }

  Provinsi get getProvinsi => _selectedProvinsi;
  bool get getKoneksi => _isConnected;
}
