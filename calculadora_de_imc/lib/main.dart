import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  String _imc = "";
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _resetButton() {
    pesoController.text = "";
    alturaController.text = "";
    setState(() {
      _imc = "";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calcular() {
    setState(() {
      double peso = double.parse(pesoController.text);
      double altura = double.parse(alturaController.text) / 100;
      double imc = (peso / pow(altura, 2));

      if (imc < 18.5) {
        _imc = "IMC: Abaixo do peso (${imc.toStringAsPrecision(3)})";
      } else if (imc < 24.9) {
        _imc = "IMC: Peso Ideal (${imc.toStringAsPrecision(3)})";
      } else if (imc < 29.9) {
        _imc = "IMC: Sobrepeso (${imc.toStringAsPrecision(3)})";
      } else if (imc < 34.9) {
        _imc = "IMC: Obesidade Grau I (${imc.toStringAsPrecision(3)})";
      } else if (imc < 39.9) {
        _imc = "IMC: Obesidade Grau II (${imc.toStringAsPrecision(3)})";
      } else {
        _imc = "IMC: Obesidade Grau III (${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: double.infinity,
        title: const Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(onPressed: _resetButton, icon: const Icon(Icons.refresh))
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              const Icon(
                Icons.person,
                color: Colors.green,
                size: 150.0,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Insira o seu Peso";
                            } else {
                              return null;
                            }
                          },
                          controller: pesoController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: const InputDecoration(
                            hintText: "Peso (kg) ",
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 20, left: 10.0, right: 10.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Insira a sua Altura";
                            } else {
                              return null;
                            }
                          },
                          controller: alturaController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: const InputDecoration(
                            hintText: "Altura (cm) ",
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  )),
              Container(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                height: 60,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    onPrimary: Colors.white,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _calcular;
                    }
                  },
                  child: const Text(
                    "Calcular",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _imc,
                  style: const TextStyle(color: Colors.green, fontSize: 20),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
