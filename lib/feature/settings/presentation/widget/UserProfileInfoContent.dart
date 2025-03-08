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
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
          ),
          UserProfileTile(),
          SizedBox(height: ArgieSizes.spaceBwtSection),
        ],
      ),
    );
  }
}