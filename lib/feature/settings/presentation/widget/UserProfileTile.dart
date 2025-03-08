import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swine_care/colors/ArgieColors.dart';

class UserProfileTile extends StatelessWidget {
  const UserProfileTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Image.asset(
          'assets/images/rose.jpg',
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(
        'Argie uwu',
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).textTheme.bodyLarge?.color,
        ),
      ),
      subtitle: Text(
        'argieuwu@gmail.com',
        style: GoogleFonts.poppins(
          fontSize: 14,
          color: Theme.of(context).textTheme.bodyMedium?.color,
        ),
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: Icon(
          Iconsax.edit,
          color: ArgieColors.primary,
          size: 24,
        ),
      ),
    );
  }
}