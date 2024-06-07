import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final List currencies;

  HomePage(this.currencies);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<MaterialColor> _color = [Colors.indigo, Colors.cyan, Colors.orange];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Crypto App"),
        backgroundColor: Colors.pinkAccent,
      ),
      body: _cryptoWidget(),
    );
  }

  Widget _cryptoWidget() {
    return Container(
      child: ListView.builder(
        itemCount: widget.currencies.length,
        itemBuilder: (BuildContext context, int index) {
          final currency = widget.currencies[index];
          final MaterialColor color = _color[index % _color.length];
          return _getListItemUi(currency, color);
        },
      ),
    );
  }

  Widget _getListItemUi(Map currency, MaterialColor color) {
    final String name = currency['name'];
    final double price = double.tryParse(currency['quote']['USD']['price'].toString()) ?? 0.0;
    final double percentageChange = double.tryParse(currency['quote']['USD']['percent_change_1h'].toString()) ?? 0.0;

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color,
        child: Text(name[0]),
      ),
      title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: _getSubtitleText(price, percentageChange),
      isThreeLine: true,
    );
  }

  Widget _getSubtitleText(double price, double percentageChange) {
    TextSpan priceTextWidget = TextSpan(
      text: "\$ $price\n ",
      style: TextStyle(color: Colors.black),
    );
    String percentageChangeText = "1 Hour: $percentageChange%";
    TextSpan percentageChangeTextWidget;

    if (percentageChange > 0) {
      percentageChangeTextWidget = TextSpan(
        text: percentageChangeText,
        style: TextStyle(color: Colors.green),
      );
    } else {
      percentageChangeTextWidget = TextSpan(
        text: percentageChangeText,
        style: TextStyle(color: Colors.red),
      );
    }

    return RichText(
      text: TextSpan(children: [priceTextWidget, percentageChangeTextWidget]),
    );
  }
}
