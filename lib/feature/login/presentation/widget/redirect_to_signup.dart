import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swine_care/feature/loadingscreen/presentation/widget/PageIndicator.dart';

class RedirectToSignup extends StatefulWidget {
  const RedirectToSignup({super.key});

  @override
  State<RedirectToSignup> createState() => _RedirectToSignupState();
}

class _RedirectToSignupState extends State<RedirectToSignup> {
  late bool long_pressed;

  @override
  void initState() {
    long_pressed = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Don't have an account? "),
          gesture(Text(
            "Sign Up",
            style: textStyle(),
          ))
        ],
      ),
    );
  }

  Widget gesture(Widget child) {
    return GestureDetector(
      onTap: () {
        context.go('/signup');
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
