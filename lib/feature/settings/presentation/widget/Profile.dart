import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: const AssetImage('assets/images/rose.jpg'),
            backgroundColor: Colors.grey[300],
          ),
          const SizedBox(height: 12),
          const Text(
            'argie uwu',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'argieuwu@umindanao.edu.ph',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
