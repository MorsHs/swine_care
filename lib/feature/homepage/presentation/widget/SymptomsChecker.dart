import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SymptomsChecker extends StatelessWidget {
  final Map<String, bool?> answers;
  final Function(String, bool) onAnswerChanged;

  const SymptomsChecker({
    super.key,
    required this.answers,
    required this.onAnswerChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: RichText(
            text: TextSpan(
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.black87,
              ),
              children: [
                TextSpan(
                  text: "Check for Symptoms: ",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                TextSpan(
                  text:
                  "These symptoms may indicate African Swine Fever (ASF). Early detection is crucial to prevent the spread of the disease and protect your herd.",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ),
        ...answers.keys.map((question) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        _getIconForQuestion(question),
                        color: Colors.blueGrey,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          question,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.info_outline, color: Colors.blueGrey, size: 18),
                        onPressed: () {
                          _showDescriptionDialog(context, _getTooltipForQuestion(question));
                        },
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => onAnswerChanged(question, true),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: answers[question] == true ? Colors.green : Colors.grey[300],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "Yes",
                          style: TextStyle(
                            color: answers[question] == true ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () => onAnswerChanged(question, false),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: answers[question] == false ? Colors.red : Colors.grey[300],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "No",
                          style: TextStyle(
                            color: answers[question] == false ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  void _showDescriptionDialog(BuildContext context, String description) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "More Information",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        content: Text(
          description,
          style: GoogleFonts.poppins(fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Close",
              style: GoogleFonts.poppins(color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconForQuestion(String question) {
    switch (question) {
      case "High temperature?":
        return Icons.thermostat;
      case "Clumsy movement?":
        return Icons.directions_walk;
      case "Loss of appetite?":
        return Icons.restaurant_menu;
      case "Rapid breathing?":
        return Icons.ramp_left;
      case "Unusual vocalization?":
        return Icons.record_voice_over;
      default:
        return Icons.help_outline;
    }
  }

  String _getTooltipForQuestion(String question) {
    switch (question) {
      case "High temperature?":
        return "A pig with a high temperature may feel warm to the touch and appear lethargic.";
      case "Clumsy movement?":
        return "Clumsy movement could indicate weakness or neurological issues.";
      case "Loss of appetite?":
        return "A pig refusing to eat may be a sign of illness or discomfort.";
      case "Rapid breathing?":
        return "Rapid breathing may indicate respiratory distress or fever.";
      case "Unusual vocalization?":
        return "Unusual sounds such as grunting or squealing may signal pain or distress.";
      default:
        return "This symptom may indicate a potential health issue.";
    }
  }
}