import 'dart:convert';

import 'package:flutter/services.dart';

class AppService {
  final String storageFile = "assets/storage.json";

  Future<List> getCreditAllCards() async {
    var data = await rootBundle.loadString(storageFile);
    var response = jsonDecode(data);
    return response["credit_cards"];
  }

  Future<List> getBannedCountries() async {
    var data = await rootBundle.loadString(storageFile);
    var response = jsonDecode(data);
    return response["banned_countries"];
  }
}
