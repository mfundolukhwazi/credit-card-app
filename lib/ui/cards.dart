import 'package:creditcard/bloc/add_credit_card_bloc/add_credit_card_bloc.dart';
import 'package:creditcard/bloc/creditcard_bloc/credit_cards_bloc.dart';
import 'package:creditcard/ui/add_card.dart';
import 'package:creditcard/ui/banned_countries.dart';
import 'package:creditcard/ui/widgets/card_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Cards extends StatefulWidget {
  const Cards({Key? key}) : super(key: key);

  @override
  State<Cards> createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Credit Cards"), actions: [
        IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const BannedCountries()),
              );
            },
            icon: const Icon(Icons.list, color: Colors.white))
      ]),
      body: BlocBuilder<CreditCardsBloc, CreditCardsState>(
          builder: (context, state) {
        if (state.blocState == BlocState.success) {
          return state.creditCards.isNotEmpty
              ? ListView.builder(
                  itemCount: state.creditCards.length,
                  itemBuilder: ((context, index) {
                    return CardView(creditCard: state.creditCards[index]);
                  }))
              : const Center(child: Text("No credit cards saved"));
        } else if (state.blocState == BlocState.failure) {
          return Center(child: Text(state.message!));
        } else {
          return const Center(
              child: Column(
            children: [CircularProgressIndicator(), Text("Please wait...")],
          ));
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddCard()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
