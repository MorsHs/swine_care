import 'package:flutter/material.dart';

class Textfieldcontainer extends StatefulWidget {
  final bool isHidden;
  final String label;
  const Textfieldcontainer({super.key, required this.isHidden, required this.label});

  @override
  State<Textfieldcontainer> createState() => _TextfieldcontainerState();
}

class _TextfieldcontainerState extends State<Textfieldcontainer> {
  
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: TextField(
          decoration: decoration(),
        )
    );
  }

  //TODO mag decorate sa textbox
  InputDecoration decoration(){
    return InputDecoration(
      label: Text(widget.label),
      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 20,strokeAlign: 20 ))
    );
  }
}
