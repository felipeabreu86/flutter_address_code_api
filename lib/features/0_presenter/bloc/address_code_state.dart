part of 'address_code_bloc.dart';

abstract class AddressCodeState extends Equatable {}

class AddressCodeInitial extends AddressCodeState {
  @override
  List<Object?> get props => [];
}

class AddressCodeLoading extends AddressCodeState {
  @override
  List<Object?> get props => [];
}

class AddressCodeDone extends AddressCodeState {
  AddressCodeDone(this.address);

  final Address address;

  String get formatedAddress {
    var logradouro = address.logradouro;
    var localidade = address.localidade;

    if (logradouro.isNotEmpty && localidade.isNotEmpty) {
      return '$logradouro, $localidade';
    } else if (logradouro.isNotEmpty) {
      return logradouro;
    } else if (localidade.isNotEmpty) {
      return localidade;
    } else {
      return '';
    }
  }

  @override
  List<Object?> get props => [address];
}

class AddressCodeError extends AddressCodeState {
  AddressCodeError(this.errorMessage);

  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}
