import 'package:creditcard/bloc/add_credit_card_bloc/add_credit_card_bloc.dart';
import 'package:creditcard/bloc/countries_bloc/countries_bloc.dart';
import 'package:creditcard/bloc/creditcard_bloc/credit_cards_bloc.dart';
import 'package:creditcard/repositories/countries_repository.dart';
import 'package:creditcard/repositories/creditcard_repository.dart';
import 'package:creditcard/service/app_service.dart';
import 'package:creditcard/service/countries_service.dart';
import 'package:creditcard/service/floor_db.dart';
import 'package:creditcard/ui/cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database =
      await $FloorFloorDB.databaseBuilder('app_database.db').build();
  final AppService appService = AppService();
  final CountryService countryService = CountryService();
  runApp(MultiRepositoryProvider(
    providers: [
      RepositoryProvider<CreditCardRepository>(
        create: (context) =>
            CreditCardRepository(appService, database.creditCardDao),
      ),
      RepositoryProvider<CountryRepository>(
        create: (context) =>
            CountryRepository(countryService, database.countryDao),
      ),
    ],
    child: MultiBlocProvider(providers: [
      BlocProvider<CreditCardsBloc>(
        create: (BuildContext context) =>
            CreditCardsBloc(context.read<CreditCardRepository>()),
      ),
      BlocProvider<CountriesBloc>(
        create: (BuildContext context) =>
            CountriesBloc(context.read<CountryRepository>()),
      ),
      BlocProvider<AddCreditCardBloc>(
        create: (BuildContext context) => AddCreditCardBloc(
          context.read<CreditCardRepository>(),
          context.read<CountriesBloc>(),
          context.read<CreditCardsBloc>(),
        ),
      ),
    ], child: const MyApp()),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Cards(),
    );
  }
}
