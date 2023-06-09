part of 'credit_cards_bloc.dart';

class CreditCardsState extends Equatable {
  final BlocState blocState;
  final String? message;
  final List<CreditCard> creditCards;
  const CreditCardsState(
      {this.blocState = BlocState.loading,
      this.message,
      this.creditCards = const []});

  @override
  List<Object?> get props => [blocState, message, creditCards];

  CreditCardsState copyWith(
      {BlocState? blocState, String? message, List<CreditCard>? creditCards}) {
    return CreditCardsState(
        blocState: blocState ?? this.blocState,
        message: message ?? this.message,
        creditCards: creditCards ?? this.creditCards);
  }
}
