import 'package:conversor_de_moedas/coinfield.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'coinfield.dart';

const requestAPI = 'https://economia.awesomeapi.com.br/last/USD-BRL,USD-EUR,EUR-BRL,EUR-USD';
Map<String, dynamic>? data;

void main() async {
  data = await getData();
  runApp(
    const MaterialApp(
      title: 'Conversor \$"',
      home: MainPage(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

Future<Map<String, dynamic>> getData() async {
  http.Response response = await http.get(Uri.parse(requestAPI));
  return jsonDecode(response.body);
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // void Function() conversao(String a){...}
  // VoidCallback? conversao(String a) {
  void Function()? conversao(String id) {
    TextEditingController controller = TextEditingController();
    double brl;
    double usd;
    double eur;

    switch (id) {
      case ('Reais'):
        controller = brlController;
        if (controller.text.isNotEmpty) {
          brl = double.parse(brlController.text);
          usd = brl / double.parse(data!['USDBRL']['ask']);
          eur = brl / double.parse(data!['EURBRL']['ask']);
          usdController.text = usd.toStringAsPrecision(3);
          eurController.text = eur.toStringAsPrecision(3);
        } else {
          usdController.text = '';
          eurController.text = '';
        }
        break;
      case ('Dólares'):
        controller = usdController;
        if (controller.text.isNotEmpty) {
          usd = double.parse(controller.text);
          brl = double.parse(data!['USDBRL']['ask']) * usd;
          eur = double.parse(data!['USDEUR']['ask']) * usd;
          brlController.text = brl.toStringAsPrecision(3);
          eurController.text = eur.toStringAsPrecision(3);
        } else {
          brlController.text = '';
          eurController.text = '';
        }
        break;
      case ('Euros'):
        controller = eurController;
        if (controller.text.isNotEmpty) {
          eur = double.parse(controller.text);
          usd = double.parse(data!['EURUSD']['ask']) * eur;
          brl = double.parse(data!['EURBRL']['ask']) * eur;
          usdController.text = usd.toStringAsPrecision(3);
          brlController.text = brl.toStringAsPrecision(3);
        } else {
          brlController.text = '';
          usdController.text = '';
        }
        break;
    }
    setState(() {});
    return null;
  }

  TextEditingController brlController = TextEditingController();
  TextEditingController usdController = TextEditingController();
  TextEditingController eurController = TextEditingController();

  Widget app() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(20),
                child: Icon(Icons.monetization_on, size: 150.0, color: Colors.amber),
              ),
              Container(
                  padding: const EdgeInsets.all(8),
                  child: CoinField('Reais', 'R\$', brlController, conversao)),
              Container(
                  padding: const EdgeInsets.all(8),
                  child: CoinField('Dólares', '\$', usdController, conversao)),
              Container(
                  padding: const EdgeInsets.all(8),
                  child: CoinField('Euros', '€', eurController, conversao)),
              // Container(
              //     padding: const EdgeInsets.all(8),
              //     child: CoinField('Euros', '€', eurController, conversao)),
              // Container(
              //     padding: const EdgeInsets.all(8),
              //     child: CoinField('Euros', '€', eurController, conversao)),
              // Container(
              //     padding: const EdgeInsets.all(8),
              //     child: CoinField('Euros', '€', eurController, conversao)),
              // Container(
              //     padding: const EdgeInsets.all(8),
              //     child: CoinField('Euros', '€', eurController, conversao)),
              // Container(
              //     padding: const EdgeInsets.all(8),
              //     child: CoinField('Euros', '€', eurController, conversao)),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 100),
            alignment: Alignment.bottomCenter,
            child: Text(
              'Atualizado em : ${data!['USDBRL']['create_date']}',
              style: const TextStyle(color: Colors.amber),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          title: const Text(
            "Conversor de Moedas",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 255, 196, 0)),
      body: app(),
    );
  }
}
