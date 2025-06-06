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

class _ScaffoldWithBottomNavBarState extends State<ScaffoldWithBottomNavBar> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.navigationShell.currentIndex;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.forward();
  }

  void _onItemTapped(int index) {
    if (_isDisposed) return;

    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
      _controller.reset();
      _controller.forward();
      widget.navigationShell.goBranch(index);
    }
  }

  @override
  void didUpdateWidget(ScaffoldWithBottomNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_isDisposed) return;

    if (widget.navigationShell.currentIndex != _selectedIndex) {
      setState(() {
        _selectedIndex = widget.navigationShell.currentIndex;
      });
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _isDisposed = true; // Set disposal flag
    _controller.dispose();
    super.dispose();
  }

  final List<Map<String, dynamic>> _navItems = [
    {'icon': Iconsax.home, 'label': 'Home', 'route': '/homepage'},
    {'icon': Iconsax.book, 'label': 'Guide', 'route': '/guide'},
    {'icon': Iconsax.notification_status, 'label': 'History', 'route': '/history'},
    {'icon': Iconsax.setting, 'label': 'Settings', 'route': '/setting'},
  ];

  @override
  Widget build(BuildContext context) {
    if (_isDisposed) {
      return const SizedBox.shrink();
    }

    final String currentPath = GoRouterState.of(context).fullPath ?? '';
    const mainRoutes = ['/homepage', '/guide', '/history', '/setting'];
    final bool showBottomNavBar = mainRoutes.contains(currentPath);
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBody: true,
      body: SizedBox.expand(
        child: widget.navigationShell,
      ),
      floatingActionButton: null,
      bottomNavigationBar: showBottomNavBar
          ? AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          if (_isDisposed) {
            return const SizedBox.shrink();
          }

          return SizedBox(
            height: kBottomNavigationBarHeight + 20,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? Colors.black.withValues(alpha: 0.2)
                        : Colors.white.withValues(alpha: 0.2),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                    border: Border(
                      top: BorderSide(
                        color: isDarkMode ? Colors.white10 : Colors.black12,
                        width: 1,
                      ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: ArgieColors.shadow.withValues(alpha: 0.15),
                        blurRadius: 12,
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
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              width: 70,
                              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? ArgieColors.primary.withValues(alpha: 0.1)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: Icon(
                                      item['icon'] as IconData,
                                      size: isSelected ? 28 : 24,
                                      color: isSelected
                                          ? ArgieColors.primary
                                          : isDarkMode
                                          ? ArgieColors.textthird
                                          : ArgieColors.textsecondary,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Expanded(
                                    child: Transform.scale(
                                      scale: isSelected ? 1.0 + (_animation.value * 0.1) : 1.0,
                                      child: Text(
                                        item['label'] as String,
                                        style: TextStyle(
                                          fontSize: 11,
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
                                    ),
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
              ),
            ),
          );
        },
      )
          : null,
    );
  }
}