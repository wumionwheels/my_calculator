// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  final color;
  final textColor;
  final String buttonText;
  final buttonTapped;

  Buttons({
    super.key,
    required this.color,
    required this.textColor,
    required this.buttonText,
    required this.buttonTapped,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      child: Padding(
          padding: const EdgeInsets.only(top: 4, left: 4),
          child: ClipRRect(
        borderRadius: BorderRadius.zero,
        child: Container(
            color: color,
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(
                  color: textColor,
                  fontSize: 24,
                ),
              ),
            ),
          ),
        ),
      ),
    );

  }
}