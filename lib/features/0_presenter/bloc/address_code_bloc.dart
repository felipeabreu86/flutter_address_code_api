import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_address_code_api/core/params/address_code_request_params.dart';
import 'package:flutter_address_code_api/features/1_domain/entities/address.dart';
import 'package:flutter_address_code_api/features/1_domain/usecases/get_address_usecase.dart';

part 'address_code_event.dart';
part 'address_code_state.dart';

class AddressCodeBloc extends Bloc<AddressCodeEvent, AddressCodeState> {
  AddressCodeBloc(this._getAddressUsecase) : super(AddressCodeInitial()) {
    on<AddressCodeSearch>(
      _addressCodeSearch,
      transformer:
          droppable(), // concurrent, sequential, droppable, restartable
    );
  }

  final GetAddressUsecase _getAddressUsecase;

  FutureOr<void> _addressCodeSearch(
    AddressCodeEvent event,
    Emitter<AddressCodeState> emit,
  ) async {
    emit(AddressCodeLoading());
    final response = await _getAddressUsecase(event.params);
    response.fold(
      (failure) => emit(AddressCodeError(failure.errorMessage)),
      (address) => emit(AddressCodeDone(address)),
    );
  }
}
