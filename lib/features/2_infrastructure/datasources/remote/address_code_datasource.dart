import 'package:flutter_address_code_api/core/params/address_code_request_params.dart';
import 'package:flutter_address_code_api/features/2_infrastructure/models/address_model.dart';

abstract class IAddressCodeDatasource {
  Future<AddressModel> getAddress(AddressCodeRequestParams params);
}
