import 'package:dartz/dartz.dart';
import 'package:flutter_address_code_api/layers/00-core/errors/failures.dart';
import 'package:flutter_address_code_api/layers/00-core/params/address_code_request_params.dart';
import 'package:flutter_address_code_api/layers/00-core/usecases/usecase.dart';
import 'package:flutter_address_code_api/layers/00-core/utils/constants.dart';
import 'package:flutter_address_code_api/layers/00-core/utils/number_helper.dart';
import 'package:flutter_address_code_api/layers/01-domain/entities/address.dart';
import 'package:flutter_address_code_api/layers/01-domain/repositories/address_code_repository.dart';

class GetAddressUsecase implements UseCase<Address, AddressCodeRequestParams> {
  GetAddressUsecase(this._addressCodeRepository);

  final IAddressCodeRepository _addressCodeRepository;

  @override
  Future<Either<Failure, Address>> call(AddressCodeRequestParams params) async {
    // Validations
    if (params.cep.isEmpty) {
      return Left(EmptyAddressCodeFailure(kEmptyAddressCodeError));
    }
    if (!NumberHelper.isNumeric(params.cep)) {
      return Left(InvalidAddressCodeFailure(kInvalidAddressCodeError));
    }
    // Repository usage
    return await _addressCodeRepository.getAddress(params);
  }
}
