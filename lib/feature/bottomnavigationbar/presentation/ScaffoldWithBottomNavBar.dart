import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:swine_care/colors/ArgieColors.dart';

class ScaffoldWithBottomNavBar extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithBottomNavBar({
    super.key,
    required this.navigationShell,
  });

  @override
  State<ScaffoldWithBottomNavBar> createState() => _ScaffoldWithBottomNavBarState();
}

class _ScaffoldWithBottomNavBarState extends State<ScaffoldWithBottomNavBar> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.navigationShell.currentIndex;
  }

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
      widget.navigationShell.goBranch(index);
    }
  }

  @override
  void didUpdateWidget(ScaffoldWithBottomNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.navigationShell.currentIndex != _selectedIndex) {
      setState(() {
        _selectedIndex = widget.navigationShell.currentIndex;
      });
    }
  }

  final List<Map<String, dynamic>> _navItems = [
    {'icon': Iconsax.home, 'label': 'HOME', 'route': '/homepage'},
    {'icon': Iconsax.book, 'label': 'GUIDE', 'route': '/guide'},
    {'icon': Iconsax.notification_status, 'label': 'HISTORY', 'route': '/history'},
    {'icon': Iconsax.setting, 'label': 'SETTINGS', 'route': '/setting'},
  ];

  @override
  Widget build(BuildContext context) {
    final String currentPath = GoRouterState.of(context).fullPath ?? '';
    // print('ScaffoldWithBottomNavBar Build - Current Path: $currentPath'); // Debug print
    const mainRoutes = ['/homepage', '/guide', '/history', '/setting'];
    final bool showBottomNavBar = mainRoutes.contains(currentPath);
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBody: true,
      body: SizedBox.expand(
        child: widget.navigationShell,
      ),
      floatingActionButton: null, // Explicitly disable FAB
      bottomNavigationBar: showBottomNavBar
          ? SizedBox(
        height: kBottomNavigationBarHeight + 16,
        child: Container(
          decoration: BoxDecoration(
            // gradient: LinearGradient(
            //   colors: [
            //     isDarkMode
            //         ? ArgieColors.dark.withValues(alpha: 0.9)
            //         : Colors.white.withValues(alpha: 0.9),
            //     ArgieColors.primary.withValues(alpha: 0.2),
            //   ],
            //   begin: Alignment.topLeft,
            //   end: Alignment.bottomRight,
            // ),
            boxShadow: [
              BoxShadow(
                color: ArgieColors.shadow.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, -6),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(_navItems.length, (index) {
                  final item = _navItems[index];
                  final bool isSelected = _selectedIndex == index;
                  return GestureDetector(
                    onTap: () => _onItemTapped(index),
                    child: SizedBox(
                      width: 60,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            item['icon'] as IconData,
                            size: isSelected ? 26 : 24,
                            color: isSelected
                                ? ArgieColors.primary
                                : isDarkMode
                                ? ArgieColors.textthird
                                : ArgieColors.textsecondary,
                          ),
                          const SizedBox(height: 4),
                          // Always show the label (no animation)
                          Text(
                            item['label'] as String,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                              color: isSelected
                                  ? ArgieColors.primary
                                  : isDarkMode
                                  ? Colors.white70
                                  : Colors.black54,
                            ),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      )
          : null,
    );
  }
}