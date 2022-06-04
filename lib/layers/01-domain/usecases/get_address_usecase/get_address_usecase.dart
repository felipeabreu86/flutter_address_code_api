import 'package:dartz/dartz.dart';
import 'package:flutter_address_code_api/layers/00-core/errors/failures.dart';
import 'package:flutter_address_code_api/layers/00-core/params/address_code_request_params.dart';
import 'package:flutter_address_code_api/layers/00-core/usecases/usecase.dart';
import 'package:flutter_address_code_api/layers/01-domain/entities/address.dart';
import 'package:flutter_address_code_api/layers/01-domain/repositories/address_code_repository.dart';
import 'package:flutter_address_code_api/layers/01-domain/usecases/get_address_usecase/get_address_usecase_validations.dart';

class GetAddressUsecase implements UseCase<Address, AddressCodeRequestParams> {
  GetAddressUsecase(this._addressCodeRepository, this._validations);

  final AddressCodeRepository _addressCodeRepository;
  final GetAddressUsecaseValidations _validations;

  @override
  Future<Either<Failure, Address>> call(AddressCodeRequestParams params) async {
    for (var addressValidation in _validations()) {
      if (addressValidation.isNotValid(params)) {
        return Left(addressValidation.getFailure());
      }
    }
    return await _addressCodeRepository.getAddress(params);
  }
}
