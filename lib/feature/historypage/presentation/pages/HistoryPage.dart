import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swine_care/colors/ArgieColors.dart';
import 'package:swine_care/data/repositories/HistoryRepository.dart';
import 'package:swine_care/feature/historypage/presentation/widgets/DeleteRecordDialog.dart';
import 'package:swine_care/feature/historypage/presentation/widgets/DiagnosisRecord.dart';
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
  late Future<List<DiagnosisRecord>> _recordsFuture;

  @override
  void initState() {
    super.initState();
    _loadRecords();
  }

  void _loadRecords() {
    setState(() {
      _recordsFuture = _historyRepository.getAllRecords();
    });
  }

  Future<void> _refreshRecords() async {
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay
    _loadRecords();
  }

  void _deleteRecord(String id) {
    showDialog(
      context: context,
      builder: (context) => DeleteRecordDialog(
        onConfirm: () async {
          await _historyRepository.deleteRecord(id);
          _loadRecords();
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Record deleted successfully'),
                backgroundColor: Colors.red.shade600,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                margin: const EdgeInsets.all(16),
              ),
            );
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? ArgieColors.dark : Colors.white,
      body: RefreshIndicator(
        onRefresh: _refreshRecords,
        color: ArgieColors.primary,
        backgroundColor: isDarkMode ? Colors.grey.shade800 : Colors.white,
        child: CustomScrollView(
          slivers: [
            HistoryTextLabel1(isDarkMode: isDarkMode),
            FutureBuilder<List<DiagnosisRecord>>(
              future: _recordsFuture,
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
}