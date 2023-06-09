import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:creditcard/bloc/add_credit_card_bloc/add_credit_card_bloc.dart';
import 'package:creditcard/models/country.dart';
import 'package:creditcard/repositories/countries_repository.dart';
import 'package:equatable/equatable.dart';

part 'countries_event.dart';
part 'countries_state.dart';

class CountriesBloc extends Bloc<CountriesEvent, CountriesState> {
  final CountryRepository _countryRepository;
  late StreamSubscription _countriesStreamSubscription;
  CountriesBloc(this._countryRepository) : super(const CountriesState()) {
    on<DownloadCountriesData>(_onDownloadCountriesData);
    on<ToggleBanCountry>(_onToggleBanCountry);
    on<CountriesUpdated>(_onCountriesUpdated);

    _countriesStreamSubscription =
        _countryRepository.getAllCountries().listen((countries) {
      add(CountriesUpdated(countries: countries));
      if (countries.isEmpty) {
        add(DownloadCountriesData());
      }
    });
  }

  Future<FutureOr<void>> _onToggleBanCountry(
      ToggleBanCountry event, Emitter<CountriesState> emit) async {
    await _countryRepository.updateCountry(event.country
        .copyWith(isBanned: event.country.isBanned ? false : true));
  }

  FutureOr<void> _onCountriesUpdated(
      CountriesUpdated event, Emitter<CountriesState> emit) {
    emit(state.copyWith(
        blocState: BlocState.success,
        countries: event.countries,
        message: null));
  }

  Future<FutureOr<void>> _onDownloadCountriesData(
      DownloadCountriesData event, Emitter<CountriesState> emit) async {
    emit(state.copyWith(blocState: BlocState.loading));
    await _countryRepository.downloadCountries();
  }
}
