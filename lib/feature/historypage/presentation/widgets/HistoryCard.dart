import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:swine_care/colors/ArgieColors.dart';
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

class _HistoryCardState extends State<HistoryCard> with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: widget.isDarkMode ? Colors.grey.shade800 : Colors.white,
        boxShadow: [
          BoxShadow(
            color: widget.isDarkMode ? Colors.black26 : Colors.grey.shade200,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(
          children: [
            _buildSummary(context),
            if (_isExpanded)
              FadeTransition(
                opacity: _fadeAnimation,
                child: _buildDetails(context),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummary(BuildContext context) {
    final Color diagnosisColor;
    switch (widget.record.diagnosis.toLowerCase()) {
      case 'highly risk':
        diagnosisColor = Colors.red.shade400.withValues(alpha: 0.8);
        break;
      case 'medium risk':
        diagnosisColor = Colors.orange.shade400.withValues(alpha: 0.8);
        break;
      default: // Low Risk
        diagnosisColor = Colors.green.shade400.withValues(alpha: 0.8);
    }

    final Color textColor = widget.isDarkMode ? ArgieColors.textthird : ArgieColors.textBold;

    return InkWell(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
          if (_isExpanded) {
            _animationController.forward();
          } else {
            _animationController.reverse();
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    children: [
                      Icon(Iconsax.health, color: textColor, size: 22),
                      const SizedBox(width: 8),
                      Text(
                        'Pig ID: ${widget.record.pigId}',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: textColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Icon(
                  _isExpanded ? Iconsax.arrow_up_2 : Iconsax.arrow_down_2,
                  color: textColor,
                  size: 22,
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
                        'Diagnosis',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: textColor.withValues(alpha: 0.7),
                        ),
                      ),
                      Text(
                        widget.record.diagnosis,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: diagnosisColor,
                        ),
                        overflow: TextOverflow.ellipsis,
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
                        'Score',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: textColor.withValues(alpha: 0.7),
                        ),
                      ),
                      Text(
                        '${widget.record.finalScore.toStringAsFixed(1)}%',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.record.date,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: textColor.withValues(alpha: 0.7),
                  ),
                ),
                IconButton(
                  icon: Icon(Iconsax.trash, color: Colors.red.shade500, size: 22),
                  onPressed: () => widget.onDelete(widget.record.id),
                  tooltip: 'Delete Record',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetails(BuildContext context) {
    final Color textColor = widget.isDarkMode ? Colors.white70 : Colors.black87;
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Symptoms', Iconsax.clipboard_text, textColor),
          ...widget.record.symptoms.entries.map(
                (entry) => _buildDetailItem(entry.key, entry.value ? 'Yes' : 'No', textColor),
          ),
          const SizedBox(height: 16),
          _buildSectionHeader('Image Analysis', Iconsax.camera, textColor),
          _buildPredictionItem('Ears', widget.record.earsPredictions, textColor),
          _buildPredictionItem('Skin', widget.record.skinPredictions, textColor),
          const SizedBox(height: 16),
          _buildSectionHeader('Recommendations', Iconsax.health, textColor),
          ...widget.record.recommendations.map(
                (rec) => _buildDetailItem(rec, null, textColor),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon, Color textColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: textColor.withValues(alpha: 0.8)),
          const SizedBox(width: 8),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String title, String? value, Color textColor) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, top: 4.0, bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              '• $title',
              style: GoogleFonts.poppins(fontSize: 14, color: textColor),
            ),
          ),
          if (value != null)
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPredictionItem(String partName, List<Prediction> predictions, Color textColor) {
    if (predictions.isEmpty) {
      return _buildDetailItem('$partName: No predictions available', null, textColor);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12.0, top: 8.0),
          child: Text(
            '$partName Predictions:',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ),
        ...predictions.map(
              (p) => _buildDetailItem(
            p.prediction,
            '${(p.confidence_score * 100).toStringAsFixed(1)}%',
            textColor,
          ),
        ),
      ],
    );
  }
}