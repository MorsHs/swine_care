import 'package:flutter/material.dart';
import 'package:swine_care/feature/historypage/presentation/widgets/DiagnosisRecord.dart';
import 'package:swine_care/feature/historypage/presentation/widgets/HistoryCard.dart';

class HistoryListView extends StatelessWidget {
  final List<DiagnosisRecord> records;
  final bool isDarkMode;
  final Function(String) onDelete;

  const HistoryListView({
    super.key,
    required this.records,
    required this.isDarkMode,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) => HistoryCard(
          record: records[index],
          isDarkMode: isDarkMode,
          onDelete: onDelete,
        ),
        childCount: records.length,
      ),
    );
  }
}