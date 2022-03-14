import 'package:flutter_address_code_api/core/errors/exceptions.dart';
import 'package:flutter_address_code_api/core/utils/constants.dart';
import 'package:flutter_address_code_api/features/1_domain/entities/address.dart';
import 'package:flutter_address_code_api/core/params/address_code_request_params.dart';
import 'package:flutter_address_code_api/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_address_code_api/features/1_domain/repositories/address_code_repository.dart';
import 'package:flutter_address_code_api/features/2_infrastructure/datasources/remote/address_code_datasource.dart';

class AddressCodeRepositoryImplementation implements IAddressCodeRepository {
  AddressCodeRepositoryImplementation(this._addressCodeDatasource);

  final IAddressCodeDatasource _addressCodeDatasource;

  @override
  Future<Either<Failure, Address>> getAddress(
      AddressCodeRequestParams params) async {
    try {
      final result = await _addressCodeDatasource.getAddress(params);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure(kServerError));
    } on Exception {
      return Left(UnexpectedFailure(kUnexpectedError));
    }
  }
}
