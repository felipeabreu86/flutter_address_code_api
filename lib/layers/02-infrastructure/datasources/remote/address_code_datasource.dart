import 'package:flutter_address_code_api/layers/00-core/params/address_code_request_params.dart';
import 'package:flutter_address_code_api/layers/02-infrastructure/models/address_model.dart';

abstract class AddressCodeDatasource {
  Future<AddressModel> getAddress(AddressCodeRequestParams params);
}
