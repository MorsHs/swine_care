import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swine_care/colors/ArgieColors.dart';
import 'package:swine_care/colors/ArgieSizes.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  bool _newDiagnosisNotif = true;
  bool _updateNotif = true;
  bool _alertNotif = false;

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
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: isDarkMode ? Colors.white70 : Colors.black87,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text(
                    "Notification Settings",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: ArgieColors.textthird,
                      shadows: [Shadow(
                          color: ArgieColors.shadow,
                          blurRadius: 2
                      )],
                    ),
                  ),
                ],
              ),
              SizedBox(height: ArgieSizes.spaceBtwSections),

              // Notification Preferences
              Card(
                color: isDarkMode ? Colors.grey.shade800 : Colors.white,
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Manage Notifications",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: isDarkMode ? Colors.white70 : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // New Diagnosis Notification Toggle
                      SwitchListTile(
                        title: Text(
                          "New Diagnosis",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: isDarkMode ? Colors.white70 : Colors.black87,
                          ),
                        ),
                        subtitle: Text(
                          "Notify when a new diagnosis is added",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                          ),
                        ),
                        value: _newDiagnosisNotif,
                        onChanged: (value) {
                          setState(() {
                            _newDiagnosisNotif = value;
                          });
                        },
                        activeColor: ArgieColors.primary,
                        inactiveTrackColor: isDarkMode ? Colors.grey.shade600 : Colors.grey.shade300,
                      ),

                      // Update Notification Toggle
                      SwitchListTile(
                        title: Text(
                          "Updates",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: isDarkMode ? Colors.white70 : Colors.black87,
                          ),
                        ),
                        subtitle: Text(
                          "Notify when there are updates to existing diagnoses",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                          ),
                        ),
                        value: _updateNotif,
                        onChanged: (value) {
                          setState(() {
                            _updateNotif = value;
                          });
                        },
                        activeColor: ArgieColors.primary,
                        inactiveTrackColor: isDarkMode ? Colors.grey.shade600 : Colors.grey.shade300,
                      ),

                      // Alert Notification Toggle
                      SwitchListTile(
                        title: Text(
                          "Alerts",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: isDarkMode ? Colors.white70 : Colors.black87,
                          ),
                        ),
                        subtitle: Text(
                          "Notify for high-risk ASF alerts",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                          ),
                        ),
                        value: _alertNotif,
                        onChanged: (value) {
                          setState(() {
                            _alertNotif = value;
                          });
                        },
                        activeColor: ArgieColors.primary,
                        inactiveTrackColor: isDarkMode ? Colors.grey.shade600 : Colors.grey.shade300,
                      ),
                    ],
                  ),
                ),
              ),

              const Spacer(),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Save notification preferences (to be implemented with backend)
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Notification preferences saved!")),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ArgieColors.primary,
                    foregroundColor: ArgieColors.textthird,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    "Save Preferences",
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
    );
  }
}