import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:creditcard/bloc/add_credit_card_bloc/add_credit_card_bloc.dart';
import 'package:creditcard/models/credit_card.dart';
import 'package:creditcard/repositories/creditcard_repository.dart';
import 'package:equatable/equatable.dart';

part 'credit_cards_event.dart';
part 'credit_cards_state.dart';

class CreditCardsBloc extends Bloc<CreditCardsEvent, CreditCardsState> {
  final CreditCardRepository _creditCardRepository;
  late StreamSubscription _creaditCardStreamSubscription;
  CreditCardsBloc(this._creditCardRepository)
      : super(const CreditCardsState()) {
    _creaditCardStreamSubscription =
        _creditCardRepository.getAllCreditCards().listen((creditCards) {
      add(CreditCardFetched(creditCards));
    });
    on<CreditCardFetched>(_onCreditCardFetched);
  }

  Future<FutureOr<void>> _onCreditCardFetched(
      CreditCardFetched event, Emitter<CreditCardsState> emit) async {
    try {
      emit(state.copyWith(
          blocState: BlocState.success, creditCards: event.creditCards));
    } catch (e) {
      emit(state.copyWith(
          blocState: BlocState.failure,
          message: "Something went wrong. Please see $e"));
    }
  }
}
