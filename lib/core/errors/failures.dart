import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class UnexpectedFailure extends Failure {
  UnexpectedFailure(this.errorMessage);

  final String errorMessage;

  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  ServerFailure(this.errorMessage);

  final String errorMessage;

  @override
  List<Object?> get props => [];
}

class EmptyAddressCodeFailure extends Failure {
  EmptyAddressCodeFailure(this.errorMessage);

  final String errorMessage;

  @override
  List<Object?> get props => [];
}

class InvalidAddressCodeFailure extends Failure {
  InvalidAddressCodeFailure(this.errorMessage);

  final String errorMessage;

  @override
  List<Object?> get props => [];
}
