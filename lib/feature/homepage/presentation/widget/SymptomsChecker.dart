import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SymptomsChecker extends StatefulWidget {
  const SymptomsChecker({super.key});

  @override
  _SymptomsCheckerState createState() => _SymptomsCheckerState();
}

class _SymptomsCheckerState extends State<SymptomsChecker> {
  final Map<String, bool?> _answers = {
    "High temperature?": null,
    "Clumsy movement?": null,
    "Loss of appetite?": null,
    "Rapid breathing?": null,
    "Unusual vocalization?": null,
  };

  void _setAnswer(String question, bool answer) {
    setState(() {
      _answers[question] = answer;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _answers.keys.map((question) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  question,
                  style: GoogleFonts.concertOne(
                    fontSize: 16,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
              Row(
                children: [

                  // Yes Button
                  GestureDetector(
                    onTap: () => _setAnswer(question, true),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6
                      ),
                      decoration: BoxDecoration(
                        color: _answers[question] == true
                            ? Colors.green
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "Yes",
                        style: TextStyle(
                          color: _answers[question] == true
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),

                  // No Button
                  GestureDetector(
                    onTap: () => _setAnswer(question, false),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6
                      ),
                      decoration: BoxDecoration(
                        color: _answers[question] == false
                            ? Colors.red
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "No",
                        style: TextStyle(
                          color: _answers[question] == false
                              ? Colors.white
                              : Colors.black,
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
    );
  }
}
