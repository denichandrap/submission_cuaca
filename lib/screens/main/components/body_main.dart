import 'package:cuaca/controller/kota_controller.dart';
import 'package:cuaca/controller/provinsi_controller.dart';
import 'package:cuaca/core/connection_checker.dart';
import 'package:cuaca/model/kota_model.dart';
import 'package:cuaca/model/provinsi_model.dart';
import 'package:cuaca/screens/perkiraan_cuaca/perkiraan_cuaca_screen.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

class BodyMain extends StatefulWidget {
  const BodyMain({Key? key}) : super(key: key);

  @override
  State<BodyMain> createState() => _BodyMainState();
}

class _BodyMainState extends State<BodyMain> {
  final TextEditingController _ctlName = TextEditingController();
  final FocusNode _focusname = FocusNode();

  @override
  void dispose() {
    _ctlName.dispose();
    _focusname.dispose();
    super.dispose();
  }

  Future<void> prosesCekCuaca(
      {required ProvinsiController provinsiController,
      required KotaController kotaController}) async {
    setState(() {});
    if (!await ConnectionChecker.isConnected()) return;

    if (_ctlName.text == '') {
      _focusname.requestFocus();
      EasyLoading.showError('Nama Tidak Boleh Kosong!');
      return;
    }

    if (provinsiController.getProvinsi.name == '') {
      EasyLoading.showError('Provinsi Tidak Boleh Kosong!');
      return;
    }

    if (kotaController.getKota.name == '') {
      EasyLoading.showError('Kota Tidak Boleh Kosong!');
      return;
    }

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PerkiraanCuacaScreen(nama: _ctlName.text)));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Consumer2<ProvinsiController, KotaController>(
                builder: (context, provinsiController, kotaController, _) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _ctlName,
                      focusNode: _focusname,
                      autofocus: true,
                      decoration: const InputDecoration(labelText: 'Nama'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownSearch<Provinsi>(
                      enabled: provinsiController.getKoneksi,
                      asyncItems: (text) => provinsiController.getAllProvinsi,
                      itemAsString: (item) => item.name,
                      onChanged: (Provinsi? data) =>
                          provinsiController.setProvinsi(data!),
                      selectedItem: provinsiController.getProvinsi,
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration:
                            InputDecoration(labelText: "Provinsi"),
                      ),
                      popupProps: const PopupProps.dialog(
                        searchFieldProps: TextFieldProps(),
                        showSearchBox: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownSearch<Kota>(
                      enabled: kotaController.getKoneksi,
                      asyncItems: (text) => kotaController.getAllKota,
                      itemAsString: (item) => item.name,
                      selectedItem: kotaController.getKota,
                      onChanged: (Kota? data) => kotaController.setKota(data!),
                      popupProps: const PopupProps.dialog(
                        searchFieldProps: TextFieldProps(),
                        showSearchBox: true,
                      ),
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration:
                            InputDecoration(labelText: "Kota"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          prosesCekCuaca(
                              kotaController: kotaController,
                              provinsiController: provinsiController);
                        },
                        child: const Text('Cek Cuaca')),
                  )
                ],
              );
            })));
  }
}
