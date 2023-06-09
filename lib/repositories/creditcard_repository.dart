import 'package:creditcard/models/credit_card.dart';
import 'package:creditcard/service/credit_card_dao.dart';

class CreditCardRepository {
  final CreditCardDao _creditCardDao;

  CreditCardRepository(this._creditCardDao);

  Stream<List<CreditCard>> getAllCreditCards() {
    return _creditCardDao.findAllCreditCards();
  }

  Future<void> addCreditCard(CreditCard creditCard) {
    return _creditCardDao.insertCreditCard(creditCard);
  }
}
