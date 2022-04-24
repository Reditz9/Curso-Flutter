import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CoinField extends StatefulWidget {
  final String? currencyName;
  final String? currencySymbol;
  final void Function(String)? convert;

  final TextEditingController currencyController;

  const CoinField(
    this.currencyName,
    this.currencySymbol,
    this.currencyController,
    this.convert, {
    Key? key,
  }) : super(key: key);

  @override
  State<CoinField> createState() => CoinFieldState();
}

class CoinFieldState extends State<CoinField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) => widget.convert!(widget.currencyName!),
      controller: widget.currencyController,
      keyboardType: TextInputType.number,
      inputFormatters: [
        //FilteringTextInputFormatter.digitsOnly,
        FilteringTextInputFormatter.deny(',', replacementString: '.'),
        FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d{0,3})')),
      ],
      style: const TextStyle(color: Colors.amber),
      decoration: InputDecoration(
        labelText: widget.currencyName,
        labelStyle: const TextStyle(color: Colors.amber),
        prefixText: "${widget.currencySymbol} ",
        prefixStyle: const TextStyle(color: Colors.amber),
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        enabledBorder:
            const OutlineInputBorder(borderSide: BorderSide(color: Colors.amber, width: 2.0)),
      ),
    );
  }
}

//BACKUP

// TextField(
          //   style: TextStyle(color: Colors.amber),
          //   decoration: InputDecoration(
          //     labelText: "REAIS",
          //     labelStyle: TextStyle(color: Colors.amber),
          //     prefixText: "R\$ ",
          //     prefixStyle: TextStyle(color: Colors.amber),
          //     focusedBorder: OutlineInputBorder(
          //         borderSide: BorderSide(color: Colors.white)),
          //     enabledBorder: OutlineInputBorder(
          //         borderSide: BorderSide(color: Colors.amber, width: 2.0)),
          //   ),
          // ),