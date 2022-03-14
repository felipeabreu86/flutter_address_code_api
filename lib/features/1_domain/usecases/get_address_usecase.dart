import 'package:flutter_address_code_api/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_address_code_api/core/params/address_code_request_params.dart';
import 'package:flutter_address_code_api/core/usecases/usecase.dart';
import 'package:flutter_address_code_api/features/1_domain/entities/address.dart';
import 'package:flutter_address_code_api/features/1_domain/repositories/address_code_repository.dart';

class GetAddressUsecase implements UseCase<Address, AddressCodeRequestParams> {
  GetAddressUsecase(this._addressCodeRepository);

  final IAddressCodeRepository _addressCodeRepository;

  @override
  Future<Either<Failure, Address>> call(AddressCodeRequestParams params) async {
    final result = await _addressCodeRepository.getAddress(params);
    return result;
  }
}
