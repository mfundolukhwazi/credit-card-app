import 'package:creditcard/models/credit_card.dart';
import 'package:floor/floor.dart';

@dao
abstract class CreditCardDao {
  @Query('SELECT * FROM CreditCard')
  Stream<List<CreditCard>> findAllCreditCards();

  @insert
  Future<void> insertCreditCard(CreditCard creditCard);
}
