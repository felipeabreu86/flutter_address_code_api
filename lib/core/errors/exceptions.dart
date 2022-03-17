import 'package:equatable/equatable.dart';

abstract class CustomException implements Exception {
  String get errorMessage;
}

class UnexpectedException extends Equatable implements CustomException {
  const UnexpectedException(this.errorMessage);

  @override
  List<Object> get props => [];

  @override
  final String errorMessage;
}

class ServerException extends Equatable implements CustomException {
  const ServerException(this.errorMessage);

  @override
  List<Object> get props => [];

  @override
  final String errorMessage;
}
