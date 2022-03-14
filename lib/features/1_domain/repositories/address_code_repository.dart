import 'package:dartz/dartz.dart';
import 'package:flutter_address_code_api/core/errors/failures.dart';
import 'package:flutter_address_code_api/core/params/address_code_request_params.dart';
import 'package:flutter_address_code_api/features/1_domain/entities/address.dart';

abstract class IAddressCodeRepository {
  Future<Either<Failure, Address>> getAddress(
    AddressCodeRequestParams params,
  );
}
