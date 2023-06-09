part of 'countries_bloc.dart';

class CountriesState extends Equatable {
  final BlocState blocState;
  final List<Country> countries;
  final String? message;
  const CountriesState(
      {this.blocState = BlocState.loading,
      this.countries = const [],
      this.message});

  @override
  List<Object?> get props => [blocState, countries, message];

  CountriesState copyWith(
      {BlocState? blocState, List<Country>? countries, String? message}) {
    return CountriesState(
        blocState: blocState ?? this.blocState,
        countries: countries ?? this.countries,
        message: message ?? this.message);
  }
}
