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

class _ScaffoldWithBottomNavBarState extends State<ScaffoldWithBottomNavBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _labelFadeAnimation;
  int _selectedIndex = 0;
  bool _showLabels = false;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.navigationShell.currentIndex;
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _labelFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
        _showLabels = true;
        _animationController.forward().then((_) {
          Future.delayed(const Duration(milliseconds: 1500), () {
            if (mounted) {
              setState(() {
                _showLabels = false;
              });
            }
          });
        });
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
    {'icon': Icons.tips_and_updates_outlined, 'label': 'GUIDE', 'route': '/guide'},
    {'icon': Icons.history, 'label': 'HISTORY', 'route': '/history'},
    {'icon': Icons.settings, 'label': 'SETTINGS', 'route': '/setting'},
  ];

  @override
  Widget build(BuildContext context) {
    final String currentPath = GoRouterState.of(context).fullPath ?? '';
    const mainRoutes = ['/homepage', '/guide', '/history', '/setting'];
    final bool showBottomNavBar = mainRoutes.contains(currentPath);
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBody: true,
      body: widget.navigationShell,
      bottomNavigationBar: showBottomNavBar
          ? Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              isDarkMode
                  ? ArgieColors.dark.withValues(alpha: 0.9)
                  : Colors.white.withValues(alpha: 0.9),
              ArgieColors.primary.withValues(alpha: 0.2),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: ArgieColors.shadow.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, -2),
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
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: isSelected ? _scaleAnimation.value : 1.0,
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
                            AnimatedOpacity(
                              opacity: _showLabels && isSelected ? 1.0 : 0.0,
                              duration: const Duration(milliseconds: 200),
                              child: Text(
                                item['label'] as String,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: isSelected
                                      ? ArgieColors.primary
                                      : isDarkMode
                                      ? Colors.white70
                                      : Colors.black54,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }),
            ),
          ),
        ),
      )
          : null,
    );
  }
}