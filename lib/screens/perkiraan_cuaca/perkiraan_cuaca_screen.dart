import 'package:cuaca/controller/kota_controller.dart';
import 'package:cuaca/screens/perkiraan_cuaca/components/body_cuaca.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PerkiraanCuacaScreen extends StatefulWidget {
  const PerkiraanCuacaScreen({Key? key, required this.nama}) : super(key: key);
  final String nama;

  @override
  State<PerkiraanCuacaScreen> createState() => _PerkiraanCuacaScreenState();
}

class _PerkiraanCuacaScreenState extends State<PerkiraanCuacaScreen> {
  String formattedDate =
      formatDate(DateTime.now(), [DD, ', ', MM, ' ', dd, ', ', yyyy]);
  @override
  Widget build(BuildContext context) {
    final String kota =
        Provider.of<KotaController>(context, listen: false).getKota.name;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Column(
          children: [
            Text(kota),
            Text(
              formattedDate,
              style: const TextStyle(fontSize: 9),
            )
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: BodyCuaca(
        kota: kota,
        nama: widget.nama,
      ),
    );
  }
}
