import 'package:dartz/dartz.dart';
import 'package:flutter_address_code_api/layers/00-core/errors/failures.dart';
import 'package:flutter_address_code_api/layers/00-core/params/address_code_request_params.dart';
import 'package:flutter_address_code_api/layers/00-core/utils/constants.dart';
import 'package:flutter_address_code_api/layers/01-domain/entities/address.dart';
import 'package:flutter_address_code_api/layers/01-domain/repositories/address_code_repository.dart';
import 'package:flutter_address_code_api/layers/01-domain/usecases/get_address_usecase/get_address_usecase.dart';
import 'package:flutter_address_code_api/layers/01-domain/usecases/get_address_usecase/get_address_usecase_validations.dart';
import 'package:flutter_test/flutter_test.dart';

const tAddressCode = '12345678';
const tNonExistentAddressCode = '11111111';
const tUnrecognizedAddressCode = '87654321';

class AddressCodeRepositoryMock implements AddressCodeRepository {
  @override
  Future<Either<Failure, Address>> getAddress(
      AddressCodeRequestParams params) async {
    if (params.cep == tAddressCode) {
      return Right(
        Address(
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
        ),
      );
    } else if (params.cep == tNonExistentAddressCode) {
      return Left(ServerFailure("Server Failure Message"));
    } else {
      return Left(UnexpectedFailure("Unexpected Failure Message"));
    }
  }
}

void main() {
  final repository = AddressCodeRepositoryMock();
  final usecase = GetAddressUsecase(repository, GetAddressUsecaseValidations());

  test(
      'GetAddressUsecase - Should receive the correct address from repository...',
      () async {
    final Either<Failure, Address> result =
        await usecase(AddressCodeRequestParams(tAddressCode));
    expect(result.isRight(), true);
    result.fold(
      (exception) => {},
      (address) => {
        expect(address.cep == tAddressCode, true),
      },
    );
  });

  test('GetAddressUsecase - Should receive a server failure from repository...',
      () async {
    final Either<Failure, Address> result =
        await usecase(AddressCodeRequestParams(tNonExistentAddressCode));
    expect(result.isLeft(), true);
    result.fold(
      (exception) =>
          expect(result, Left(ServerFailure("Server Failure Message"))),
      (address) => {},
    );
  });

  test(
      'GetAddressUsecase - Should receive an unexpected failure from repository...',
      () async {
    final Either<Failure, Address> result =
        await usecase(AddressCodeRequestParams(tUnrecognizedAddressCode));
    expect(result.isLeft(), true);
    result.fold(
      (exception) =>
          expect(result, Left(UnexpectedFailure("Unexpected Failure Message"))),
      (address) => {},
    );
  });

  test('GetAddressUsecase - Should receive an empty address code failure...',
      () async {
    final Either<Failure, Address> result =
        await usecase(AddressCodeRequestParams(''));
    expect(result.isLeft(), true);
    result.fold(
      (exception) =>
          expect(result, Left(EmptyAddressCodeFailure(kEmptyAddressCodeError))),
      (address) => {},
    );
  });

  test('GetAddressUsecase - Should receive an invalid address code failure...',
      () async {
    final Either<Failure, Address> result =
        await usecase(AddressCodeRequestParams('1234567a'));
    expect(result.isLeft(), true);
    result.fold(
      (exception) =>
          expect(result, Left(InvalidAddressCodeFailure('Error message'))),
      (address) => {},
    );
  });

  test('GetAddressUsecase - Should receive a length address code failure...',
      () async {
    // length > 8
    Either<Failure, Address> result =
        await usecase(AddressCodeRequestParams('123456789'));
    expect(result.isLeft(), true);
    result.fold(
      (exception) => expect(
          result, Left(LengthAddressCodeFailure(kLengthAddressCodeError))),
      (address) => {},
    );
    // length < 8
    result = await usecase(AddressCodeRequestParams('1234567'));
    expect(result.isLeft(), true);
    result.fold(
      (exception) => expect(
          result, Left(LengthAddressCodeFailure(kLengthAddressCodeError))),
      (address) => {},
    );
  });
}
