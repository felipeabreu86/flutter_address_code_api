import 'package:flutter_address_code_api/layers/01-domain/usecases/validations/address_validation.dart';
import 'package:flutter_address_code_api/layers/01-domain/usecases/validations/empty_address_code_validation.dart';
import 'package:flutter_address_code_api/layers/01-domain/usecases/validations/invalid_address_code_validation.dart';
import 'package:flutter_address_code_api/layers/01-domain/usecases/validations/length_address_code_validation.dart';

class GetAddressUsecaseValidations {
  List<AddressValidation> call() {
    return [
      EmptyAddressCodeValidation(),
      LengthAddressCodeValidation(),
      InvalidAddressCodeValidation(),
    ];
  }
}
