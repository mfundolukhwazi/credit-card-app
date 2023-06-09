import 'package:creditcard/models/credit_card.dart';
import 'package:creditcard/service/app_service.dart';
import 'package:creditcard/service/credit_card_dao.dart';

class CreditCardRepository {
  final AppService appService;
  final CreditCardDao _creditCardDao;

  CreditCardRepository(this.appService, this._creditCardDao);

  Stream<List<CreditCard>> getAllCreditCards() {
    return _creditCardDao.findAllCreditCards();
  }

  Future<void> addCreditCard(CreditCard creditCard) {
    return _creditCardDao.insertCreditCard(creditCard);
  }
}
