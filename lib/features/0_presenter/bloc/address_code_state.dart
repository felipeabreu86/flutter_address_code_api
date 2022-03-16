part of 'address_code_bloc.dart';

abstract class AddressCodeState extends Equatable {
  const AddressCodeState(this.address, this.errorMessage);

  final Address address;
  final String errorMessage;

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
  List<Object> get props => [address, errorMessage];
}

class AddressCodeInitial extends AddressCodeState {
  const AddressCodeInitial() : super(AddressModel.emptyAddress, '');
}

class AddressCodeLoading extends AddressCodeState {
  const AddressCodeLoading() : super(AddressModel.emptyAddress, '');
}

class AddressCodeDone extends AddressCodeState {
  const AddressCodeDone(Address address) : super(address, '');
}

class AddressCodeError extends AddressCodeState {
  const AddressCodeError(String errorMessage)
      : super(AddressModel.emptyAddress, errorMessage);
}
