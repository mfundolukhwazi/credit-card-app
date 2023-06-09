import 'package:creditcard/models/country.dart';
import 'package:creditcard/service/countries_service.dart';
import 'package:creditcard/service/country_dao.dart';

class CountryRepository {
  final CountryService _countryService;
  final CountryDao _countryDao;

  CountryRepository(this._countryService, this._countryDao);

  Future<void> downloadCountries() async {
    List<Country> countries = await _countryService.getCountries().then(
        (value) => value
            .map((e) => Country(name: e["name"]["official"], isBanned: false))
            .toList());
    if (countries.isNotEmpty) {
      addCountries(countries);
    }
  }

  Stream<List<Country>> getAllCountries() {
    return _countryDao.findAllCountries();
  }

  Stream<List<Country>> getAllBannedCountries() {
    return _countryDao.findAllBannedCountries();
  }

  Future<void> addCountries(List<Country> countries) async {
    await _countryDao.insertCountries(countries);
  }

  Future<void> updateCountry(Country country) async {
    await _countryDao.updateCountry(country);
  }
}
