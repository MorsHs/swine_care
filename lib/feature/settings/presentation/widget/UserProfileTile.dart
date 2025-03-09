import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swine_care/colors/ArgieColors.dart';
import 'dart:math' as math;

class UserProfileTile extends StatelessWidget {
  const UserProfileTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color titleTextColor = isDarkMode ? ArgieColors.textthird : ArgieColors.textBold;
    final Color subtitleTextColor = isDarkMode ? ArgieColors.textthird.withValues(alpha: 0.9) : ArgieColors.textSemiBlack;
    final Color iconColor = isDarkMode ? ArgieColors.textfifth : ArgieColors.textfourth;

    print('UserProfileTile - Dark Mode: $isDarkMode, Title Color: $titleTextColor, Subtitle Color: $subtitleTextColor, Icon Color: $iconColor');

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [ArgieColors.primary, ArgieColors.secondary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(50),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.asset(
            'assets/images/rose.jpg',
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Row(
        children: [
          Text(
            'Argie uwu',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: titleTextColor,
              letterSpacing: 0.5,
              shadows: isDarkMode
                  ? []
                  : [
                Shadow(
                  color: ArgieColors.shadow.withValues(alpha: 0.3),
                  offset: const Offset(1, 1),
                  blurRadius: 2,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
          ), // Online status dot
        ],
      ),
      subtitle: Text(
        'argieuwu@gmail.com',
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: subtitleTextColor,
          letterSpacing: 0.2,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              // Handle edit action
            },
            icon: Icon(
              Iconsax.edit,
              color: iconColor,
              size: 24,
            ),
            tooltip: 'Edit Profile',
            splashColor: (Theme.of(context).colorScheme.primary ?? ArgieColors.primary).withValues(alpha: 0.3),
            highlightColor: (Theme.of(context).colorScheme.primary ?? ArgieColors.primary).withValues(alpha: 0.1),
          ),
        ],
      ),
      onTap: () {
        // Handle tile tap (e.g., navigate to profile details)
      },
    );
  }
}