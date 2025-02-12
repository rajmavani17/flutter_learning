import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MaterialHomePage extends StatefulWidget {
  const MaterialHomePage({super.key});

  @override
  State<MaterialHomePage> createState() => _MaterialHomePageState();
}

class _MaterialHomePageState extends State<MaterialHomePage> {
  late List<String> currencyNameList = [];
  late Map<String, dynamic> currencyNames = {};
  late Map<String, double> exchangeRates = {};
  final TextEditingController amountController = TextEditingController();
  final TextEditingController fromCurrController = TextEditingController();
  double result = 0.0;
  String fromCurrency = '1inch';
  String toCurrency = '1inch';

  @override
  void initState() {
    super.initState();
    getCurrencies().then((currenciesMap) {
      var list = currenciesMap.values.toList();
      currencyNameList = list.map((e) => e.toString()).toList();
      currencyNames = currenciesMap;
      setState(() {
        fromCurrency = currencyNameList.isNotEmpty ? currencyNameList[0] : '';
        toCurrency = currencyNameList.isNotEmpty ? currencyNameList[0] : '';
      });
    }).catchError((error) {
      throw Exception(error);
    });
    getCurrencyExchangeRates().then((exchangeRateMap) {
      exchangeRateMap = exchangeRateMap['eur'];
      for (var currency in exchangeRateMap.keys) {
        var name = currencyNames[currency];
        if (exchangeRateMap[currency].runtimeType != double) {
          exchangeRates[name] =
              double.parse((exchangeRateMap[currency]).toString());
        } else {
          exchangeRates[name] = exchangeRateMap[currency];
        }
      }
      print(exchangeRates);
    }).catchError((error) {
      throw Exception(error);
    });
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  Future<Map<String, dynamic>> getCurrencies() async {
    var currencyNamesUrl =
        'https://cdn.jsdelivr.net/npm/@fawazahmed0/currency-api@latest/v1/currencies.json';
    try {
      var response = await http.get(Uri.parse(currencyNamesUrl));
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        return jsonResponse;
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<Map<String, dynamic>> getCurrencyExchangeRates() async {
    var exchangeRateUrl =
        'https://cdn.jsdelivr.net/npm/@fawazahmed0/currency-api@latest/v1/currencies/eur.json';
    try {
      var response = await http.get(Uri.parse(exchangeRateUrl));
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        return jsonResponse;
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Widget getDropDown(
      {required String value,
      required String hint,
      required void Function(String?) onChanged}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            hint,
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          DropdownButton<String>(
            value: value,
            onChanged: onChanged,
            items: currencyNameList
                .map<DropdownMenuItem<String>>((String currency) {
              return DropdownMenuItem<String>(
                value: currency,
                child: Text(currency),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget getConvertButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 75.0),
      child: TextButton(
        onPressed: () {
          setState(() {
            result = getExchangedAmount(
                fromCurrency: fromCurrency,
                toCurrency: toCurrency,
                amount: amountController.text);
            // result = result;
          });
        },
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.white),
          padding: WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
          ),
          foregroundColor: WidgetStatePropertyAll(
            const Color.fromARGB(255, 123, 123, 123),
          ),
          minimumSize: WidgetStatePropertyAll(
            Size(double.infinity, 50),
          ),
          textStyle: WidgetStatePropertyAll(
            TextStyle(fontSize: 20),
          ),
        ),
        child: Text(
          "Convert",
        ),
      ),
    );
  }

  Widget getExchangedAmountUI() {
    return Column(
      children: [
        Text(
          'Exchange Amount',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        Text(
          result.toStringAsFixed(2),
          style: TextStyle(
            fontSize: 90,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
      ],
    );
  }

  double getExchangedAmount(
      {required String fromCurrency,
      required String toCurrency,
      required String amount}) {
    var fromCurrencyRate = exchangeRates[fromCurrency];
    var toCurrencyRate = exchangeRates[toCurrency];
    var amountToConvert = double.parse(amount);
    var result = (amountToConvert / fromCurrencyRate!) * toCurrencyRate!;
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency Converter'),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      backgroundColor: const Color.fromARGB(255, 236, 235, 235),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getExchangedAmountUI(),
            SizedBox(
              height: 120,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25.0,
                vertical: 10.0,
              ),
              child: TextField(
                controller: amountController,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
                keyboardType: TextInputType.numberWithOptions(
                  decimal: true,
                  signed: false,
                ),
                decoration: InputDecoration(
                  labelText: 'Enter amount',
                  prefixIcon: Icon(Icons.monetization_on),
                  filled: true,
                  fillColor: Colors.grey[200],
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(100),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            getDropDown(
                value: fromCurrency,
                hint: 'From',
                onChanged: (value) {
                  setState(() {
                    fromCurrency = value!;
                  });
                }),
            getDropDown(
                value: toCurrency,
                hint: 'To',
                onChanged: (value) {
                  setState(() {
                    toCurrency = value!;
                  });
                }),
            SizedBox(
              height: 25,
            ),
            getConvertButton(),
          ],
        ),
      ),
    );
  }
}
