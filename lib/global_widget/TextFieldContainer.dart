import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:swine_care/colors/ArgieColors.dart';

class Textfieldcontainer extends StatefulWidget {
  final bool isHidden;
  final String label;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool showVisibilityToggle;
  final IconData? prefixIcon;

  const Textfieldcontainer({
    super.key,
    required this.isHidden,
    required this.label,
    this.controller,
    this.validator,
    this.showVisibilityToggle = false,
    this.prefixIcon,
  });

  @override
  State<Textfieldcontainer> createState() => _TextfieldcontainerState();
}

class _TextfieldcontainerState extends State<Textfieldcontainer> {
  bool _isObscured = true;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.isHidden;
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: TextFormField(
        controller: widget.controller,
        obscureText: _isObscured,
        style: TextStyle(
          color: isDarkMode ? ArgieColors.textthird : ArgieColors.textBold,
          fontSize: 16,
        ),
        validator: widget.validator,
        decoration: decoration(isDarkMode),
      ),
    );
  }

  InputDecoration decoration(bool isDarkMode) {
    return InputDecoration(
      label: Text(widget.label),
      labelStyle: TextStyle(
        color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
        fontSize: 14,
      ),
      prefixIcon: widget.prefixIcon != null
          ? Icon(
        widget.prefixIcon,
        color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
      )
          : null,
      suffixIcon: widget.showVisibilityToggle
          ? IconButton(
        icon: Icon(
          _isObscured ? Iconsax.eye_slash : Iconsax.eye,
          color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
        ),
        onPressed: () {
          setState(() {
            _isObscured = !_isObscured;
          });
        },
      )
          : null,
      filled: true,
      fillColor: isDarkMode ? Colors.white : Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(
          color: isDarkMode ? Colors.grey.shade600 : Colors.grey.shade300,
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(
          color: ArgieColors.primary,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(
          color: isDarkMode ? Colors.red[300]! : Colors.red,
          width: 1,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(
          color: isDarkMode ? Colors.red[300]! : Colors.red,
          width: 2,
        ),
      ),
    );
  }
}