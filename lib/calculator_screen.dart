import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _equation = "0";
  String _result = "0";
  String _expression = "";

  // Logic for button presses
  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "AC") {
        _equation = "0";
        _result = "0";
      } else if (buttonText == "⌫") {
        _equation = _equation.substring(0, _equation.length - 1);
        if (_equation == "") _equation = "0";
      } else if (buttonText == "=") {
        _expression = _equation;
        _expression = _expression.replaceAll('×', '*').replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(_expression);
          ContextModel cm = ContextModel();
          _result = '${exp.evaluate(EvaluationType.REAL, cm)}';
          // Clean up .0 results
          if(_result.endsWith(".0")) _result = _result.substring(0, _result.length - 2);
        } catch (e) {
          _result = "Error";
        }
      } else {
        if (_equation == "0") {
          _equation = buttonText;
        } else {
          _equation = _equation + buttonText;
        }
      }
    });
  }

  // Custom Button Builder
  Widget buildButton(String text, Color textColor, Color bgColor) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: bgColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            padding: const EdgeInsets.all(24),
          ),
          onPressed: () => buttonPressed(text),
          child: Text(
            text,
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: textColor),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Display Section
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(_equation, style: const TextStyle(fontSize: 32, color: Colors.white54)),
                  const SizedBox(height: 10),
                  Text(_result, style: const TextStyle(fontSize: 64, fontWeight: FontWeight.bold, color: Colors.white)),
                ],
              ),
            ),
          ),
          
          // Buttons Section
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            decoration: const BoxDecoration(
              color: Color(0xFF21212B),
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
            ),
            child: Column(
              children: [
                Row(children: [
                  buildButton("AC", Colors.cyanAccent, const Color(0xFF2D2D37)),
                  buildButton("⌫", Colors.cyanAccent, const Color(0xFF2D2D37)),
                  buildButton("%", Colors.cyanAccent, const Color(0xFF2D2D37)),
                  buildButton("÷", Colors.redAccent, const Color(0xFF2D2D37)),
                ]),
                Row(children: [
                  buildButton("7", Colors.white, const Color(0xFF2D2D37)),
                  buildButton("8", Colors.white, const Color(0xFF2D2D37)),
                  buildButton("9", Colors.white, const Color(0xFF2D2D37)),
                  buildButton("×", Colors.redAccent, const Color(0xFF2D2D37)),
                ]),
                Row(children: [
                  buildButton("4", Colors.white, const Color(0xFF2D2D37)),
                  buildButton("5", Colors.white, const Color(0xFF2D2D37)),
                  buildButton("6", Colors.white, const Color(0xFF2D2D37)),
                  buildButton("-", Colors.redAccent, const Color(0xFF2D2D37)),
                ]),
                Row(children: [
                  buildButton("1", Colors.white, const Color(0xFF2D2D37)),
                  buildButton("2", Colors.white, const Color(0xFF2D2D37)),
                  buildButton("3", Colors.white, const Color(0xFF2D2D37)),
                  buildButton("+", Colors.redAccent, const Color(0xFF2D2D37)),
                ]),
                Row(children: [
                  buildButton(".", Colors.white, const Color(0xFF2D2D37)),
                  buildButton("0", Colors.white, const Color(0xFF2D2D37)),
                  buildButton("00", Colors.white, const Color(0xFF2D2D37)),
                  buildButton("=", Colors.white, Colors.redAccent),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}