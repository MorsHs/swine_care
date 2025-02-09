import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:go_router/go_router.dart';

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
      animationCurve: Curves.easeInOut,
      openScale: 0.9,
      openRatio: 0.7,
      childDecoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      drawer: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Profile
            _buildProfileSection(),

            const SizedBox(height: 20),

            // Navigation Items
            _buildDrawerItem(
              context,
              icon: Icons.home,
              title: "Home",
              route: "/homepage",
            ),
            _buildDrawerItem(
              context,
              icon: Icons.menu_book,
              title: "Guide",
              route: "/guide",
            ),
            _buildDrawerItem(
              context,
              icon: Icons.settings,
              title: "Settings",
              route: "/setting",
            ),

            const Spacer(),

            _buildDrawerItem(
              context,
              icon: Icons.logout_outlined,
              title: "Logout",
              route: "  ",
            ),
            const SizedBox(height: 10),

            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "SwineCare v1.milliondalar",
                style: TextStyle(color: Colors.white70),
              ),
            ),
          ],
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Swine Care"),
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => drawerController.showDrawer(),
          ),
        ),
        body: body,
      ),
    );
  }

  //profile info, wla nanako himog widgets kay gravity na payts nani
  Widget _buildProfileSection() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('assets/images/rose.jpg'),
          ),
          SizedBox(width: 12),

          // User Info
          Column(
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

  // Drawer Item Widget
  Widget _buildDrawerItem(BuildContext context,
      {required IconData icon, required String title, required String route}) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: () {
        GoRouter.of(context).go(route);
      },
    );
  }
}
