import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swine_care/colors/ArgieColors.dart';

class SymptomsChecker extends StatelessWidget {
  final Map<String, bool?> answers;
  final Function(String, bool) onChanged;

  const SymptomsChecker({
    super.key,
    required this.answers,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final BuildContext localContext = context;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: RichText(
            text: TextSpan(
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Theme.of(localContext).textTheme.bodyLarge!.color,
              ),
              children: [
                TextSpan(
                  text: "Check for Symptoms ",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
        ...answers.keys.map((question) {
          final bool? answer = answers[question];
          final Color yesBackgroundColor = answer == true
              ? Theme.of(localContext).colorScheme.primary
              : Theme.of(localContext).cardTheme.color ?? Colors.grey.shade200;
          final Color noBackgroundColor = answer == false
              ? Theme.of(localContext).colorScheme.error
              : Theme.of(localContext).cardTheme.color ?? Colors.grey.shade200;

          final Color yesTextColor = _getContrastingColor(yesBackgroundColor);
          final Color noTextColor = _getContrastingColor(noBackgroundColor);

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
                        color: Theme.of(localContext).colorScheme.secondary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          question,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color:
                            Theme.of(localContext).textTheme.bodyLarge!.color,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.info_outline,
                          color: Theme.of(localContext).colorScheme.secondary,
                          size: 18,
                        ),
                        onPressed: () {
                          _showDescriptionDialog(
                              localContext, _getTooltipForQuestion(question));
                        },
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => onChanged(question, true),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: yesBackgroundColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "Yes",
                          style: TextStyle(
                            color: yesTextColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () => onChanged(question, false),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: noBackgroundColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "No",
                          style: TextStyle(
                            color: noTextColor,
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
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.bodyLarge!.color,
          ),
        ),
        content: Text(
          description,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Theme.of(context).textTheme.bodyMedium!.color,
          ),
        ),
        backgroundColor: Theme.of(context).cardTheme.color,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Close",
              style: GoogleFonts.poppins(
                color: Theme.of(context).brightness == Brightness.dark
                    ? ArgieColors.textthird
                    : Theme.of(context).colorScheme.primary,
              ),
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
        return Icons.air;
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

  Color _getContrastingColor(Color backgroundColor) {
    final double luminance = backgroundColor.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}