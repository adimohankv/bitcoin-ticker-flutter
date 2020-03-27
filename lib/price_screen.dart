import 'package:flutter/material.dart';

import './coin_data.dart';
import './components/dropdown.dart';
import './services/api.dart';
import './components/cryptoCard.dart';
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  Map<String, String> cryptoPriceMap = new Map();
  bool dataRetrieved = false;

  void onCurrencyChange(String value) {
    setState(() {
      selectedCurrency = value;
      getPrices();
    });
  }

  List<CryptoCard> getCardList() {
    List<CryptoCard> cardList = [];

    if (dataRetrieved) {
      cryptoPriceMap.forEach((crypto, price) {
        cardList.add(CryptoCard(
            crypto: crypto, selectedCurrency: selectedCurrency, price: price));
      });
    } else {
      for (var crypto in cryptoList) {
        cryptoPriceMap[crypto] = '?';

        cardList.add(CryptoCard(
            crypto: crypto, selectedCurrency: selectedCurrency, price: '?'));
      }
    }

    return cardList;
  }

  void getPrices() async {
    // try {
    List<double> priceList = await getCryptoRates(selectedCurrency);

    // setState(() {
    //   for (int i = 0; i < cryptoList.length; i++) {
    //     cryptoPriceMap[cryptoList[i]] = priceList[i].toStringAsFixed(2);
    //   }

    //   dataRetrieved = true;
    // });
    // } catch (error) {
    //   print('Failure in getting price $error');
    // }
  }

  @override
  void initState() {
    super.initState();
    getPrices();
    print('inside initState');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ...getCardList(),
            Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: CustomDropdown(
                  dropdownList: currenciesList,
                  onChanged: onCurrencyChange,
                  defaultItem: selectedCurrency),
            ),
          ]),
    );
  }
}
