import 'package:creditcard/models/credit_card.dart';
import 'package:flutter/material.dart';

class CardView extends StatelessWidget {
  final CreditCard creditCard;
  const CardView({Key? key, required this.creditCard}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
            title: Text(creditCard.number),
            subtitle: Text(creditCard.type),
            trailing: Text("CVV ${creditCard.cvv}")));
  }
}
