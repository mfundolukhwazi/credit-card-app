import 'package:credit_card_scanner/credit_card_scanner.dart';
import 'package:creditcard/bloc/add_credit_card_bloc/add_credit_card_bloc.dart';
import 'package:creditcard/models/credit_card.dart';
import 'package:creditcard/ui/widgets/dropdown_input.dart';
import 'package:creditcard/ui/widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as services;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/countries_bloc/countries_bloc.dart';

class AddCard extends StatefulWidget {
  const AddCard({Key? key}) : super(key: key);

  @override
  State<AddCard> createState() => _AddCardState();
}

// ignore: constant_identifier_names
enum CardType { Visa, Master, AmericanExpress, Discover, Other }

class _AddCardState extends State<AddCard> {
  TextEditingController cardNumberCtrl = TextEditingController();
  TextEditingController cardCVVCtrl = TextEditingController();
  TextEditingController cardTypeCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? selectedCountry;

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void clearAllData() {
    cardNumberCtrl.clear();
    cardTypeCtrl.clear();
    cardCVVCtrl.clear();
    selectedCountry = null;
  }

  inferCardType() {
    String input = cardNumberCtrl.text;
    print("here is the input $input");
    if (input.startsWith(RegExp(
        r'((5[1-5])|(222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720))'))) {
      cardTypeCtrl.text = getCardTypeString(CardType.Master);
    } else if (input.startsWith(RegExp(r'[4]'))) {
      setState(() {
        cardTypeCtrl.text = getCardTypeString(CardType.Visa);
      });
    } else if (input.startsWith(RegExp(r'((34)|(37))'))) {
      cardTypeCtrl.text = getCardTypeString(CardType.AmericanExpress);
    } else if (input.startsWith(RegExp(r'((6[45])|(6011))'))) {
      cardTypeCtrl.text = getCardTypeString(CardType.Discover);
    } else {
      cardTypeCtrl.text = getCardTypeString(CardType.Other);
    }
  }

  String getCardTypeString(CardType cardType) {
    switch (cardType) {
      case CardType.Visa:
        return "Visa";
      case CardType.Master:
        return "Master Card";
      case CardType.AmericanExpress:
        return "American Express";
      case CardType.Discover:
        return "Discover";
      default:
        return "Other";
    }
  }

  @override
  void initState() {
    cardNumberCtrl.addListener(inferCardType);
    super.initState();
  }

  @override
  void dispose() {
    cardNumberCtrl.removeListener(inferCardType);
    cardNumberCtrl.dispose();
    cardTypeCtrl.dispose();
    cardCVVCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Credit Card"),
        actions: [
          IconButton(
              onPressed: () async {
                var cardDetails = await CardScanner.scanCard();
                if (cardDetails != null) {
                  setState(() {
                    cardNumberCtrl.text = cardDetails.cardNumber;
                  });
                }
              },
              icon: const Icon(Icons.camera_alt))
        ],
      ),
      body: BlocConsumer<AddCreditCardBloc, AddCreditCardState>(
        listener: (context, state) {
          if (state.blocState == BlocState.success) {
            showSnackBar(state.message!);
            clearAllData();
          } else if (state.blocState == BlocState.failure) {
            showSnackBar(state.message!);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextInput(
                      textEditingController: cardNumberCtrl,
                      title: "Card Number",
                      inputFormatters: [
                        services.FilteringTextInputFormatter.digitsOnly,
                        services.LengthLimitingTextInputFormatter(19),
                      ],
                      onSaved: (String? value) {
                        if (value != null) {
                          cardNumberCtrl.text =
                              value.replaceAll(RegExp(r"[^0-9]"), '');
                        }
                      },
                      onValidate: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Enter card number";
                        } else {
                          if (value.length < 8) {
                            return "Card number is not valid";
                          }
                          int sum = 0;
                          int length = value.length;
                          for (var i = 0; i < length; i++) {
                            int digit = int.parse(value[length - i - 1]);

                            if (i % 2 == 1) {
                              digit *= 2;
                            }
                            sum += digit > 9 ? (digit - 9) : digit;
                          }

                          if (sum % 10 == 0) {
                            return null;
                          }

                          return "Card number is not valid";
                        }
                      },
                      isTextEditable: true),
                  TextInput(
                      textEditingController: cardTypeCtrl,
                      title: "Card Type",
                      inputFormatters: const [],
                      onSaved: (String? value) {},
                      onValidate: (String? value) {},
                      isTextEditable: false),
                  TextInput(
                    textEditingController: cardCVVCtrl,
                    title: "CVV",
                    subtitle: "Enter the three numbers at the back of the card",
                    inputFormatters: [
                      services.FilteringTextInputFormatter.digitsOnly,
                      services.LengthLimitingTextInputFormatter(3),
                    ],
                    onSaved: (String? value) {},
                    onValidate: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Enter card cvv";
                      } else if (value.length < 3) {
                        return "Cvv needs to be 3 digits";
                      }
                    },
                    isTextEditable: true,
                  ),
                  BlocConsumer<CountriesBloc, CountriesState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state.blocState == BlocState.success) {
                        return DropDownInput(
                            title: "Issuing Country",
                            subtitle:
                                "Select the country in which the credit card was issued",
                            onDropdownChange: (value) {
                              selectedCountry = value;
                            },
                            options: state.countries
                                .map((country) => country.name)
                                .toList());
                      } else {
                        return const Text(
                            "Countries could not be loaded. Please check your internet and restart the app");
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate() &&
                            selectedCountry != null) {
                          BlocProvider.of<AddCreditCardBloc>(context).add(
                              CreditCardAdded(CreditCard(
                                  number: cardNumberCtrl.text,
                                  type: cardTypeCtrl.text,
                                  cvv: cardCVVCtrl.text,
                                  issuingCountry: selectedCountry!)));
                        } else {
                          showSnackBar(
                              "Plase make sure to input all the card information");
                        }
                      },
                      child: const Text("Add Card"))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
