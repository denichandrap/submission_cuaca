import 'package:cuaca/constraints.dart';
import 'package:cuaca/controller/kota_controller.dart';
import 'package:cuaca/controller/provinsi_controller.dart';
import 'package:cuaca/core/connection_checker.dart';
import 'package:cuaca/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ConnectionChecker.isConnected();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProvinsiController()),
        ChangeNotifierProxyProvider<ProvinsiController, KotaController>(
            lazy: false,
            create: (_) => KotaController(),
            update: (_, provinsi, kota) =>
                kota!..initialKota(provinsi.getProvinsi)),
      ],
      child: MaterialApp(
        title: 'Submission Cuaca',
        theme: ThemeData.dark().copyWith(
          useMaterial3: true,
          scaffoldBackgroundColor: bgColor,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
              .apply(bodyColor: Colors.white),
          canvasColor: secondaryColor,
        ),
        home: const MainScreen(),
        builder: EasyLoading.init(),
      ),
    );
  }
}
