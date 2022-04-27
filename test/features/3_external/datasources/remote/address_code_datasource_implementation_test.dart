import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter_address_code_api/layers/00-core/errors/exceptions.dart';
import 'package:flutter_address_code_api/layers/00-core/params/address_code_request_params.dart';
import 'package:flutter_address_code_api/layers/03-external/datasources/remote/address_code_datasource_implementation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

const tAddressCode = '12345678';
const tNonExistentAddressCode = '11111111';
const tUnrecognizedAddressCode = '87654321';

class MockClient implements http.Client {
  @override
  void close() {}

  @override
  Future<http.Response> delete(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    throw UnimplementedError();
  }

  @override
  Future<http.Response> get(Uri url, {Map<String, String>? headers}) async {
    if (url.toString().contains(tAddressCode)) {
      const tAddressModelMock = """{
        "cep": "$tAddressCode",
        "logradouro": "logradouro",
        "complemento": "complemento",
        "bairro": "bairro",
        "localidade": "localidade",
        "uf": "uf",
        "ibge": "ibge",
        "gia": "gia",
        "ddd": "ddd",
        "siafi": "siafi"
        }""";
      final response = http.Response(tAddressModelMock, 200);
      return response;
    } else if (url.toString().contains(tNonExistentAddressCode)) {
      final response = http.Response("", 500);
      return response;
    } else {
      throw Exception("Unexpected error");
    }
  }

  @override
  Future<http.Response> head(Uri url, {Map<String, String>? headers}) {
    throw UnimplementedError();
  }

  @override
  Future<http.Response> patch(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    throw UnimplementedError();
  }

  @override
  Future<http.Response> post(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    throw UnimplementedError();
  }

  @override
  Future<http.Response> put(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    throw UnimplementedError();
  }

  @override
  Future<String> read(Uri url, {Map<String, String>? headers}) {
    throw UnimplementedError();
  }

  @override
  Future<Uint8List> readBytes(Uri url, {Map<String, String>? headers}) {
    throw UnimplementedError();
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    throw UnimplementedError();
  }
}

void main() {
  http.Client client = MockClient();
  final datasource = AddressCodeDatasourceImplementation(client);

  test(
      'AddressCodeDatasource - Should receive the correct address from endpoint...',
      () async {
    final result =
        await datasource.getAddress(AddressCodeRequestParams(tAddressCode));
    expect(result.cep, tAddressCode);
  });

  test(
      'AddressCodeDatasource - Should receive an server exception from endpoint...',
      () async {
    try {
      final result = await datasource
          .getAddress(AddressCodeRequestParams(tNonExistentAddressCode));
      expect(result.cep == tNonExistentAddressCode, false);
    } catch (exception) {
      expect(exception is ServerException, true);
    }
  });

  test(
      'AddressCodeDatasource - Should receive an unexpected exception from endpoint...',
      () async {
    try {
      final result = await datasource
          .getAddress(AddressCodeRequestParams(tUnrecognizedAddressCode));
      expect(result.cep == tUnrecognizedAddressCode, false);
    } catch (exception) {
      expect(exception is UnexpectedException, true);
    }
  });
}
