import 'package:flutter/material.dart';

class DescriptionText extends StatelessWidget {
  final String text;

  const DescriptionText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text.rich(
        TextSpan(
          style: const TextStyle(fontSize: 16, color: Colors.black54),
          children: [
            ...text.split('\n').map((line) {
              if (line.startsWith('•') || line.startsWith('Warning')) {
                return TextSpan(
                  text: '$line\n',
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent),
                );
              } else if (line.startsWith('Example')) {
                return TextSpan(
                  text: '$line\n',
                  style: const TextStyle(fontStyle: FontStyle.italic, color: Colors.green),
                );
              } else {
                return TextSpan(text: '$line\n');
              }
            }).toList(),
          ],
        ),
      ),
    );
  }
}