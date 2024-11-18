import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool long_pressed = false;
  @override
  Widget build(BuildContext context) {
    //TODO fix the longpress
    return GestureDetector(
      onTap: () => print("Hello"),
     onLongPressDown: (details) => long_pressed = true,
      onLongPressCancel: () => long_pressed = false,
      child: Text("Forgot Password?",style: textStyle(),),);
  }

  TextStyle textStyle(){
     if(long_pressed == false){
      return TextStyle(color: Colors.black);
    }
     else return TextStyle(color: Colors.green);
  }
}
