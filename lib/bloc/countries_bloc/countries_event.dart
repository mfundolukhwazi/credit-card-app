part of 'countries_bloc.dart';

abstract class CountriesEvent extends Equatable {
  const CountriesEvent();

  @override
  List<Object> get props => [];
}

class DownloadCountriesData extends CountriesEvent {}

class ToggleBanCountry extends CountriesEvent {
  final Country country;
  const ToggleBanCountry(this.country);

  @override
  List<Object> get props => [country];
}

class CountriesUpdated extends CountriesEvent {
  final List<Country> countries;
  const CountriesUpdated({
    required this.countries,
  });

  @override
  List<Object> get props => [countries];
}
