import 'package:cuaca/controller/provinsi_controller.dart';
import 'package:cuaca/screens/main/components/body_main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<ProvinsiController>(context, listen: false).initialProvinsi();
    return const Scaffold(
      body: BodyMain(),
    );
  }
}
