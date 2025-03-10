import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:swine_care/colors/ArgieColors.dart'; // Import your color class
import 'package:swine_care/colors/ArgieSizes.dart'; // Import your sizes class

// Mock Diagnosis Record class
class DiagnosisRecord {
  final String id;
  final String pigId;
  final String date;
  final String diagnosis; // e.g., "Highly Likely", "Medium Likelihood", "Low Risk"
  final String status; // e.g., "Resolved", "Under Observation"

  DiagnosisRecord({
    required this.id,
    required this.pigId,
    required this.date,
    required this.diagnosis,
    required this.status,
  });
}

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  bool _isGridView = false;
  String _searchQuery = '';

  // Mock data for history records
  final List<DiagnosisRecord> records = [
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

  // Filtered records based on search query
  List<DiagnosisRecord> get filteredRecords {
    if (_searchQuery.isEmpty) return records;
    return records.where((record) {
      return record.pigId.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          record.diagnosis.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          record.status.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? ArgieColors.dark : Colors.grey.shade50,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(ArgieSizes.paddingDefault),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Manual back button and title
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Diagnosis History",
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: ArgieColors.textthird,
                            shadows: [Shadow(color: ArgieColors.shadow, blurRadius: 2)],
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            _isGridView ? Iconsax.element_3 : Iconsax.element_4,
                            color: isDarkMode ? Colors.white70 : Colors.black87,
                          ),
                          onPressed: () {
                            setState(() {
                              _isGridView = !_isGridView;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: ArgieSizes.spaceBtwItems),
                    // Search bar
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Search history...',
                        hintStyle: GoogleFonts.poppins(
                          color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                        ),
                        prefixIcon: Icon(
                          Iconsax.search_normal,
                          color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                        ),
                        filled: true,
                        fillColor: isDarkMode ? Colors.grey.shade800 : Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: ArgieColors.primary,
                          ),
                        ),
                      ),
                      style: GoogleFonts.poppins(
                        color: isDarkMode ? Colors.white70 : Colors.black87,
                      ),
                    ),
                    SizedBox(height: ArgieSizes.spaceBtwSections),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              sliver: filteredRecords.isEmpty
                  ? SliverToBoxAdapter(child: _buildEmptyState(isDarkMode))
                  : _isGridView
                  ? _buildGridView(filteredRecords, isDarkMode)
                  : _buildListView(filteredRecords, isDarkMode),
            ),
          ],
        ),
      ),
    );
  }

  // Empty State Widget
  Widget _buildEmptyState(bool isDarkMode) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Iconsax.archive_book,
            size: 100,
            color: isDarkMode ? Colors.grey.shade600 : Colors.grey.shade300,
          ),
          const SizedBox(height: 20),
          Text(
            'No History Yet',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white70 : Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            _searchQuery.isEmpty
                ? 'Your diagnosis history will appear here.\nStart analyzing pigs on the Home page!'
                : 'No results found for "$_searchQuery".',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // List View Widget
  Widget _buildListView(List<DiagnosisRecord> records, bool isDarkMode) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: _buildHistoryCard(records[index], isGrid: false, isDarkMode: isDarkMode),
          );
        },
        childCount: records.length,
      ),
    );
  }

  // Grid View Widget
  Widget _buildGridView(List<DiagnosisRecord> records, bool isDarkMode) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          return _buildHistoryCard(records[index], isGrid: true, isDarkMode: isDarkMode);
        },
        childCount: records.length,
      ),
    );
  }

  // History Card Widget (used for both list and grid)
  Widget _buildHistoryCard(DiagnosisRecord record, {required bool isGrid, required bool isDarkMode}) {
    // Determine colors based on diagnosis (same as ResultsPage)
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

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: isDarkMode ? Colors.grey.shade800 : Colors.white,
        child: InkWell(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Tapped record: ${record.id}')),
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: isGrid ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
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
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                    maxLines: isGrid ? 2 : 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Date: ${record.date}',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                  ),
                ),
                if (isGrid) const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: record.status == 'Resolved'
                        ? Colors.green.shade100
                        : record.status == 'Under Observation'
                        ? Colors.orange.shade100
                        : Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(12),
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
        ),
      ),
    );
  }
}