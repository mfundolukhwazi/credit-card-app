import 'package:creditcard/bloc/add_credit_card_bloc/add_credit_card_bloc.dart';
import 'package:creditcard/bloc/countries_bloc/countries_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BannedCountries extends StatefulWidget {
  const BannedCountries({Key? key}) : super(key: key);

  @override
  State<BannedCountries> createState() => _BannedCountriesState();
}

class _BannedCountriesState extends State<BannedCountries> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Countries")),
        body: BlocBuilder<CountriesBloc, CountriesState>(
          builder: (context, state) {
            if (state.blocState == BlocState.success) {
              return state.countries!.isNotEmpty
                  ? ListView.builder(
                      itemCount: state.countries!.length,
                      itemBuilder: ((context, index) {
                        return Card(
                            child: ListTile(
                          leading: Checkbox(
                              value: state.countries![index].isBanned,
                              onChanged: (value) {
                                BlocProvider.of<CountriesBloc>(context).add(
                                    ToggleBanCountry(state.countries![index]));
                              }),
                          title: Text(state.countries![index].name),
                          subtitle: state.countries![index].isBanned
                              ? const Text("Banned")
                              : const SizedBox.shrink(),
                        ));
                      }))
                  : const Center(child: Text("There are no countries"));
            } else if (state.blocState == BlocState.failure) {
              return Center(child: Text(state.message!));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
