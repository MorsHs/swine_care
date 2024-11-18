import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class LoginOrCreateLabel extends StatelessWidget {
  final String label;
  const LoginOrCreateLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25,right: 40),
      child: Text(label,
      style: textStyle(),),
    );
  }

  TextStyle textStyle(){
    return  GoogleFonts.montserrat(
      fontSize: 30
    );
  }
}
