part of 'credit_cards_bloc.dart';

abstract class CreditCardsEvent extends Equatable {
  const CreditCardsEvent();

  @override
  List<Object> get props => [];
}

class CreditCardFetched extends CreditCardsEvent {
  final List<CreditCard> creditCards;

  const CreditCardFetched(this.creditCards);
  @override
  List<Object> get props => [creditCards];
}
