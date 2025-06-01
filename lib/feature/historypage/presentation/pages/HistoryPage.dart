import 'package:flutter/material.dart';
import 'package:swine_care/colors/ArgieColors.dart';
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
  // Initialize records directly (not using late)
  List<DiagnosisRecord> records = [
    DiagnosisRecord(
      id: '1',
      pigId: 'PIG-001',
      date: '2025-03-01',
      diagnosis: 'Highly Likely',
      status: 'Under Observation',
    ),
    DiagnosisRecord(
      id: '2',
      pigId: 'PIG-002',
      date: '2025-03-02',
      diagnosis: 'Low Risk',
      status: 'Resolved',
    ),
    DiagnosisRecord(
      id: '3',
      pigId: 'PIG-003',
      date: '2025-03-03',
      diagnosis: 'Medium Likelihood',
      status: 'Under Observation',
    ),
    DiagnosisRecord(
      id: '4',
      pigId: 'PIG-004',
      date: '2025-03-04',
      diagnosis: 'Low Risk',
      status: 'Resolved',
    ),
  ];

  // Method to "delete" a record
  void _deleteRecord(String id) {
    showDialog(
      context: context,
      builder: (context) =>
          DeleteRecordDialog(
            recordId: id,
            records: records,
            onRecordDeleted: () {
              setState(() {

              });
            },
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme
        .of(context)
        .brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? ArgieColors.dark : Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [

            // History Header text
            HistoryTextLabel1(isDarkMode: isDarkMode),

            // Records Section
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16.0, vertical: 8.0
              ),
              sliver: records.isEmpty
                  ? SliverToBoxAdapter(child: _buildEmptyState(isDarkMode)
              )

              //history listview page
                  : HistoryListView(
                  records: records,
                  isDarkMode: isDarkMode,
                  onDelete: _deleteRecord
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Empty State sa history kung wla nay pending history kani ang ma display
  Widget _buildEmptyState(bool isDarkMode) {
    return const HistoryEmptyState();
  }
}