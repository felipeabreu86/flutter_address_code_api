import 'package:flutter_address_code_api/layers/00-core/errors/failures.dart';
import 'package:flutter_address_code_api/layers/00-core/params/address_code_request_params.dart';
import 'package:flutter_address_code_api/layers/00-core/utils/constants.dart';
import 'package:flutter_address_code_api/layers/00-core/utils/number_helper.dart';
import 'package:flutter_address_code_api/layers/01-domain/usecases/validations/address_validation.dart';

class InvalidAddressCodeValidation extends AddressValidation {
  @override
  bool isNotValid(AddressCodeRequestParams params) {
    return !NumberHelper.isNumeric(params.cep);
  }

  @override
  Failure getFailure() {
    return InvalidAddressCodeFailure(kInvalidAddressCodeError);
  }
}
