import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:creditcard/bloc/countries_bloc/countries_bloc.dart';
import 'package:creditcard/bloc/creditcard_bloc/credit_cards_bloc.dart';
import 'package:creditcard/models/credit_card.dart';
import 'package:creditcard/repositories/creditcard_repository.dart';
import 'package:equatable/equatable.dart';

part 'add_credit_card_event.dart';
part 'add_credit_card_state.dart';

class AddCreditCardBloc extends Bloc<AddCreditCardEvent, AddCreditCardState> {
  final CreditCardRepository _creditCardRepository;
  final CountriesBloc _countriesBloc;
  final CreditCardsBloc _creditCardsBloc;
  AddCreditCardBloc(
      this._creditCardRepository, this._countriesBloc, this._creditCardsBloc)
      : super(const AddCreditCardState()) {
    on<CreditCardAdded>(_onCreditCardAdded);
  }

  Future<FutureOr<void>> _onCreditCardAdded(
      CreditCardAdded event, Emitter<AddCreditCardState> emit) async {
    emit(state.copyWith(blocState: BlocState.loading));

    if (isDuplicate(event.creditCard)) {
      emit(state.copyWith(
          blocState: BlocState.failure, message: "Credit card already added."));
    } else if (isBanned(event.creditCard)) {
      emit(state.copyWith(
          blocState: BlocState.failure,
          message: "Credit card is from the banned country"));
    } else {
      await _creditCardRepository.addCreditCard(event.creditCard);
      emit(state.copyWith(
          blocState: BlocState.success, message: "Card saved successfully"));
    }
  }

  bool isDuplicate(CreditCard creditCard) {
    return _creditCardsBloc.state.creditCards.isEmpty
        ? false
        : _creditCardsBloc.state.creditCards
            .any((element) => element.number == creditCard.number);
  }

  bool isBanned(CreditCard creditCard) {
    return _countriesBloc.state.countries.isEmpty
        ? false
        : _countriesBloc.state.countries.any((element) =>
            element.name == creditCard.issuingCountry &&
            element.isBanned == true);
  }
}
