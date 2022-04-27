import 'package:dartz/dartz.dart';
import 'package:flutter_address_code_api/layers/00-core/errors/failures.dart';

abstract class UseCase<Output, Input> {
  Future<Either<Failure, Output>> call(Input params);
}
