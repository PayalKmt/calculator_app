import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  void buttonPressed(String buttonText) {
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
          // ignore: deprecated_member_use
          Parser p = Parser();
          Expression exp = p.parse(_expression);
          ContextModel cm = ContextModel();
          _result = '${exp.evaluate(EvaluationType.REAL, cm)}';
          // Clean up .0 results
          if (_result.endsWith(".0")) {
            _result = _result.substring(0, _result.length - 2);
          }
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
        margin: EdgeInsets.all(8.r),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: bgColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            padding: EdgeInsets.all(24.r),
          ),

          onPressed: () => buttonPressed(text),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
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
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _equation,
                    style: TextStyle(fontSize: 30.sp, color: Colors.white54),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    _result,
                    style: TextStyle(
                      fontSize: 56.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Buttons Section
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: const Color(0xFF21212B),
              borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    buildButton(
                      "AC",
                      Colors.cyanAccent,
                      const Color(0xFF2D2D37),
                    ),
                    buildButton(
                      "⌫",
                      Colors.cyanAccent,
                      const Color(0xFF2D2D37),
                    ),
                    buildButton(
                      "%",
                      Colors.cyanAccent,
                      const Color(0xFF2D2D37),
                    ),
                    buildButton("÷", Colors.redAccent, const Color(0xFF2D2D37)),
                  ],
                ),
                Row(
                  children: [
                    buildButton("7", Colors.white, const Color(0xFF2D2D37)),
                    buildButton("8", Colors.white, const Color(0xFF2D2D37)),
                    buildButton("9", Colors.white, const Color(0xFF2D2D37)),
                    buildButton("×", Colors.redAccent, const Color(0xFF2D2D37)),
                  ],
                ),
                Row(
                  children: [
                    buildButton("4", Colors.white, const Color(0xFF2D2D37)),
                    buildButton("5", Colors.white, const Color(0xFF2D2D37)),
                    buildButton("6", Colors.white, const Color(0xFF2D2D37)),
                    buildButton("-", Colors.redAccent, const Color(0xFF2D2D37)),
                  ],
                ),
                Row(
                  children: [
                    buildButton("1", Colors.white, const Color(0xFF2D2D37)),
                    buildButton("2", Colors.white, const Color(0xFF2D2D37)),
                    buildButton("3", Colors.white, const Color(0xFF2D2D37)),
                    buildButton("+", Colors.redAccent, const Color(0xFF2D2D37)),
                  ],
                ),
                Row(
                  children: [
                    buildButton(".", Colors.white, const Color(0xFF2D2D37)),
                    buildButton("0", Colors.white, const Color(0xFF2D2D37)),
                    buildButton("00", Colors.white, const Color(0xFF2D2D37)),
                    buildButton("=", Colors.white, Colors.redAccent),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
