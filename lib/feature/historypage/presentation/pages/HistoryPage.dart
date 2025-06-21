import 'package:flutter/material.dart';
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

  // Method to delete a record
  void _deleteRecord(String id) {
    showDialog(
      context: context,
      builder: (context) => DeleteRecordDialog(
        onConfirm: () async {
          // Delete from repository
          await _historyRepository.deleteRecord(id);
          // Reload records to update UI
          _loadRecords();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? ArgieColors.dark : Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // History Header text
            HistoryTextLabel1(isDarkMode: isDarkMode),

            // Records Section
            FutureBuilder<List<DiagnosisRecord>>(
              future: _recordsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (snapshot.hasError) {
                  return SliverToBoxAdapter(
                    child: Center(child: Text('Error: ${snapshot.error}')),
                  );
                }

                final records = snapshot.data;

                if (records == null || records.isEmpty) {
                  return SliverToBoxAdapter(child: _buildEmptyState(isDarkMode));
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

  // Empty State
  Widget _buildEmptyState(bool isDarkMode) {
    return const HistoryEmptyState();
  }
}