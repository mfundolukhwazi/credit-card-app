import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:creditcard/models/country.dart';
import 'package:creditcard/models/credit_card.dart';
import 'package:creditcard/service/country_dao.dart';
import 'package:creditcard/service/credit_card_dao.dart';
import 'package:floor/floor.dart';

part 'floor_db.g.dart';

@Database(version: 1, entities: [CreditCard, Country])
abstract class FloorDB extends FloorDatabase {
  CreditCardDao get creditCardDao;
  CountryDao get countryDao;
}
