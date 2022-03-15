import 'package:dartz/dartz.dart';
import 'package:flutter_address_code_api/core/errors/exceptions.dart';
import 'package:flutter_address_code_api/core/errors/failures.dart';
import 'package:flutter_address_code_api/core/params/address_code_request_params.dart';
import 'package:flutter_address_code_api/features/1_domain/entities/address.dart';
import 'package:flutter_address_code_api/features/2_infrastructure/datasources/remote/address_code_datasource.dart';
import 'package:flutter_address_code_api/features/2_infrastructure/models/address_model.dart';
import 'package:flutter_address_code_api/features/2_infrastructure/repositories/address_code_repository_implementation.dart';
import 'package:flutter_test/flutter_test.dart';

const tAddressCode = '12345678';
const tNonExistentAddressCode = '11111111';
const tUnrecognizedAddressCode = '87654321';

class AddressCodeDatasourceMock implements IAddressCodeDatasource {
  @override
  Future<AddressModel> getAddress(AddressCodeRequestParams params) async {
    if (params.cep == tAddressCode) {
      return AddressModel(
        bairro: 'bairro',
        cep: params.cep,
        ddd: '00',
        ibge: 'ibge',
        localidade: 'localidade',
        gia: 'gia',
        siafi: 'siafi',
        uf: 'AA',
        complemento: 'complemento',
        logradouro: 'logradouro',
      );
    } else if (params.cep == tNonExistentAddressCode) {
      throw ServerException();
    } else {
      throw UnexpectedException();
    }
  }
}

void main() {
  final datasource = AddressCodeDatasourceMock();
  final repository = AddressCodeRepositoryImplementation(datasource);

  testWidgets(
      'AddressCodeRepository - Should receive the correct address from datasource...',
      (tester) async {
    final Either<Failure, Address> result =
        await repository.getAddress(AddressCodeRequestParams(tAddressCode));
    expect(result.isRight(), true);
    result.fold(
      (exception) => {},
      (address) => {
        expect(address.cep == tAddressCode, true),
        expect(address is AddressModel, true)
      },
    );
  });

  testWidgets(
      'AddressCodeRepository - Should throw a server exception from datasource...',
      (tester) async {
    final Either<Failure, Address> result = await repository
        .getAddress(AddressCodeRequestParams(tNonExistentAddressCode));
    expect(result.isLeft(), true);
    result.fold(
      (exception) => expect(exception is ServerFailure, true),
      (address) => {},
    );
  });

  testWidgets(
      'AddressCodeRepository - Should throw an unexpected exception from datasource...',
      (tester) async {
    final result = await repository
        .getAddress(AddressCodeRequestParams(tUnrecognizedAddressCode));
    expect(result.isLeft(), true);
    result.fold(
      (exception) => expect(exception is UnexpectedFailure, true),
      (address) => {},
    );
  });
}
