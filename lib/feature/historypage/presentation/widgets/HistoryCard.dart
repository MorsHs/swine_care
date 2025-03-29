import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:swine_care/feature/historypage/presentation/widgets/DiagnosisRecord.dart';

class HistoryCard extends StatelessWidget {
  final DiagnosisRecord record;
  final bool isDarkMode;
  final Function(String) onDelete;

  const HistoryCard({
    super.key,
    required this.record,
    required this.isDarkMode,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    // Determine colors based on diagnosis
    final Color diagnosisBgColor;
    final Color diagnosisBorderColor;
    final Color diagnosisTextColor;

    switch (record.diagnosis) {
      case 'Highly Likely':
        diagnosisBgColor = Colors.red.shade100;
        diagnosisBorderColor = Colors.red.shade300;
        diagnosisTextColor = Colors.red.shade700;
        break;
      case 'Medium Likelihood':
        diagnosisBgColor = Colors.orange.shade100;
        diagnosisBorderColor = Colors.orange.shade300;
        diagnosisTextColor = Colors.orange.shade700;
        break;
      default: // Low Risk
        diagnosisBgColor = Colors.green.shade100;
        diagnosisBorderColor = Colors.green.shade300;
        diagnosisTextColor = Colors.green.shade700;
    }

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade200,
          width: 1,
        ),
      ),
      color: isDarkMode ? Colors.grey.shade800 : Colors.white,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: record.status == 'Resolved'
                            ? Colors.green.shade600
                            : record.status == 'Under Observation'
                            ? Colors.orange.shade600
                            : Colors.blue.shade600,
                        border: Border.all(
                          color: isDarkMode ? Colors.grey.shade700 : Colors.white,
                          width: 2,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Pig ID: ${record.pigId}',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: isDarkMode ? Colors.white70 : Colors.black87,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: diagnosisBgColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: diagnosisBorderColor),
                  ),
                  child: Text(
                    record.diagnosis,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: diagnosisTextColor,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Iconsax.calendar,
                      size: 16,
                      color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        record.date,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: record.status == 'Resolved'
                        ? Colors.green.shade50
                        : record.status == 'Under Observation'
                        ? Colors.orange.shade50
                        : Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: record.status == 'Resolved'
                          ? Colors.green.shade200
                          : record.status == 'Under Observation'
                          ? Colors.orange.shade200
                          : Colors.blue.shade200,
                    ),
                  ),
                  child: Text(
                    record.status,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: record.status == 'Resolved'
                          ? Colors.green.shade800
                          : record.status == 'Under Observation'
                          ? Colors.orange.shade800
                          : Colors.blue.shade800,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              icon: Icon(
                Iconsax.trash,
                color: Colors.red.shade600,
                size: 20,
              ),
              onPressed: () {
                onDelete(record.id);
              },
              tooltip: 'Delete Record',
            ),
          ),
        ],
      ),
    );
  }
}