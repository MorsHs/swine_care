import 'dart:io';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swine_care/colors/ArgieColors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swine_care/data/repositories/AuthRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProfileTile extends StatefulWidget {
  const UserProfileTile({super.key});

  @override
  State<UserProfileTile> createState() => _UserProfileTileState();
}

class _UserProfileTileState extends State<UserProfileTile> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  final AuthRepository _authRepository = AuthRepository();
  String? _username;
  String? _email;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    if (!mounted) return;
    setState(() {
      _isLoading = true;
    });

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        if (mounted) {
          setState(() {
            _username = null;
            _email = null;
            _isLoading = false;
          });
        }
        return;
      }

      final userData = await _authRepository.getUserData();
      if (mounted) {
        setState(() {
          _username = userData['username'];
          _email = userData['email'];
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching user data: $e');
      if (mounted) {
        setState(() {
          _username = null;
          _email = null;
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to load user data: $e',
              style: GoogleFonts.poppins(),
            ),
            backgroundColor: Colors.red.shade600,
          ),
        );
      }
    }
  }

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null && mounted) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to pick image: $e',
              style: GoogleFonts.poppins(),
            ),
            backgroundColor: Colors.red.shade600,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color titleTextColor = isDarkMode ? ArgieColors.textthird : ArgieColors.textBold;
    final Color subtitleTextColor = isDarkMode ? ArgieColors.textthird.withValues(alpha: 0.9) : ArgieColors.textSemiBlack;
    final Color iconColor = isDarkMode ? ArgieColors.textfifth : ArgieColors.textfourth;

    return _isLoading
        ? Center(child: CircularProgressIndicator(color: ArgieColors.primary))
        : ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [ArgieColors.primary, ArgieColors.secondary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(50),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: _selectedImage != null
              ? Image.file(
            _selectedImage!,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          )
              : Image.asset(
            'assets/images/rose.jpg',
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Row(
        children: [
          Text(
            _username ?? 'Loading...',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: titleTextColor,
              letterSpacing: 0.5,
              shadows: isDarkMode
                  ? []
                  : [
                Shadow(
                  color: ArgieColors.shadow.withValues(alpha: 0.3),
                  offset: const Offset(1, 1),
                  blurRadius: 2,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
      subtitle: Text(
        _email ?? 'Loading...',
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: subtitleTextColor,
          letterSpacing: 0.2,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: _pickImage,
            icon: Icon(
              Iconsax.edit,
              color: iconColor,
              size: 24,
            ),
            tooltip: 'Change Profile Picture',
            splashColor: (Theme.of(context).colorScheme.primary ?? ArgieColors.primary).withValues(alpha: 0.3),
            highlightColor: (Theme.of(context).colorScheme.primary ?? ArgieColors.primary).withValues(alpha: 0.1),
          ),
        ],
      ),
      onTap: () {},
    );
  }
}