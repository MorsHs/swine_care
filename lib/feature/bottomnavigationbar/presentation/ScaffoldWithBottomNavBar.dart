import 'dart:ui'; // For BackdropFilter
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart'; // For matching icons
import 'package:swine_care/colors/ArgieColors.dart'; // Import your color class

class ScaffoldWithBottomNavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithBottomNavBar({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    // Get the current route path
    final String currentPath = GoRouterState.of(context).fullPath ?? '';

    // Define the routes where the bottom navigation bar should be shown
    const mainRoutes = ['/homepage', '/guide', '/history', '/setting'];

    // Check if the current path matches one of the main routes
    bool showBottomNavBar = mainRoutes.contains(currentPath);

    return Scaffold(
      extendBody: true, // Allow content to extend behind the navigation bar
      body: navigationShell,
      bottomNavigationBar: showBottomNavBar
          ? Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0), // Increased vertical padding for prominence
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30), // Rounded corners
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12), // Slightly stronger blur
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    ArgieColors.textthird.withValues(alpha: 0.9), // Base white with opacity
                    ArgieColors.primarybackground.withValues(alpha: 0.7), // Subtle gradient with primary background
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: ArgieColors.dark.withValues(alpha: 0.2), // Dark shadow from palette
                    blurRadius: 12,
                    spreadRadius: 2,
                    offset: const Offset(0, 4), // Slightly larger offset for depth
                  ),
                ],
              ),
              child: BottomNavigationBar(
                currentIndex: navigationShell.currentIndex,
                onTap: (index) => navigationShell.goBranch(index),
                backgroundColor: Colors.transparent, // Transparent to show blur and gradient
                elevation: 0, // Remove default elevation (we use custom shadow)
                type: BottomNavigationBarType.fixed, // Prevent shifting animation
                selectedItemColor: ArgieColors.primary, // Primary color for selected icon
                unselectedItemColor: ArgieColors.textsecondary, // Secondary text color for unselected icons
                selectedIconTheme: const IconThemeData(size: 28), // Larger selected icon
                unselectedIconTheme: const IconThemeData(size: 24), // Slightly smaller unselected icon
                showSelectedLabels: false, // Hide labels
                showUnselectedLabels: false, // Hide labels
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Iconsax.home), // Match icon from image
                    label: 'HOME',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.tips_and_updates_outlined), // Match icon from image
                    label: 'GUIDE',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.history), // Match icon from image
                    label: 'HISTORY',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.settings), // Match icon from image
                    label: 'SETTINGS',
                  ),
                ],
              ),
            ),
          ),
        ),
      )
          : null, // Hide the bottom navigation bar for subroutes
    );
  }
}