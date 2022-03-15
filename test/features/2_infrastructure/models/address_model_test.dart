import 'dart:convert';

import 'package:flutter_address_code_api/features/1_domain/entities/address.dart';
import 'package:flutter_address_code_api/features/2_infrastructure/models/address_model.dart';
import 'package:flutter_test/flutter_test.dart';

const tAddressModelMock =
    """{
    "cep": "cep",
    "logradouro": "logradouro",
    "complemento": "complemento",
    "bairro": "bairro",
    "localidade": "localidade",
    "uf": "uf",
    "ibge": "ibge",
    "gia": "gia",
    "ddd": "ddd",
    "siafi": "siafi",
    "fakefield1": "",
    "fakefiel2": "fakevalue"
  }""";

void main() {
  const tAddressModel = AddressModel(
    cep: 'cep',
    logradouro: 'logradouro',
    complemento: 'complemento',
    bairro: 'bairro',
    localidade: 'localidade',
    uf: 'uf',
    ibge: 'ibge',
    gia: 'gia',
    ddd: 'ddd',
    siafi: 'siafi',
  );

  test('AddressModel - Should be a subclass of Address...', () {
    expect(tAddressModel, isA<Address>());
  });

  test('AddressModel - Should return a valid model...', () {
    final Map<String, dynamic> jsonMap = json.decode(tAddressModelMock);
    final result = AddressModel.fromJson(jsonMap);
    expect(result, tAddressModel);
    expect(result.cep, 'cep');
  });

  test('AddressModel - Should return a json map containing the proper data...',
      () {
    final expectedMap = {
      "cep": "cep",
      "logradouro": "logradouro",
      "complemento": "complemento",
      "bairro": "bairro",
      "localidade": "localidade",
      "uf": "uf",
      "ibge": "ibge",
      "gia": "gia",
      "ddd": "ddd",
      "siafi": "siafi",
    };
    final result = tAddressModel.toJson();
    expect(result, expectedMap);
  });
}
