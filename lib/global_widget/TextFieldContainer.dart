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
    return Container(
      width: 350,
      height: 75,
      padding: const EdgeInsets.only(bottom: 25, left: 10, right: 10),
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
