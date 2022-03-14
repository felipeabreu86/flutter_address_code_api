import 'package:equatable/equatable.dart';
import 'package:flutter_address_code_api/core/utils/constants.dart';

abstract class Failure extends Equatable {
  String get message;
}

class UnexpectedFailure extends Failure {
  @override
  String get message => kUnexpectedError;

  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];

  @override
  String get message => kServerError;
}
