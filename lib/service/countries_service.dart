import 'dart:convert';

import 'package:http/http.dart' as http;

class CountryService {
  final String baseUrl = "https://restcountries.com/v3.1/all";

  Future<List> getCountries() async {
    var response = await http.get(Uri.parse(baseUrl));
    return jsonDecode(response.body);
  }
}
