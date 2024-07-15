import 'package:flutter/material.dart';

void main() {
  runApp(MyCalculatorApp());
}

class MyCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _output = "0";
  String _operand1 = "";
  String _operand2 = "";
  String _operator = "";

  void _buttonPressed(String value) {
    setState(() {
      if (value == "C") {
        _output = "0";
        _operand1 = "";
        _operand2 = "";
        _operator = "";
      } else if (value == "=") {
        _operand2 = _output;
        if (_operator.isNotEmpty) {
          _output = _calculate().toString();
          _operand1 = _output;
          _operator = "";
          _operand2 = "";
        }
      } else if (["+", "-", "*", "/"].contains(value)) {
        if (_operand1.isEmpty) {
          _operand1 = _output;
        }
        _operator = value;
        _output = "0";
      } else {
        if (_output == "0") {
          _output = value;
        } else {
          _output += value;
        }
      }
    });
  }

  double _calculate() {
    double num1 = double.parse(_operand1);
    double num2 = double.parse(_operand2);
    switch (_operator) {
      case "+":
        return num1 + num2;
      case "-":
        return num1 - num2;
      case "*":
        return num1 * num2;
      case "/":
        return num1 / num2;
      default:
        return 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              _output,
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton("7"), _buildButton("8"), _buildButton("9"), _buildButton("/")
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton("4"), _buildButton("5"), _buildButton("6"), _buildButton("*")
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton("1"), _buildButton("2"), _buildButton("3"), _buildButton("-")
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton("C"), _buildButton("0"), _buildButton("=", color: Colors.green), _buildButton("+")
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String value, {Color color = Colors.blue}) {
    return ElevatedButton(
      onPressed: () => _buttonPressed(value),
      child: Text(value, style: TextStyle(fontSize: 24)),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(20),
        //primary: color,
        shape: CircleBorder(),
      ),
    );
  }
}
