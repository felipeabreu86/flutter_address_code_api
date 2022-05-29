import 'package:flutter_address_code_api/layers/00-core/errors/failures.dart';
import 'package:flutter_address_code_api/layers/00-core/params/address_code_request_params.dart';

abstract class AddressValidation {
  bool isNotValid(AddressCodeRequestParams params);

  Failure getFailure();
}
