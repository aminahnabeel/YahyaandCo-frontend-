import 'package:flutter/material.dart';
import '../starting/language/app_language.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _display = '0';
  double? _first;
  String? _op;
  bool _shouldReset = false;

  void _numTap(String s) {
    setState(() {
      if (_shouldReset) {
        _display = '0';
        _shouldReset = false;
      }
      if (_display == '0' && s != '.') {
        _display = s;
      } else if (s == '.' && _display.contains('.')) {
        // do nothing
      } else {
        _display = '$_display$s';
      }
    });
  }

  void _setOp(String op) {
    setState(() {
      _first = double.tryParse(_display.replaceAll(',', '')) ?? 0;
      _op = op;
      _shouldReset = true;
    });
  }

  void _calculate() {
    if (_op == null) return;
    final second = double.tryParse(_display.replaceAll(',', '')) ?? 0;
    double result = 0;
    switch (_op) {
      case '+':
        result = (_first ?? 0) + second;
        break;
      case '-':
        result = (_first ?? 0) - second;
        break;
      case '×':
        result = (_first ?? 0) * second;
        break;
      case '÷':
        result = second == 0 ? 0 : (_first ?? 0) / second;
        break;
    }
    setState(() {
      _display = _format(result);
      _first = result;
      _op = null;
      _shouldReset = true;
    });
  }

  String _format(double v) {
    if (v % 1 == 0) return v.toInt().toString();
    return v.toString();
  }

  void _clear() {
    setState(() {
      _display = '0';
      _first = null;
      _op = null;
      _shouldReset = false;
    });
  }

  void _backspace() {
    setState(() {
      if (_display.length <= 1) {
        _display = '0';
      } else {
        _display = _display.substring(0, _display.length - 1);
      }
    });
  }

  Widget _button(String label, {Color? color, VoidCallback? onTap}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: const EdgeInsets.symmetric(vertical: 18),
          ),
          onPressed: onTap,
          child: Text(label, style: const TextStyle(fontSize: 20)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tr = appLanguageController.tr;
    return Scaffold(
      appBar: AppBar(title: Text(tr('Calculator'))),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(24),
                alignment: Alignment.bottomRight,
                child: Text(
                  _display,
                  style: const TextStyle(fontSize: 48, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Column(
              children: [
                Row(children: [
                  _button('C', color: Colors.grey[300], onTap: _clear),
                  _button('⌫', color: Colors.grey[300], onTap: _backspace),
                  _button('÷', color: Colors.orange[200], onTap: () => _setOp('÷')),
                ]),
                Row(children: [
                  _button('7', onTap: () => _numTap('7')),
                  _button('8', onTap: () => _numTap('8')),
                  _button('9', onTap: () => _numTap('9')),
                  _button('×', color: Colors.orange[200], onTap: () => _setOp('×')),
                ]),
                Row(children: [
                  _button('4', onTap: () => _numTap('4')),
                  _button('5', onTap: () => _numTap('5')),
                  _button('6', onTap: () => _numTap('6')),
                  _button('-', color: Colors.orange[200], onTap: () => _setOp('-')),
                ]),
                Row(children: [
                  _button('1', onTap: () => _numTap('1')),
                  _button('2', onTap: () => _numTap('2')),
                  _button('3', onTap: () => _numTap('3')),
                  _button('+', color: Colors.orange[200], onTap: () => _setOp('+')),
                ]),
                Row(children: [
                  _button('0', onTap: () => _numTap('0')),
                  _button('.', onTap: () => _numTap('.')),
                  _button('=', color: Colors.blueAccent, onTap: _calculate),
                ]),
              ],
            )
          ],
        ),
      ),
    );
  }
}
