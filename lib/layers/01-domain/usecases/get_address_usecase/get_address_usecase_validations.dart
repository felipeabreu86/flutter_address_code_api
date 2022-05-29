import 'package:flutter_address_code_api/layers/01-domain/usecases/validations/address_validation.dart';
import 'package:flutter_address_code_api/layers/01-domain/usecases/validations/empty_address_code_validation.dart';
import 'package:flutter_address_code_api/layers/01-domain/usecases/validations/invalid_address_code_validation.dart';

class GetAddressUsecaseValidations {
  static final List<AddressValidation> validations = [
    EmptyAddressCodeValidation(),
    InvalidAddressCodeValidation(),
  ];
}
