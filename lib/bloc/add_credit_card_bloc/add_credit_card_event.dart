part of 'add_credit_card_bloc.dart';

abstract class AddCreditCardEvent extends Equatable {
  const AddCreditCardEvent();

  @override
  List<Object> get props => [];
}

class CreditCardAdded extends AddCreditCardEvent {
  final CreditCard creditCard;

  const CreditCardAdded(this.creditCard);

  @override
  List<Object> get props => [creditCard];
}
