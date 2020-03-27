import 'package:http/http.dart' as http;
import 'dart:convert';

import '../coin_data.dart';

Future<List<double>> getCryptoRates(String currency) async {
  var client = http.Client();
  const apiKey = 'api-key';
  const headers = {'X-CoinAPI-Key': apiKey};

  List<http.Response> responseList = await Future.wait(cryptoList.map(
      (crypto) => client.get(
          'https://rest.coinapi.io/v1/exchangerate/$crypto/$currency',
          headers: headers)));

  return responseList
      .map((response) => json.decode(response.body)['rate'])
      .toList();
}
