import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: TipCalculator(),
    ),
  );
}

class TipCalculator extends StatefulWidget {
  // This widget is the home screen of the Tip Calculator app. It is stateful, since we want
  // to keep track of the TipAmount & TotalAmount and update the UI accordingly
  @override
  _TipCalculatorState createState() => _TipCalculatorState();
}

class _TipCalculatorState extends State<TipCalculator> {
  // This is the default bill amount
  static const initBillAmount = 0.0;

  // This is the default tip percentage
  static const initTipPercent = 15;

  // This is the TextEditingController which is used to keep track of the change in bill amount
  final _billAmountController =
  TextEditingController(text: initBillAmount.toString());

  // This is the TextEditingController which is used to keep track of the change in tip percentage
  final _tipPercentageController =
  TextEditingController(text: initTipPercent.toString());

  // This stores the latest value of bill amount calculated
  double _billAmount = initBillAmount;

  // This stores the latest value of tip percentage calculated
  int _tipPercentage = initTipPercent;

  @override
  void initState() {
    super.initState();
    _billAmountController.addListener(_onBillAmountChanged);
    _tipPercentageController.addListener(_onTipAmountChanged);
  }

  _onBillAmountChanged() {
    // This method tells the Flutter framework that the bill amount has
    // changed in this State, which causes it to rerun the build method of _TipCalculatorState
    // so that the display can reflect the updated value of bill amount
    setState(() {
      _billAmount = double.tryParse(_billAmountController.text) ?? 0.0;
    });
  }

  _onTipAmountChanged() {
    // This method tells the Flutter framework that the tip percentage has
    // changed in this State, which causes it to rerun the build method of _TipCalculatorState
    // so that the display can reflect the updated value of tip percentage
    setState(() {
      _tipPercentage = int.tryParse(_tipPercentageController.text) ?? 0;
    });
  }

  //This method is used to calculate the latest tip amount
  _getTipAmount() => _billAmount * _tipPercentage / 100;

  //This method is used to calculate the latest total amount
  _getTotalAmount() => _billAmount + _getTipAmount();

  @override
  Widget build(BuildContext context) {
    // This method builds the UI of the Tip Calculator.
    return Scaffold(
      appBar: AppBar(
        title: Text('Tip Calculator!'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  key: Key("billAmount"),
                  controller: _billAmountController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    hintText: 'Enter the Bill Amount',
                    labelText: 'Bill Amount',
                  ),
                ),
                TextFormField(
                  key: Key("tipPercentage"),
                  controller: _tipPercentageController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Enter the Tip %',
                    labelText: 'Tip %',
                  ),
                ),
                Text(
                    'Tip Amount: ${_getTipAmount()}'

                ),
                Text(
                    'Total Amount: ${_getTotalAmount()}'
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // To make sure we are not leaking anything, dispose any used TextEditingController
    // when this widget is cleared from memory.
    _billAmountController.dispose();
    _tipPercentageController.dispose();
    super.dispose();
  }
}

