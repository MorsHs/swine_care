import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swine_care/colors/ArgieColors.dart';
import 'package:swine_care/colors/ArgieSizes.dart';

class SendFeedbackPage extends StatefulWidget {
  const SendFeedbackPage({super.key});

  @override
  State<SendFeedbackPage> createState() => _SendFeedbackPageState();
}

class _SendFeedbackPageState extends State<SendFeedbackPage> {
  final _formKey = GlobalKey<FormState>();
  final _commentController = TextEditingController();
  double _rating = 0.0;
  List<File> _images = [];
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _images.add(File(image.path));
      });
    }
  }

  void _submitFeedback() {
    if (_formKey.currentState!.validate()) {
      // Simulate feedback submission (replace with backend integration)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Thank you for your feedback!")),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? ArgieColors.dark : Colors.grey.shade50,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(ArgieSizes.paddingDefault),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with Back Button
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: isDarkMode ? Colors.white70 : Colors.black87,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 26),
                    Expanded(
                      child: Text(
                        "Send Feedback",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white70 : Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: ArgieSizes.spaceBtwSections),

                Expanded(
                  child: SingleChildScrollView(
                    child: Card(
                      color: isDarkMode ? Colors.grey.shade800 : Colors.white,
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Share Your Experience",
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: isDarkMode ? Colors.white70 : Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              "We value your feedback to improve SwineCare! Please rate your experience and provide any comments or suggestions. You can also attach images to illustrate your feedback (e.g., app screenshots or pig photos related to issues).",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "Rate Your Experience",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: isDarkMode ? Colors.white70 : Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Slider(
                              value: _rating,
                              min: 0,
                              max: 5,
                              divisions: 5,
                              label: _rating.toStringAsFixed(1),
                              activeColor: ArgieColors.primary,
                              inactiveColor: isDarkMode ? Colors.grey.shade600 : Colors.grey.shade300,
                              onChanged: (value) {
                                setState(() {
                                  _rating = value;
                                });
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(5, (index) {
                                return Icon(
                                  Icons.star,
                                  color: index < _rating ? ArgieColors.primary : (isDarkMode ? Colors.grey.shade600 : Colors.grey.shade400),
                                  size: 24,
                                );
                              }),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "Comments or Suggestions",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: isDarkMode ? Colors.white70 : Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _commentController,
                              maxLines: 5,
                              decoration: InputDecoration(
                                hintText: "Tell us about your experience or suggestions (e.g., app features, ASF detection accuracy)...",
                                hintStyle: GoogleFonts.poppins(
                                  color: isDarkMode ? Colors.grey.shade500 : Colors.grey.shade500,
                                ),
                                filled: true,
                                fillColor: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade100,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: isDarkMode ? Colors.grey.shade600 : Colors.grey.shade300,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: ArgieColors.primary),
                                ),
                              ),
                              style: GoogleFonts.poppins(
                                color: isDarkMode ? Colors.white70 : Colors.black87,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please provide your feedback";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),

                            // Image Upload
                            Text(
                              "Attach Images (Optional)",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: isDarkMode ? Colors.white70 : Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                ElevatedButton(
                                  onPressed: _pickImage,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ArgieColors.primary,
                                    foregroundColor: ArgieColors.textthird,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Text(
                                    "Add Image",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: _images.map((image) {
                                        return Padding(
                                          padding: const EdgeInsets.only(right: 8.0),
                                          child: Stack(
                                            children: [
                                              Image.file(
                                                image,
                                                width: 80,
                                                height: 80,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error, stackTrace) {
                                                  return Container(
                                                    width: 80,
                                                    height: 80,
                                                    color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade200,
                                                    child: const Icon(Icons.error, color: Colors.red),
                                                  );
                                                },
                                              ),
                                              Positioned(
                                                top: 0,
                                                right: 0,
                                                child: IconButton(
                                                  icon: Icon(
                                                    Icons.close,
                                                    color: isDarkMode ? Colors.white70 : Colors.black87,
                                                    size: 20,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      _images.remove(image);
                                                    });
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

                            // Submit Button
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _submitFeedback,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ArgieColors.primary,
                                  foregroundColor: ArgieColors.textthird,
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  "Submit Feedback",
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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