import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swine_care/colors/ArgieColors.dart';
import 'package:swine_care/colors/ArgieSizes.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? ArgieColors.dark : Colors.grey.shade50,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(ArgieSizes.paddingDefault),
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
                      "Privacy Policy",
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
                            "Privacy Policy for SwineCare",
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
                            "At SwineCare, we are committed to protecting the privacy and security of our users. SwineCare is a mobile application designed to assist swine farmers in detecting early symptoms of African Swine Fever (ASF) in pigs through machine learning and image analysis. This Privacy Policy outlines how we collect, use, disclose, and protect your personal information when you use our app. By using SwineCare, you agree to the practices described in this policy.",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: isDarkMode ? Colors.grey.shade300 : Colors.grey.shade800,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "1. Information We Collect",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: isDarkMode ? Colors.white70 : Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "We collect the following types of information to provide and improve our services:\n\n"
                                "a. Personal Information: When you register for an account, we may collect your name, email address, phone number, and farm address to identify you and facilitate communication.\n\n"
                                "b. Farm Data: To provide accurate ASF detection, we collect data about your farm, including the number of pigs, their health status, and any symptoms you report.\n\n"
                                "c. Images and Media: SwineCare requires images of pigs to analyze for ASF symptoms. These images are uploaded to our secure servers for machine learning analysis.\n\n"
                                "d. Device Information: We collect information about your device, such as the device type, operating system, and unique device identifiers, to optimize the app’s performance.\n\n"
                                "e. Usage Data: We collect data on how you interact with the app, such as the features you use, the time spent on the app, and crash reports, to improve user experience.\n\n"
                                "f. Location Data: With your consent, we may collect your location to map ASF outbreaks and provide localized alerts.",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: isDarkMode ? Colors.grey.shade300 : Colors.grey.shade800,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "2. How We Use Your Information",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: isDarkMode ? Colors.white70 : Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "We use your information for the following purposes:\n\n"
                                "a. ASF Detection and Alerts: Images and farm data are used by our machine learning models to detect early signs of ASF and provide you with diagnostic results and alerts.\n\n"
                                "b. Communication: We use your contact information to send you notifications about ASF risks, app updates, and other relevant information.\n\n"
                                "c. Research and Analytics: Anonymized and aggregated data may be used for research purposes to improve ASF detection models and understand disease patterns.\n\n"
                                "d. Service Improvement: Usage data helps us identify bugs, enhance features, and improve the overall user experience.\n\n"
                                "e. Compliance and Safety: We may use your information to comply with legal obligations, prevent fraud, and ensure the safety of our users.",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: isDarkMode ? Colors.grey.shade300 : Colors.grey.shade800,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "3. Data Sharing",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: isDarkMode ? Colors.white70 : Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "We do not sell your personal information to third parties. However, we may share your data under the following circumstances:\n\n"
                                "a. With Veterinary Authorities: In the event of a confirmed ASF outbreak, we may share relevant data (e.g., farm location, number of affected pigs) with local veterinary authorities to assist in containment efforts.\n\n"
                                "b. Service Providers: We use third-party services (e.g., cloud storage, machine learning platforms) to process images and data. These providers are contractually obligated to protect your information.\n\n"
                                "c. Research Partners: Anonymized data may be shared with research institutions to advance ASF prevention and control strategies.\n\n"
                                "d. Legal Requirements: We may disclose your information if required by law or to protect the rights, safety, or property of SwineCare and its users.",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: isDarkMode ? Colors.grey.shade300 : Colors.grey.shade800,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "4. Data Security",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: isDarkMode ? Colors.white70 : Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "We implement industry-standard security measures to protect your data, including encryption of data in transit and at rest, secure authentication protocols, and regular security audits. However, no system is completely secure, and we cannot guarantee the absolute security of your information. You are responsible for maintaining the confidentiality of your account credentials.",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: isDarkMode ? Colors.grey.shade300 : Colors.grey.shade800,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "5. Your Rights",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: isDarkMode ? Colors.white70 : Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "You have the following rights regarding your personal information:\n\n"
                                "a. Access: You can request access to the data we have collected about you.\n\n"
                                "b. Correction: You can request corrections to inaccurate or incomplete data.\n\n"
                                "c. Deletion: You can request the deletion of your data, subject to legal and operational requirements.\n\n"
                                "d. Opt-Out: You can opt out of receiving non-essential communications, such as promotional emails.\n\n"
                                "To exercise these rights, please contact us at privacy @davaodelnorte.gov.ph.",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: isDarkMode ? Colors.grey.shade300 : Colors.grey.shade800,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "6. Data Retention",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: isDarkMode ? Colors.white70 : Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "We retain your data for as long as necessary to provide our services and comply with legal obligations. Images and diagnostic data are retained for a maximum of 5 years for research purposes, after which they are anonymized or deleted. You can request earlier deletion of your data by contacting us.",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: isDarkMode ? Colors.grey.shade300 : Colors.grey.shade800,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "7. Changes to This Privacy Policy",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: isDarkMode ? Colors.white70 : Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "We may update this Privacy Policy from time to time to reflect changes in our practices or legal requirements. We will notify you of significant changes via email or in-app notifications. Your continued use of SwineCare after such updates constitutes acceptance of the revised policy.",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: isDarkMode ? Colors.grey.shade300 : Colors.grey.shade800,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "8. Contact Us",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: isDarkMode ? Colors.white70 : Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "If you have any questions or concerns about this Privacy Policy or our data practices, please contact us at:\n\n"
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