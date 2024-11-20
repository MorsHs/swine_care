import 'package:flutter/material.dart';

class Textfieldcontainer extends StatefulWidget {
  final bool isHidden;
  final String label;
  const Textfieldcontainer(
      {super.key, required this.isHidden, required this.label});

  @override
  State<Textfieldcontainer> createState() => _TextfieldcontainerState();
}

class _TextfieldcontainerState extends State<Textfieldcontainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8,bottom: 8,right: 20,left: 20),
      child: TextField(
        decoration: decoration(),
        obscureText: widget.isHidden,
      ),
    );
  }

  InputDecoration decoration() {
    return InputDecoration(
        label: Text(widget.label),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ));
  }
}
