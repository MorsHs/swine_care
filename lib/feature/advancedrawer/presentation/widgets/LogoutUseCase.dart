import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LogoutUseCase {
  Future<void> confirmAndLogout(BuildContext context) async {
    bool? confirmLogout = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Logout Confirmation"),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Yes"),
          ),
        ],
      ),
    );

    if (confirmLogout == true) {
      GoRouter.of(context).go("/login");
    }
  }
}
