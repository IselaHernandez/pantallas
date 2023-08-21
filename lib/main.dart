import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator Empresa',
      theme: ThemeData.dark(),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _currentInput = '';
  double _result = 0.0;

  void _appendToInput(String value) {
    setState(() {
      _currentInput += value;
    });
  }

  void _calculate() {
    try {
      final parsedInput = double.tryParse(_currentInput);
      if (parsedInput != null) {
        setState(() {
          _result = parsedInput;
          _currentInput = '';
        });
      } else {
        setState(() {
          _currentInput = 'Error';
        });
      }
    } catch (e) {
      setState(() {
        _currentInput = 'Error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(16),
              alignment: Alignment.bottomRight,
              child: Text(
                '$_currentInput',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          _buildButtonRow(['7', '8', '9', '/']),
          _buildButtonRow(['4', '5', '6', '*']),
          _buildButtonRow(['1', '2', '3', '-']),
          _buildButtonRow(['0', '.', '=', '+']),
        ],
      ),
    );
  }

  Widget _buildButtonRow(List<String> buttons) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: buttons.map((text) => _buildButton(text)).toList(),
      ),
    );
  }

  Widget _buildButton(String text) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          if (text == '=') {
            _calculate();
          } else {
            _appendToInput(text);
          }
        },
        style: ElevatedButton.styleFrom(
          primary: text == '=' ? Colors.blue : Colors.grey[800],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 24,
            fontWeight: text == '=' ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
