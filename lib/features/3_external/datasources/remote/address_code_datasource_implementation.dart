import 'dart:convert';
import 'package:flutter_address_code_api/core/errors/exceptions.dart';
import 'package:flutter_address_code_api/core/params/address_code_request_params.dart';
import 'package:flutter_address_code_api/features/2_infrastructure/datasources/remote/address_code_datasource.dart';
import 'package:flutter_address_code_api/features/2_infrastructure/models/address_model.dart';
import 'package:http/http.dart' as http;

class AddressCodeDatasourceImplementation implements IAddressCodeDatasource {
  AddressCodeDatasourceImplementation(this.client);

  final http.Client client;

  Uri _cepEndpoint(String cep) => Uri.https('viacep.com.br', '/ws/$cep/json');

  @override
  Future<AddressModel> getAddress(AddressCodeRequestParams params) async {
    try {
      final response = await client.get(_cepEndpoint(params.cep));
      if (response.statusCode == 200) {
        final Map<String, dynamic> bodyDecoded = json.decode(response.body);
        return AddressModel.fromJson(bodyDecoded);
      } else {
        throw ServerException();
      }
    } on Exception {
      throw UnexpectedException();
    }
  }
}
