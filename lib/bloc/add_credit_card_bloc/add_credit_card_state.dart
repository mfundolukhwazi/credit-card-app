part of 'add_credit_card_bloc.dart';

enum BlocState { initial, loading, success, failure }

class AddCreditCardState extends Equatable {
  final BlocState blocState;
  final String? message;
  const AddCreditCardState({this.blocState = BlocState.initial, this.message});

  @override
  List<Object?> get props => [blocState, message];

  AddCreditCardState copyWith({BlocState? blocState, String? message}) {
    return AddCreditCardState(
        blocState: blocState ?? this.blocState,
        message: message ?? this.message);
  }
}
