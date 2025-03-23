import 'package:flutter/material.dart';

class AnswerAllQuestionsTextLabel extends StatelessWidget {
  const AnswerAllQuestionsTextLabel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.amber.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.amber.withValues(alpha: 0.2)),
      ),
      child: Text(
        "Answer all questions below to improve diagnosis accuracy.",
        style: TextStyle(
          fontSize: 14,
          color: Colors.amber.shade800,
        ),
      ),
    );
  }
}
