import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swine_care/colors/ArgieColors.dart';
import 'package:swine_care/data/repositories/HistoryRepository.dart';
import 'package:swine_care/feature/historypage/presentation/widgets/DeleteRecordDialog.dart';
import 'package:swine_care/data/model/DiagnosisRecord.dart';
import 'package:swine_care/feature/historypage/presentation/widgets/HistoryEmptyState.dart';
import 'package:swine_care/feature/historypage/presentation/widgets/HistoryListView.dart';
import 'package:swine_care/feature/historypage/presentation/widgets/HistoryTextLabel1.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final HistoryRepository _historyRepository = HistoryRepository();

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? ArgieColors.dark : Colors.white,
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(milliseconds: 500));
        },
        color: ArgieColors.primary,
        backgroundColor: isDarkMode ? Colors.grey.shade800 : Colors.white,
        child: CustomScrollView(
          slivers: [
            HistoryTextLabel1(isDarkMode: isDarkMode),
            StreamBuilder<List<DiagnosisRecord>>(
              stream: _historyRepository.getRecordsStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator(color: ArgieColors.primary)),
                  );
                }

                if (snapshot.hasError) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: isDarkMode ? Colors.white70 : Colors.black87,
                        ),
                      ),
                    ),
                  );
                }

                final records = snapshot.data;

                if (records == null || records.isEmpty) {
                  return SliverToBoxAdapter(child: HistoryEmptyState(isDarkMode: isDarkMode));
                }

                return SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  sliver: HistoryListView(
                    records: records,
                    isDarkMode: isDarkMode,
                    onDelete: _deleteRecord,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _deleteRecord(String id) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => DeleteRecordDialog(
        onConfirm: () => _historyRepository.deleteRecord(id),
      ),
    );

    if (result == true && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Record deleted successfully'),
          backgroundColor: Colors.red.shade400,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          margin: const EdgeInsets.all(16),
        ),
      );
    }
  }
}