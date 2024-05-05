// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unused_element


import 'package:flutter/material.dart';
import 'package:my_calculator/components/buttons.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {

  final List<String> buttons = [
    'C', 'DEL', '()', '+',
    '7', '8', '9', '-',
    '4', '5', '6', 'x',
    '1', '2', '3', '/',
    '.', '0', '%', '=',
  ];

 
 
 bool isOperator(String x) {
  if (x == '+' || x == '-' || x == 'x' || x == '/') {
    return true;
  }
  return false;
 }

 void result () {
  String finalQuestion = userQuestion;
  finalQuestion = finalQuestion.replaceAll('x', '*');
  Parser p = Parser();
  Expression exp = p.parse(finalQuestion);
  ContextModel cm = ContextModel();
  double eval = exp.evaluate(EvaluationType.REAL, cm);
  userAnswer = eval.toString();
 }

  var userQuestion = ' ';
  var userAnswer = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(padding: EdgeInsets.only(right: 16)),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Icon(Icons.more_vert_rounded, color: Color.fromARGB(255, 255, 47, 134),),
          )
        ],
        title: Text(
          "Calculator",
          style: TextStyle(
            color: Color.fromARGB(255, 29, 4, 44),
            fontSize: 24,
            fontWeight: FontWeight.w500
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          userQuestion,
                          style: TextStyle(
                            fontSize: 32,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '=',
                          style: TextStyle(
                            fontSize: 24,
                            color: Color.fromARGB(255, 255, 47, 134),
                          ),
                        ),
                        SizedBox(width: 16,),
                        Text(
                          userAnswer,
                          style: TextStyle(
                            fontSize: 24,
                            color: Color.fromARGB(255, 255, 47, 134),
                          ),
                        ),

                      ],
                    ),
                  ],
                ),
              ),
            )
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: GridView.builder(
                itemCount: buttons.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ), 
                itemBuilder: (BuildContext context, int index) {
                  // clear button
                  if (index == 0) {
                    return Buttons(
                      buttonTapped: () {
                        setState(() {
                          userQuestion = '';
                          userAnswer = '';
                        });
                      },
                      color: Color.fromARGB(31, 180, 174, 178), 
                      textColor: Color.fromARGB(255, 29, 4, 44), 
                      buttonText: buttons[index],
                    );
                    
                  } 
                  // delete button
                  else if (index == 1) {
                    return Buttons(
                      buttonTapped: () {
                        setState(() {
                          userQuestion = userQuestion.substring(0,userQuestion.length-1);
                        });
                      },
                      color: Color.fromARGB(31, 180, 174, 178), 
                      textColor: Color.fromARGB(255, 29, 4, 44),
                      buttonText: buttons[index], 
                    );
                  } 
                  // equal to button
                  else if (index == buttons.length-1) {
                    return Buttons(
                      buttonTapped: () {
                        setState(() {
                          result();
                        });
                      },
                      color: Color.fromARGB(255, 29, 4, 44),
                      textColor: Color(0xffff83b7),
                      buttonText: buttons[index], 
                    );
                  } 
                  // other buttons
                  return Buttons(
                    buttonTapped: () {
                      setState(() {
                        userQuestion += buttons[index];
                      });
                    },
                  color: Color.fromARGB(31, 180, 174, 178), 
                  textColor: isOperator(buttons[index])? 
                  Color.fromARGB(255, 255, 47, 134) 
                  : 
                  Color.fromARGB(255, 29, 4, 44),
                  buttonText: buttons[index],
                  );
                }
              )
            )
          ),
        ],
      ),
    );
  }
}
