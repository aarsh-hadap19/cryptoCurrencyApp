import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'home_page.dart';

void main() async {
  Map<String, dynamic> currenciesMap = await getCurrencies();
  List<dynamic> currencies = currenciesMap['data'];
  print(currencies);
  runApp(MyApp(currencies));
}

class MyApp extends StatefulWidget {
  final List<dynamic> currencies;

  const MyApp(this.currencies);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.pink),
      home: HomePage(widget.currencies),
      debugShowCheckedModeBanner: false,
    );
  }
}

Future<Map<String, dynamic>> getCurrencies() async {
  String cryptoUrl = "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?CMC_PRO_API_KEY=10f98f30-2a86-419f-8a82-75ffcc0f6f13";

  final response = await http.get(Uri.parse(cryptoUrl));

  if (response.statusCode == 200) {
    final responseBody = response.body;
    if (responseBody != null && responseBody.isNotEmpty) {
      return jsonDecode(responseBody);
    } else {
      throw Exception('Response body is empty or null');
    }
  } else {
    throw Exception('Failed to load currencies');
  }
}
