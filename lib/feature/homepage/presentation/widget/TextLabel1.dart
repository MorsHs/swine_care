import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:swine_care/colors/ArgieColors.dart';

class TextLabel1 extends StatelessWidget {
  final bool isGridView;
  final VoidCallback onToggleGridView;

  const TextLabel1({
    super.key,
    required this.isGridView,
    required this.onToggleGridView,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(
              'Detect ASF in Your Pigs',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ),
        GestureDetector(
          onTap: onToggleGridView,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.all(4.0),
            child: IconButton(
              icon: Icon(
                isGridView ? Iconsax.element_3 : Iconsax.element_4,
                color: Theme.of(context).brightness == Brightness.dark
                    ? ArgieColors.textfifth
                    : ArgieColors.textfourth,
                size: 20,
              ),
              onPressed: null, // Disabled state
              tooltip: isGridView ? 'Switch to List View' : 'Switch to Grid View',
              constraints: const BoxConstraints(),
              padding: const EdgeInsets.all(8.0),
              splashColor: (Theme.of(context).colorScheme.primary ?? ArgieColors.primary).withValues(alpha: 0.3),
              highlightColor: (Theme.of(context).colorScheme.primary ?? ArgieColors.primary).withValues(alpha: 0.1),
              disabledColor: Theme.of(context).brightness == Brightness.dark
                  ? ArgieColors.textfifth
                  : ArgieColors.textfourth,
            ),
          ),
        ),
      ],
    );
  }
}