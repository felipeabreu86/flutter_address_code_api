import 'package:flutter_address_code_api/core/utils/constants.dart';
import 'package:flutter_address_code_api/features/0_presenter/pages/home_page/home_page.dart';
import 'package:flutter_address_code_api/features/1_domain/usecases/get_address_usecase.dart';
import 'package:flutter_address_code_api/features/2_infrastructure/repositories/address_code_repository_implementation.dart';
import 'package:flutter_address_code_api/features/3_external/datasources/remote/address_code_datasource_implementation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => http.Client()),
    Bind.lazySingleton((i) => GetAddressUsecase(i())),
    Bind.lazySingleton((i) => AddressCodeRepositoryImplementation(i())),
    Bind.lazySingleton((i) => AddressCodeDatasourceImplementation(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(kInitialRoute, child: (_, __) => const HomePage()),
  ];
}
