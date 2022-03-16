part of 'address_code_bloc.dart';

abstract class AddressCodeEvent extends Equatable {
  const AddressCodeEvent(this.params);

  final AddressCodeRequestParams params;

  @override
  List<Object> get props => [];
}

class AddressCodeSearch extends AddressCodeEvent {
  const AddressCodeSearch(AddressCodeRequestParams params) : super(params);
}
