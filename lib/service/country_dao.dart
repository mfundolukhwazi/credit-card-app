import 'package:creditcard/models/country.dart';
import 'package:floor/floor.dart';

@dao
abstract class CountryDao {
  @Query('SELECT * FROM Country')
  Stream<List<Country>> findAllCountries();

  @Query('SELECT * FROM Country where is_banned = true')
  Stream<List<Country>> findAllBannedCountries();

  @update
  Future<void> updateCountry(Country country);

  @insert
  Future<void> insertCountry(Country country);

  @insert
  Future<void> insertCountries(List<Country> countries);
}
