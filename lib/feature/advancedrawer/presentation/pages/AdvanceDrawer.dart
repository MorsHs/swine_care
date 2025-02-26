import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
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
            DrawerItem(icon: Icons.home, title: "Home", route: "/homepage"),
            DrawerItem(icon: Icons.menu_book, title: "Guide", route: "/guide"),
            DrawerItem(icon: Icons.settings, title: "Settings", route: "/setting"),

            const Spacer(),

            // Logout
            DrawerItem(
              icon: Icons.logout_outlined,
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
          title: Text(
            "Swine Care",
            style: GoogleFonts.rubik(fontWeight: FontWeight.w600, fontSize: 18),
          ),
          leading: IconButton(
            icon: const Icon(Icons.menu_sharp, size: 28),
            onPressed: () => drawerController.showDrawer(),
          ),
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
