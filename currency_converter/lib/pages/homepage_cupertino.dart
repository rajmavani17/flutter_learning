import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CupertinoHomePage extends StatefulWidget {
  const CupertinoHomePage({super.key});

  @override
  State<CupertinoHomePage> createState() => _CupertinoHomePageState();
}

class _CupertinoHomePageState extends State<CupertinoHomePage> {
  Future<Map> getCurrencies() async {
    var uri =
        'https://cdn.jsdelivr.net/npm/@fawazahmed0/currency-api@latest/v1/currencies.json';
    try {
      var response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  @override
  void initState() {
    super.initState();
  }

  final TextEditingController textController = TextEditingController();
  double result = 0.0;

  @override
  Widget build(BuildContext context) {
    // Map currencies = {};
    getCurrencies().then((currencies) {
      currencies = currencies;
    }).catchError((error) {});
    // List currencyListNames = currencies.values.toList();
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Currency Converter'),
        backgroundColor: CupertinoColors.activeOrange,
      ),
      backgroundColor: const Color.fromARGB(255, 236, 235, 235),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              result.toStringAsFixed(2),
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: CupertinoColors.systemPurple,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25.0,
                vertical: 10.0,
              ),
              child: CupertinoTextField(
                controller: textController,
                style: TextStyle(
                  fontSize: 20,
                  color: CupertinoColors.black,
                ),
                keyboardType: TextInputType.numberWithOptions(
                  decimal: true,
                  signed: false,
                ),
                placeholder: 'Enter amount',
                prefix: Icon(CupertinoIcons.money_dollar),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(100),
                  color: CupertinoColors.systemGrey2,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 75.0),
              child: CupertinoButton(
                onPressed: () {
                  debugPrint("Convert clicked");
                  setState(() {
                    result = (double.parse(textController.text) * 81);
                    // result = result;
                  });
                },
                color: CupertinoColors.white,
                child: Text(
                  "Convert",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

  // DropdownButton(
  //   items: currencyListNames
  //       .map<DropdownMenuItem<String>>(
  //         (dynamic currency) => DropdownMenuItem<String>(
  //             value: currency,
  //             child: Text(currency),
  //           ),
  //       )
  //       .toList(),
  //   onChanged: (value) {
  //     print(value);
  //   },
  //   value: 'USD',
  // ),
// class CurrencyInput extends StatefulWidget {
//   const CurrencyInput({super.key});

//   @override
//   State<CurrencyInput> createState() => _CurrencyInputState();
// }

// class _CurrencyInputState extends State<CurrencyInput> {
//   var amount = 0;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       inputFormatters: [
//         FilteringTextInputFormatter.digitsOnly,
//       ],
//       keyboardType: TextInputType.number,
//       decoration: InputDecoration(
//         labelText: 'Enter amount',
//       ),
//     );
//   }
// }
