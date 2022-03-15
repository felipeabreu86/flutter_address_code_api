import 'package:flutter_address_code_api/features/1_domain/entities/address.dart';
import 'package:flutter_address_code_api/core/params/address_code_request_params.dart';
import 'package:flutter_address_code_api/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_address_code_api/features/1_domain/repositories/address_code_repository.dart';
import 'package:flutter_address_code_api/features/1_domain/usecases/get_address_usecase.dart';
import 'package:flutter_test/flutter_test.dart';

const tAddressCode = '12345678';
const tNonExistentAddressCode = '11111111';
const tUnrecognizedAddressCode = '87654321';

class AddressCodeRepositoryMock implements IAddressCodeRepository {
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
            logradouro: 'logradouro'),
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
  final usecase = GetAddressUsecase(repository);

  test(
      'GetAddressUsecase - Should receive the correct address from repository...',
      () async {
    final Either<Failure, Address> result =
        await usecase(AddressCodeRequestParams(tAddressCode));
    expect(result.isRight(), true);
    expect(result.foldRight((z) => null, (r, previous) => r.cep), tAddressCode);
  });

  test('GetAddressUsecase - Should receive a server failure from repository...',
      () async {
    final Either<Failure, Address> result =
        await usecase(AddressCodeRequestParams(tNonExistentAddressCode));
    expect(result.isLeft(), true);
    expect(result, Left(ServerFailure("Server Failure Message")));
  });

  test(
      'GetAddressUsecase - Should receive a unexpected failure from repository...',
      () async {
    final Either<Failure, Address> result =
        await usecase(AddressCodeRequestParams(tUnrecognizedAddressCode));
    expect(result.isLeft(), true);
    expect(result, Left(UnexpectedFailure("Unexpected Failure Message")));
  });

  test('GetAddressUsecase - Should receive empty address code failure...',
      () async {
    final Either<Failure, Address> result =
        await usecase(AddressCodeRequestParams(''));
    expect(result.isLeft(), true);
    expect(result, Left(EmptyAddressCodeFailure('Error message')));
  });

  test('GetAddressUsecase - Should receive invalid address code failure...',
      () async {
    final Either<Failure, Address> result =
        await usecase(AddressCodeRequestParams(tAddressCode + 'a'));
    expect(result.isLeft(), true);
    expect(result, Left(InvalidAddressCodeFailure('Error message')));
  });
}
