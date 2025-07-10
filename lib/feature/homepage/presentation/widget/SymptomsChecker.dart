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
        ...[
          "High fever?",
          "Slight fever?",
          ...answers.keys.where((q) =>
          q != "High fever?" &&
              q != "Slight fever?")
        ].map((question) {
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
      case "High fever?":
        return Icons.thermostat;
      case "Milder fever?":
        return Icons.thermostat;
      case "Slight fever?":
        return Icons.thermostat;
      case "Extreme tiredness?":
        return Icons.directions_walk;
      case "Loss of appetite?":
        return Icons.restaurant_menu;
      case "Difficulty of breathing?":
        return Icons.air;
      case "Difficulty on walking?":
        return Icons.square_foot;
      case "Bloody feces?":
        return Icons.ac_unit;
      default:
        return Icons.help_outline;
    }
  }

  String _getTooltipForQuestion(String question) {
    switch (question) {
      case "High fever?":
        return "The pig has a high fever, with a body temperature ranging from 40°C to 42°C, which may indicate a severe infection or systemic illness.";

      case "Milder fever?":
        return "The pig is experiencing a fluctuating mild fever, where the temperature rises and falls, potentially signaling an early or infection.";

      case "Slight fever?":
        return "The pig has a slight fever, with body temperatures ranging between 37.5°C and 39°C, which could be a sign of a mild infection or stress response.";

      case "Extreme tiredness?":
        return "The pig shows signs of extreme fatigue, which could be associated with systemic weakness.";

      case "Loss of appetite?":
        return "The pig is refusing to eat, a common symptom that may indicate pain, illness, or digestive discomfort.";

      case "Difficulty of breathing?":
        return "The pig is having trouble breathing, which may suggest respiratory tract infections, lung issues, or high fever.";

      case "Difficulty on walking?":
        return "The pig has difficulty walking, which may result from joint pain, muscle weakness, neurological problems, or respiratory distress.";

      case "Bloody feces?":
        return "The presence of blood in the pig's feces is a serious symptom that may point to internal bleeding, intestinal infections, or parasitic infestations.";

      default:
        return "This symptom may indicate a potential health issue.";
    }
  }

  Color _getContrastingColor(Color backgroundColor) {
    final double luminance = backgroundColor.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}