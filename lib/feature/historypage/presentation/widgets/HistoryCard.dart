import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:swine_care/data/model/Prediction.dart';
import 'package:swine_care/feature/historypage/presentation/widgets/DiagnosisRecord.dart';

class HistoryCard extends StatefulWidget {
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
  State<HistoryCard> createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final Color cardColor;
    final Color textColor;

    switch (widget.record.diagnosis) {
      case 'Highly Risk':
        cardColor = widget.isDarkMode ? Colors.red.shade900.withValues(alpha: 0.5) : Colors.red.shade100;
        textColor = widget.isDarkMode ? Colors.red.shade100 : Colors.red.shade800;
        break;
      case 'Medium Risk':
        cardColor = widget.isDarkMode ? Colors.orange.shade900.withValues(alpha: 0.5) : Colors.orange.shade100;
        textColor = widget.isDarkMode ? Colors.orange.shade100 : Colors.orange.shade800;
        break;
      default: // Low Risk
        cardColor = widget.isDarkMode ? Colors.green.shade900.withValues(alpha: 0.5) : Colors.green.shade100;
        textColor = widget.isDarkMode ? Colors.green.shade100 : Colors.green.shade800;
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: cardColor, width: 1),
      ),
      color: widget.isDarkMode ? Colors.grey.shade800 : Colors.white,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: [
            _buildSummary(context, cardColor, textColor),
            if (_isExpanded)
              _buildDetails(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSummary(BuildContext context, Color cardColor, Color textColor) {
    return InkWell(
      onTap: () => setState(() => _isExpanded = !_isExpanded),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        color: cardColor.withValues(alpha: 0.3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Icon(Iconsax.health, color: textColor, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        'Pig ID: ${widget.record.pigId}',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  _isExpanded ? Iconsax.arrow_up_2 : Iconsax.arrow_down_2,
                  color: textColor,
                  size: 20,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Diagnostic Result',
                        style: GoogleFonts.poppins(fontSize: 12, color: textColor.withValues(alpha: 0.8)),
                      ),
                      Text(
                        widget.record.diagnosis,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Confidence Score',
                        style: GoogleFonts.poppins(fontSize: 12, color: textColor.withValues(alpha: 0.8)),
                      ),
                      Text(
                        '${widget.record.finalScore.toStringAsFixed(1)}%',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.record.date,
                  style: GoogleFonts.poppins(fontSize: 12, color: textColor.withValues(alpha: 0.8)),
                ),
                IconButton(
                  icon: Icon(Iconsax.trash, color: Colors.red.shade400, size: 20),
                  onPressed: () => widget.onDelete(widget.record.id),
                  tooltip: 'Delete Record',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDetails(BuildContext context) {
    Color detailsTextColor = widget.isDarkMode ? Colors.white70 : Colors.black87;
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Symptoms Checklist', Iconsax.clipboard_text, detailsTextColor),
          ...widget.record.symptoms.entries.map((entry) => _buildDetailItem(entry.key, entry.value ? 'Yes' : 'No', detailsTextColor)),
          const SizedBox(height: 16),
          _buildSectionHeader('Image Analysis', Iconsax.camera, detailsTextColor),
          _buildPredictionItem('Ears', widget.record.earsPredictions, detailsTextColor),
          _buildPredictionItem('Skin', widget.record.skinPredictions, detailsTextColor),
          const SizedBox(height: 16),
          _buildSectionHeader('Recommendations', Iconsax.health, detailsTextColor),
          ...widget.record.recommendations.map((rec) => _buildDetailItem(rec, null, detailsTextColor)),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon, Color textColor) {
    return Row(
      children: [
        Icon(icon, size: 18, color: textColor),
        const SizedBox(width: 8),
        Text(title, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: textColor)),
      ],
    );
  }

  Widget _buildDetailItem(String title, String? value, Color textColor) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 4.0, bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Text('• $title', style: GoogleFonts.poppins(fontSize: 14, color: textColor))),
          if (value != null)
            Text(value, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: textColor)),
        ],
      ),
    );
  }

  Widget _buildPredictionItem(String partName, List<Prediction> predictions, Color textColor) {
    if (predictions.isEmpty) {
      return _buildDetailItem('$partName: No predictions found.', null, textColor);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 8.0),
          child: Text(
            '$partName Predictions:',
            style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: textColor),
          ),
        ),
        ...predictions.map((p) => _buildDetailItem(
          p.prediction,
          '${(p.confidence_score * 100).toStringAsFixed(1)}%',
          textColor,
        )),
      ],
    );
  }
}