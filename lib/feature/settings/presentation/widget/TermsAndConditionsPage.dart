import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swine_care/colors/ArgieColors.dart';
import 'package:swine_care/colors/ArgieSizes.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? ArgieColors.dark : Colors.grey.shade50,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(ArgieSizes.paddingDefault),
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
                  SizedBox(width: 26),
                  Expanded(
                    child: Text(
                      "Terms and Conditions",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white70 : Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: ArgieSizes.spaceBtwSections),


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
                            "Terms and Conditions for SwineCare",
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: isDarkMode ? Colors.white70 : Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "Last Updated: March 10, 2025",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Introduction
                          Text(
                            "Introduction",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: isDarkMode ? Colors.white70 : Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Welcome to SwineCare, a mobile application developed to assist swine farmers in detecting early symptoms of African Swine Fever (ASF) in pigs using machine learning technology. By accessing or using SwineCare, you agree to be bound by these Terms and Conditions. If you do not agree with any part of these terms, you must not use the app.",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: isDarkMode ? Colors.grey.shade300 : Colors.grey.shade800,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "1. Use of the App",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: isDarkMode ? Colors.white70 : Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "a. Eligibility: You must be at least 18 years old and a registered swine farmer or authorized representative to use SwineCare. By using the app, you confirm that you meet these eligibility requirements.\n\n"
                                "b. Account Responsibility: You are responsible for maintaining the confidentiality of your account credentials. Any activity conducted under your account is your responsibility.\n\n"
                                "c. Intended Use: SwineCare is intended for detecting ASF symptoms in pigs. You agree to use the app solely for this purpose and not for any unlawful or unauthorized activities.\n\n"
                                "d. Data Accuracy: You are responsible for ensuring the accuracy of the data you provide, including images of pigs and farm information. Inaccurate data may lead to incorrect ASF diagnoses.",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: isDarkMode ? Colors.grey.shade300 : Colors.grey.shade800,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "2. ASF Detection and Reporting",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: isDarkMode ? Colors.white70 : Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "a. Diagnostic Results: SwineCare uses machine learning to analyze images and data for ASF symptoms. These results are for informational purposes only and should not replace professional veterinary advice.\n\n"
                                "b. Reporting Obligations: In the event of a confirmed or suspected ASF outbreak, you agree to report the findings to local veterinary authorities as required by law.\n\n"
                                "c. Data Sharing: Diagnostic results and farm data may be shared with veterinary authorities and research partners to assist in ASF containment and research, as outlined in our Privacy Policy.\n\n"
                                "d. Accuracy Disclaimer: While we strive to provide accurate ASF detection, the technology is not infallible. You agree to verify results with a qualified veterinarian before taking action.",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: isDarkMode ? Colors.grey.shade300 : Colors.grey.shade800,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "3. User Responsibilities",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: isDarkMode ? Colors.white70 : Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "a. Compliance with Laws: You agree to comply with all local, national, and international laws regarding swine farming, disease reporting, and data privacy.\n\n"
                                "b. Proper Use of Images: You must only upload images of pigs that you own or have permission to photograph. Uploading images of other farmers’ pigs without consent is prohibited.\n\n"
                                "c. Farm Biosecurity: You are responsible for implementing biosecurity measures on your farm based on SwineCare’s recommendations. Failure to do so may increase ASF risks.\n\n"
                                "d. Prohibited Activities: You may not use SwineCare to distribute false information, engage in fraudulent activities, or harm the app’s functionality (e.g., by uploading malicious files).",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: isDarkMode ? Colors.grey.shade300 : Colors.grey.shade800,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "4. Intellectual Property",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: isDarkMode ? Colors.white70 : Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "a. Ownership: SwineCare, including its machine learning models, design, and content, is the intellectual property of the SwineCare Research Team. You are granted a non-exclusive, non-transferable license to use the app for personal use.\n\n"
                                "b. User Content: By uploading images and data, you grant SwineCare a worldwide, royalty-free license to use, store, and analyze this content for ASF detection and research purposes.\n\n"
                                "c. Restrictions: You may not copy, modify, distribute, or reverse-engineer any part of SwineCare without prior written consent.",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: isDarkMode ? Colors.grey.shade300 : Colors.grey.shade800,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "5. Limitation of Liability",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: isDarkMode ? Colors.white70 : Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "a. No Warranty: SwineCare is provided 'as is' without warranties of any kind. We do not guarantee that the app will be error-free or that ASF detection will always be accurate.\n\n"
                                "b. Liability Cap: SwineCare and its developers shall not be liable for any indirect, incidental, or consequential damages (e.g., loss of livestock, financial losses) arising from your use of the app.\n\n"
                                "c. Veterinary Responsibility: You acknowledge that SwineCare is not a substitute for professional veterinary services. Any actions taken based on the app’s recommendations are at your own risk.",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: isDarkMode ? Colors.grey.shade300 : Colors.grey.shade800,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "6. Termination",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: isDarkMode ? Colors.white70 : Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "We reserve the right to suspend or terminate your access to SwineCare if you violate these Terms and Conditions, engage in prohibited activities, or fail to comply with legal requirements. Upon termination, your data may be retained for research purposes as outlined in our Privacy Policy.",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: isDarkMode ? Colors.grey.shade300 : Colors.grey.shade800,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "7. Changes to These Terms",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: isDarkMode ? Colors.white70 : Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "We may update these Terms and Conditions from time to time. We will notify you of significant changes via email or in-app notifications. Your continued use of SwineCare after such updates constitutes acceptance of the revised terms.",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: isDarkMode ? Colors.grey.shade300 : Colors.grey.shade800,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "8. Governing Law",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: isDarkMode ? Colors.white70 : Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "These Terms and Conditions are governed by the laws of the Republic of the Philippines. Any disputes arising from your use of SwineCare shall be resolved in the courts of Davao Del Norte, Philippines.",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: isDarkMode ? Colors.grey.shade300 : Colors.grey.shade800,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "9. Contact Us",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: isDarkMode ? Colors.white70 : Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "If you have any questions or concerns about these Terms and Conditions, please contact us at:\n\n"
                                "Email: pvoddn@gmail.com\n"
                                "Phone: +63 0917 792 2480\n"
                                "Address: Provincial Government Center, Mankilam, Tagum City, Davao del Norte, Tagum City, Philippines",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: isDarkMode ? Colors.grey.shade300 : Colors.grey.shade800,
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
    );
  }
}