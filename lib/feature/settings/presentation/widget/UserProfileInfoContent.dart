import 'package:flutter/material.dart';
import 'package:swine_care/colors/ArgieSizes.dart';
import 'package:swine_care/global_widget/PrimaryHeader/PrimaryHeaderContainer.dart';
import 'package:swine_care/feature/settings/presentation/widget/UserProfileTile.dart';
import 'package:swine_care/global_widget/GlobalAppBar.dart';

class UserProfileInfoContent extends StatelessWidget {
  const UserProfileInfoContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PrimaryHeaderContainer(
      child: Column(
        children: [
          GlobalAppBar(
            title: Text(
              'Account',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
          ),
          const AnimatedOpacity(
            opacity: 1.0,
            duration: Duration(milliseconds: 500),
            child: UserProfileTile(),
          ),
          const SizedBox(height: ArgieSizes.spaceBtwSections), // Updated to match ArgieSizes
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: ArgieSizes.paddingDefault),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text(
          //         'Member Since: March 08, 2023',
          //         style: GoogleFonts.poppins(
          //           fontSize: 14,
          //           color: Theme.of(context).textTheme.bodyMedium!.color,
          //         ),
          //       ),
          //       SizedBox(height: ArgieSizes.spaceBtwItems),
          //       Text(
          //         'Pigs Managed: 45',
          //         style: GoogleFonts.poppins(
          //           fontSize: 14,
          //           color: Theme.of(context).textTheme.bodyMedium!.color,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}