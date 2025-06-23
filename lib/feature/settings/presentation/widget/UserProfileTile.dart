import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swine_care/colors/ArgieColors.dart';
import 'package:swine_care/data/repositories/AuthRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProfileTile extends StatefulWidget {
  const UserProfileTile({super.key});

  @override
  State<UserProfileTile> createState() => _UserProfileTileState();
}

class _UserProfileTileState extends State<UserProfileTile> {
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

      final userData = await AuthRepository().getUserData();
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

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color titleTextColor = isDarkMode ? ArgieColors.textthird : ArgieColors.textBold;
    final Color subtitleTextColor = isDarkMode ? ArgieColors.textthird.withValues(alpha: 0.9) : ArgieColors.textSemiBlack;

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
          child: Image.asset(
            'assets/images/finalprofileicon.png',
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 50,
                height: 50,
                color: Colors.grey.shade300,
                child: Icon(
                  Icons.person,
                  color: Colors.grey.shade600,
                  size: 30,
                ),
              );
            },
          ),
        ),
      ),
      title: Row(
        children: [
          Flexible(
            child: Text(
              _username ?? 'Guest',
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
              overflow: TextOverflow.ellipsis,
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
        _email ?? 'No email',
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: subtitleTextColor,
          letterSpacing: 0.2,
        ),
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () {},
    );
  }
}