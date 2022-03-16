import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  String get errorMessage;
}

class UnexpectedFailure extends Failure {
  UnexpectedFailure(this.errorMessage);

  @override
  final String errorMessage;

  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  ServerFailure(this.errorMessage);

  @override
  final String errorMessage;

  @override
  List<Object?> get props => [];
}

class EmptyAddressCodeFailure extends Failure {
  EmptyAddressCodeFailure(this.errorMessage);

  @override
  final String errorMessage;

  @override
  List<Object?> get props => [];
}

class InvalidAddressCodeFailure extends Failure {
  InvalidAddressCodeFailure(this.errorMessage);

  @override
  final String errorMessage;

  @override
  List<Object?> get props => [];
}
