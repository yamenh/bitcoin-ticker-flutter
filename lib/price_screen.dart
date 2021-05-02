import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'exchange.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  double price;

  String selectedCurrency = 'USD';

  void updateScreen(dynamic coin) {
    setState(() {
      if (coin == null) {
        price = 0.0;

        return;
      }
      price = coin['rate'];
    });
  }

  void getValue() async {
    ExchangeModel exchangeModel = ExchangeModel();
    var x = await exchangeModel.getBitcoin(selectedCurrency);

    updateScreen(x);
  }

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(
          currency,
          style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold,color: Colors.green),
        ),
        value: currency,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          getValue();
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
    //  backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
        getValue();
      },
      children: pickerItems,
    );
  }

  // ignore: missing_return
  Widget getPicker() {
    if (Platform.isIOS) {
      return iOSPicker();
    } else if (Platform.isAndroid) {
      return androidDropdown();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('Coin Ticker'),
            Icon(Icons.attach_money_rounded,color: Colors.green,)
          ],
        ),
      ),
      body:Container(


        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background1.jpg'),
            fit: BoxFit.fitHeight,
          ),
        ),


     child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[

          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 0.0, 18.0, 0.0),
            child: Card(
              color: Colors.black,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $price $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
            ),
          ),

          Container(
           // height: 100.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 1.0),
            color: Colors.black,
            child: getPicker(),
          ),
        ],
      ),
    ),
    );
  }
}
