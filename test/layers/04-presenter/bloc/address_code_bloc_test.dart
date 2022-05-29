import 'package:dartz/dartz.dart';
import 'package:flutter_address_code_api/layers/00-core/errors/failures.dart';
import 'package:flutter_address_code_api/layers/00-core/params/address_code_request_params.dart';
import 'package:flutter_address_code_api/layers/01-domain/entities/address.dart';
import 'package:flutter_address_code_api/layers/01-domain/usecases/get_address_usecase/get_address_usecase.dart';
import 'package:flutter_address_code_api/layers/04-presenter/bloc/address_code_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetAddressUsecase extends Mock implements GetAddressUsecase {}

void main() {
  const initialState = TypeMatcher<AddressCodeInitial>();
  const loadingState = TypeMatcher<AddressCodeLoading>();
  const doneState = TypeMatcher<AddressCodeDone>();
  const errorState = TypeMatcher<AddressCodeError>();
  const tAddressCode = '12345678';
  const tAddress = Address(
    cep: tAddressCode,
    logradouro: '',
    complemento: '',
    bairro: '',
    localidade: '',
    uf: '',
    ibge: '',
    gia: '',
    ddd: '',
    siafi: '',
  );

  final tAddressParam = AddressCodeRequestParams(tAddressCode);
  final MockGetAddressUsecase usecase = MockGetAddressUsecase();
  final AddressCodeBloc bloc = AddressCodeBloc(usecase);

  test('AddressCodeBloc - Should initialize the bloc with Initial status...',
      () async {
    expect(bloc.state, initialState);
  });

  test(
      'AddressCodeBloc - Should emit Loading and Done states and return an Address...',
      () async {
    when(() => usecase.call(tAddressParam))
        .thenAnswer((_) async => const Right<Failure, Address>(tAddress));

    bloc.add(AddressCodeSearch(tAddressParam));

    await expectLater(
        bloc.stream,
        emitsInOrder([
          loadingState,
          doneState,
        ]));
  });

  test(
      'AddressCodeBloc - Should emit Loading and Error states and return an Server Failure...',
      () async {
    when(() => usecase.call(tAddressParam)).thenAnswer(
        (_) async => Left<Failure, Address>(ServerFailure("error message")));

    bloc.add(AddressCodeSearch(tAddressParam));

    await expectLater(
        bloc.stream,
        emitsInOrder([
          loadingState,
          errorState,
        ]));
  });

  test(
      'AddressCodeBloc - Should emit Loading and Error states and return an Unexpected Failure...',
      () async {
    when(() => usecase.call(tAddressParam)).thenAnswer((_) async =>
        Left<Failure, Address>(UnexpectedFailure("error message")));

    bloc.add(AddressCodeSearch(tAddressParam));

    await expectLater(
        bloc.stream,
        emitsInOrder([
          loadingState,
          errorState,
        ]));
  });
}
