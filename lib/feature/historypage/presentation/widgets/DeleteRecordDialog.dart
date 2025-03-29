import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:swine_care/colors/ArgieColors.dart';
import 'package:swine_care/feature/historypage/presentation/widgets/DiagnosisRecord.dart';

class DeleteRecordDialog extends StatelessWidget {
  final String recordId;
  final List<DiagnosisRecord> records;
  final VoidCallback onRecordDeleted;

  const DeleteRecordDialog({
    super.key,
    required this.recordId,
    required this.records,
    required this.onRecordDeleted,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Row(
        children: [
          Icon(
            Iconsax.warning_2,
            color: Colors.red.shade600,
            size: 24,
          ),
          const SizedBox(width: 8),
          Text(
            'Delete Record',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
          ),
        ],
      ),
      content: Text(
        'Are you sure you want to delete this diagnosis record? This action cannot be undone.',
        style: GoogleFonts.poppins(
          fontSize: 14,
          color: Theme.of(context).textTheme.bodyMedium!.color,
        ),
      ),
      backgroundColor: Theme.of(context).cardTheme.color ?? ArgieColors.ligth,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close dialog
          },
          child: Text(
            'Cancel',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: ArgieColors.primary,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            records.removeWhere((record) => record.id == recordId);
            Navigator.of(context).pop(); // Close dialog
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Record deleted successfully',
                  style: GoogleFonts.poppins(),
                ),
                backgroundColor: Colors.red.shade600,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                margin: const EdgeInsets.all(16),
              ),
            );
            onRecordDeleted(); // Notify the parent to update state
          },
          child: Text(
            'Delete',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.red.shade600,
            ),
          ),
        ),
      ],
    );
  }
}