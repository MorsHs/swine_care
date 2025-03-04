import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:swine_care/feature/advancedrawer/presentation/widgets/DrawerItem.dart';
import 'package:swine_care/feature/advancedrawer/presentation/widgets/LogoutUseCase.dart';


class DrawerMenu extends StatelessWidget {
  final AdvancedDrawerController drawerController;
  final Widget body;

  const DrawerMenu({super.key, required this.drawerController, required this.body});

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      controller: drawerController,
      backdropColor: Colors.blueGrey[900],
      animationDuration: const Duration(milliseconds: 300),
      animationCurve: Curves.fastEaseInToSlowEaseOut,
      openScale: 0.85,
      openRatio: 0.7,
      childDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 12,
            offset: Offset(-5, 5),
          )
        ],
      ),
      drawer: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileSection(),
            const SizedBox(height: 30),

            // Navigation Items
            DrawerItem(icon: Iconsax.home, title: "Home", route: "/homepage"),
            DrawerItem(icon: Iconsax.activity, title: "Guide", route: "/guide"),
            DrawerItem(icon: Iconsax.settings, title: "Settings", route: "/setting"),

            const Spacer(),

            // Logout
            DrawerItem(
              icon: Iconsax.logout,
              title: "Logout",
              onTap: () => LogoutUseCase().confirmAndLogout(context),
            ),

            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "SwineCare v1.0",
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          // backgroundColor: Colors.white, // Set AppBar background to white
          title: Row(
            children: [
              // Custom Icon
              Image.asset(
                "assets/Logo/SwineCareIcon1.png", // Path to your custom icon
                width: 30, // Adjust size as needed
                height: 30,
              ),
              const SizedBox(width: 8), // Add spacing between the icon and text
              // App Title
              Text(
                "Swine Care",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  // color: Colors.black, // Ensure text color contrasts with the white background
                ),
              ),
            ],
          ),
          leading: GestureDetector(
            onTap: () => drawerController.showDrawer(),
            child: Padding(
              padding: const EdgeInsets.all(8.0), // Add padding for better alignment
              child: Image.asset(
                "assets/images/menu-bar.png", // Replace with your PNG menu icon
                width: 16, // Adjust size as needed
                height: 16,
              ),
            ),
          ),
          elevation: 2, // Subtle shadow for depth
        ),
        body: body,
      ),
    );
  }

  Widget _buildProfileSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: Row(
        children: [
          Hero(
            tag: "profilePic",
            child: CircleAvatar(
              radius: 32,
              backgroundColor: Colors.white,
              child: ClipOval(
                child: Image.asset('assets/images/rose.jpg', fit: BoxFit.cover),
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Argie uwu",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                "argiegravity@eheeey",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
