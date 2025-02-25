import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class LoginOrCreateLabel extends StatelessWidget {
  final String label;
  const LoginOrCreateLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Align(alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 25,left: 30),
        child: Text(label,
        style: textStyle(),),
      ),
    );
  }

  TextStyle textStyle(){
    return  GoogleFonts.poppins(
      fontSize: 25
    );
  }
}
