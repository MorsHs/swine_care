import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RedirectToLogin extends StatefulWidget {
  const RedirectToLogin({super.key});

  @override
  State<RedirectToLogin> createState() => _RedirectToSignupState();
}

class _RedirectToSignupState extends State<RedirectToLogin> {
  late bool long_pressed;

  @override
  void initState() {
    long_pressed = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10,bottom: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Already have an account? "),
          gesture(Text(
            "Sign in",
            style: textStyle(),
          ))
        ],
      ),
    );
  }

  Widget gesture(Widget child) {
    return GestureDetector(
      onTap: () {
        context.go('/login');
        setState(() {
          long_pressed = true;
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
      child: child,
    );
  }

  TextStyle textStyle() {
    return TextStyle(
        fontWeight: FontWeight.bold,
        color: long_pressed ? Colors.blue : Colors.blueAccent,
        decoration:
        long_pressed ? TextDecoration.underline : TextDecoration.none,
        decorationColor: long_pressed ? Colors.blue : Colors.black);
  }
}
