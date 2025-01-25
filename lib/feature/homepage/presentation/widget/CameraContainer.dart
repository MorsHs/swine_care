import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CameraContainer extends StatelessWidget {
  final String text;
  final IconData icon;
  final File? selectedImage;
  final VoidCallback onTap;

  const CameraContainer({
    Key? key,
    required this.text,
    required this.icon,
    this.selectedImage,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 1.5),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              selectedImage == null
                  ? Icon(
                icon,
                size: 40,
                color: Colors.grey,
              )
                  : Image.file(
                selectedImage!,
                fit: BoxFit.cover,
                width: 150,
                height: 150,
              ),
              const SizedBox(height: 8),
              Text(
                text,
                textAlign: TextAlign.center,
                style: GoogleFonts.concertOne(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.teal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}