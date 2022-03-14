import 'package:flutter_address_code_api/core/utils/constants.dart';
import 'package:flutter_address_code_api/features/0_presenter/pages/home_page/home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(kInitialRoute, child: (_, __) => const HomePage()),
  ];
}
