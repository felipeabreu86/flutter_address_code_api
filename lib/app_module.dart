import 'package:flutter_address_code_api/layers/01-domain/usecases/get_address_usecase.dart';
import 'package:flutter_address_code_api/layers/02-infrastructure/repositories/address_code_repository_implementation.dart';
import 'package:flutter_address_code_api/layers/03-external/datasources/remote/address_code_datasource_implementation.dart';
import 'package:flutter_address_code_api/layers/04-presenter/bloc/address_code_bloc.dart';
import 'package:flutter_address_code_api/layers/04-presenter/pages/home_page/home_page.dart';
import 'package:flutter_address_code_api/layers/00-core/utils/constants.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory((i) => AddressCodeBloc(i())),
    Bind.lazySingleton((i) => http.Client()),
    Bind.lazySingleton((i) => GetAddressUsecase(i())),
    Bind.lazySingleton((i) => AddressCodeRepositoryImplementation(i())),
    Bind.lazySingleton((i) => AddressCodeDatasourceImplementation(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(kInitialRoute, child: (_, args) => const HomePage()),
  ];
}
