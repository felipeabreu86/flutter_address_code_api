import 'package:dartz/dartz.dart';
import 'package:flutter_address_code_api/layers/00-core/errors/failures.dart';
import 'package:flutter_address_code_api/layers/00-core/params/address_code_request_params.dart';
import 'package:flutter_address_code_api/layers/01-domain/entities/address.dart';

abstract class IAddressCodeRepository {
  Future<Either<Failure, Address>> getAddress(
    AddressCodeRequestParams params,
  );
}
