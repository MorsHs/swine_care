import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SwineCare - History'),
        backgroundColor: Colors.green.shade700,
      ),
      body: const Center(
        child: Text(
          'History Page\nView past diagnoses and health records.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}