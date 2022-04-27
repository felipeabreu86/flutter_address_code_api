import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_address_code_api/app_module.dart';
import 'package:flutter_address_code_api/app_widget.dart';
import 'package:flutter_modular/flutter_modular.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  ).then((_) {
    runApp(ModularApp(module: AppModule(), child: const AppWidget()));
  });
}
