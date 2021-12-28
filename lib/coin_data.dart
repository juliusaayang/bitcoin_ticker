import 'dart:convert';

import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NGN',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR',
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
  'BNB',
];

const coinAPIUrl = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '3BABE6ED-702A-4BCE-A6EF-8F1A52006848';

class CoinData {
  Future getCoinData(String? selectedCurrency) async {
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      String requestURL =
          '$coinAPIUrl/$crypto/$selectedCurrency?apikey=$apiKey';
      http.Response response = await http.get(
        Uri.parse(requestURL),
      );
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        double price = decodedData['rate'];
        cryptoPrices[crypto] = price.toStringAsFixed(0);
      } else {
        print(response.statusCode);
        throw 'problem with the get request';
      }
    }
    return cryptoPrices;
  }
}
