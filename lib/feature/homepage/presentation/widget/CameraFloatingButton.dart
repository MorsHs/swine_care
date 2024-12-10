import 'package:flutter/material.dart';

class CameraFloatingButton extends StatelessWidget {
  const CameraFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {},
      tooltip: 'Pick Image',
      child: const Icon(Icons.add_a_photo),
    );
  }
}
