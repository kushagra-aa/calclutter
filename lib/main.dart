import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'Flutter Calculator'),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: const Center(child: Calculator()),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String text = '';
  int? operand1;
  int? operand2;
  String operato = '';

  changeText(String val) {
    setState(() {
      text = val;
    });
  }

  changeOp1(int v) {
    int val = 0;
    if (operand1 == null) {
      val = v;
    } else {
      val = operand1! * 10 + v;
    }
    setState(() {
      print(val);
      operand1 = val;
      changeText('$val');
    });
  }

  changeOp2(int v) {
    int val = 0;
    if (operand2 == null) {
      val = v;
    } else {
      val = operand2! * 10 + v;
    }
    setState(() {
      operand2 = val;
      changeText('$operand1 $operato $val');
    });
  }

  changeOperato(String v) {
    if (!(operand1 == null)) {
      setState(() {
        operato = v;
        changeText('$operand1 $v ');
      });
    } else {
      return;
    }
  }

  changeOp(int v) {
    if (operato != '') {
      changeOp2(v);
    } else {
      changeOp1(v);
    }
  }

  calculate() {
    late double ans;
    if (operato == '' || operand1 == null || operand2 == null) {
      return;
    }
    switch (operato) {
      case "+":
        ans = (operand1! + operand2!).toDouble();
        break;
      case "-":
        ans = (operand1! - operand2!).toDouble();
        break;
      case "*":
        ans = (operand1! * operand2!).toDouble();
        break;
      case "/":
        ans = operand1! / operand2!;
        break;
      default:
    }
    changeText('$ans');
  }

  reset() {
    setState(() {
      text = '';
      operand1 = null;
      operand2 = null;
      operato = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CalculatorScreen(text: text),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          CalculatorButton(
              text: "7",
              onPressed: () {
                changeOp(7);
              }),
          CalculatorButton(
              text: "8",
              onPressed: () {
                changeOp(8);
              }),
          CalculatorButton(
              text: "9",
              onPressed: () {
                changeOp(9);
              }),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          CalculatorButton(
              text: "4",
              onPressed: () {
                changeOp(4);
              }),
          CalculatorButton(
              text: "5",
              onPressed: () {
                changeOp(5);
              }),
          CalculatorButton(
              text: "6",
              onPressed: () {
                changeOp(6);
              }),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          CalculatorButton(
              text: "1",
              onPressed: () {
                changeOp(1);
              }),
          CalculatorButton(
              text: "2",
              onPressed: () {
                changeOp(2);
              }),
          CalculatorButton(
              text: "3",
              onPressed: () {
                changeOp(3);
              }),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          CalculatorButton(
              text: "+",
              onPressed: () {
                changeOperato("+");
              }),
          CalculatorButton(
              text: "-",
              onPressed: () {
                changeOperato("-");
              }),
          CalculatorButton(
              text: "/",
              onPressed: () {
                changeOperato("/");
              }),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          CalculatorButton(
              text: "*",
              onPressed: () {
                changeOperato("*");
              }),
          CalculatorButton(
              text: "=",
              onPressed: () {
                calculate();
              }),
          CalculatorButton(
              text: "AC",
              onPressed: () {
                reset();
              }),
        ]),
      ],
    );
  }
}

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10.0),
      child: Text(text, style: const TextStyle(fontSize: 40.0)),
    );
  }
}

class CalculatorButton extends StatelessWidget {
  const CalculatorButton(
      {super.key, required this.text, required this.onPressed});
  final void Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        foregroundColor: Theme.of(context).colorScheme.background,
        shape: const ContinuousRectangleBorder(),
        fixedSize: const Size(100.0, 80.0),
      ),
      child: Text(text, style: const TextStyle(fontSize: 20.0)),
    );
  }
}
