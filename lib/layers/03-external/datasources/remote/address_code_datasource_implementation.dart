import 'dart:convert';
import 'package:flutter_address_code_api/layers/00-core/errors/exceptions.dart';
import 'package:flutter_address_code_api/layers/00-core/params/address_code_request_params.dart';
import 'package:flutter_address_code_api/layers/02-infrastructure/datasources/remote/address_code_datasource.dart';
import 'package:flutter_address_code_api/layers/02-infrastructure/models/address_model.dart';
import 'package:http/http.dart' as http;

class AddressCodeDatasourceImplementation implements AddressCodeDatasource {
  AddressCodeDatasourceImplementation(this.client);

  final http.Client client;

  Uri _cepEndpoint(String cep) => Uri.https('viacep.com.br', '/ws/$cep/json');

  @override
  Future<AddressModel> getAddress(AddressCodeRequestParams params) async {
    try {
      final response = await client.get(_cepEndpoint(params.cep));
      if (response.statusCode == 200) {
        return AddressModel.fromJson(json.decode(response.body));
      } else {
        throw ServerException('Status Code Error ${response.statusCode}');
      }
    } on ServerException {
      rethrow;
    } on Exception catch (e) {
      throw UnexpectedException(e.toString());
    }
  }
}
