import 'package:flutter_address_code_api/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_address_code_api/core/params/address_code_request_params.dart';
import 'package:flutter_address_code_api/core/usecases/usecase.dart';
import 'package:flutter_address_code_api/core/utils/constants.dart';
import 'package:flutter_address_code_api/core/utils/number_helper.dart';
import 'package:flutter_address_code_api/features/1_domain/entities/address.dart';
import 'package:flutter_address_code_api/features/1_domain/repositories/address_code_repository.dart';

class GetAddressUsecase implements UseCase<Address, AddressCodeRequestParams> {
  GetAddressUsecase(this._addressCodeRepository);

  final IAddressCodeRepository _addressCodeRepository;

  @override
  Future<Either<Failure, Address>> call(AddressCodeRequestParams params) async {
    // Validations
    if (params.cep.isEmpty) {
      throw Left(EmptyAddressCodeFailure(kEmptyAddressCodeError));
    }
    if (!NumberHelper.isNumeric(params.cep)) {
      throw Left(InvalidAddressCodeFailure(kInvalidAddressCodeError));
    }
    // Repository usage
    final result = await _addressCodeRepository.getAddress(params);
    return result;
  }
}
