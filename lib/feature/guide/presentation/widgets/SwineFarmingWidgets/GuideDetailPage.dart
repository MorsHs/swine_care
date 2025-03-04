import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GuideDetailPage extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;

  const GuideDetailPage({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green.shade300,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: imagePath,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      imagePath,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Title
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),

              // Description
              _buildDescription(context, description),
            ],
          ),
        ),
      ),
    );
  }

  // Helper Method to Format Description
  Widget _buildDescription(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text.rich(
        TextSpan(
          style: GoogleFonts.poppins(fontSize: 16, color: Colors.black87),
          children: [
            ...text.split('\n').map((line) {
              if (line.startsWith('•') || line.startsWith('Warning')) {
                return TextSpan(
                  text: '$line\n',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  ),
                );
              } else if (line.startsWith('Example')) {
                return TextSpan(
                  text: '$line\n',
                  style: GoogleFonts.poppins(
                    fontStyle: FontStyle.italic,
                    color: Colors.green,
                  ),
                );
              } else {
                return TextSpan(text: '$line\n');
              }
            }).toList(),
          ],
        ),
      ),
    );
  }
}