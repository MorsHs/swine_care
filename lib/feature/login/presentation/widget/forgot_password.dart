import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  late bool long_pressed;

  @override
  void initState() {
    long_pressed = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 40,bottom: 30,top: 10),
        child: GestureDetector(
          onTap: () {
            setState(() {
              long_pressed = true;
              Future.delayed(
                const Duration(seconds: 3),
                () {
                  setState(() {
                    long_pressed = false;
                  });
                },
              );
            });
          },
          onLongPressDown: (details) {
            setState(() {
              long_pressed = true;
            });
          },
          onLongPressUp: () {
            setState(() {
              long_pressed = false;
            });
          },
          onLongPressCancel: () {
            setState(() {
              long_pressed = false;
            });
          },
          child: Text(
            "Forgot Password?",
            style: TextStyle(
                color: long_pressed ? Colors.blue : Colors.black,
                decoration:
                    long_pressed ? TextDecoration.underline : TextDecoration.none,
                decorationColor: long_pressed ? Colors.blue : Colors.black),
          ),
        ),
      ),
    );
  }
}
