import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:swine_care/colors/ArgieColors.dart';

class TextLabel1 extends StatefulWidget {
  final bool isGridView;
  final VoidCallback onToggleGridView;

  const TextLabel1({
    super.key,
    required this.isGridView,
    required this.onToggleGridView,
  });

  @override
  _TextLabel1State createState() => _TextLabel1State();
}

class _TextLabel1State extends State<TextLabel1> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Text(
              'Detect ASF in Your Pigs',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? ArgieColors.textthird : ArgieColors.textBold,
                letterSpacing: 0.5,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ),
        GestureDetector(
          onTapDown: (_) => _controller.forward(),
          onTapUp: (_) => _controller.reverse(),
          onTapCancel: () => _controller.reverse(),
          onTap: widget.onToggleGridView,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isDarkMode
                  ? ArgieColors.dark.withValues(alpha: 0.2)
                  : ArgieColors.ligth.withValues(alpha: 0.1),
            ),
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: IconButton(
                icon: Icon(
                  widget.isGridView ? Iconsax.element_3 : Iconsax.element_4,
                  color: isDarkMode
                      ? ArgieColors.textthird.withValues(alpha: 0.9)
                      : ArgieColors.textBold.withValues(alpha: 0.85),
                  size: 22,
                ),
                onPressed: widget.onToggleGridView,
                tooltip: widget.isGridView ? 'Switch to List View' : 'Switch to Grid View',
                constraints: const BoxConstraints(),
                padding: const EdgeInsets.all(8.0),
                splashColor: ArgieColors.primary.withValues(alpha: 0.3),
                highlightColor: ArgieColors.primary.withValues(alpha: 0.15),
                hoverColor: ArgieColors.secondary.withValues(alpha: 0.2),
              ),
            ),
          ),
        ),
      ],
    );
  }
}