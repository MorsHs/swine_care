import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swine_care/feature/homepage/presentation/widget/CameraContainer.dart';

class CameraGrid extends StatelessWidget {
  final File? selectedImageEars;
  final File? selectedImageSkin;
  final File? selectedImageLegs;
  final File? selectedImageNose;
  final VoidCallback onImageEarsSelected;
  final VoidCallback onImageSkinSelected;
  final VoidCallback onImageLegsSelected;
  final VoidCallback onImageNoseSelected;

  const CameraGrid({
    Key? key,
    this.selectedImageEars,
    this.selectedImageSkin,
    this.selectedImageLegs,
    this.selectedImageNose,
    required this.onImageEarsSelected,
    required this.onImageSkinSelected,
    required this.onImageLegsSelected,
    required this.onImageNoseSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Upload Images of Different Pig Parts",
          style: GoogleFonts.concertOne(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
        const SizedBox(height: 16),

        // Row of 4 containers for cameras
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            CameraContainer(
              text: "pig ears",
              icon: Icons.add_a_photo,
              selectedImage: selectedImageEars,
              onTap: onImageEarsSelected,
            ),

            CameraContainer(
              text: "pig skin",
              icon: Icons.add_a_photo,
              selectedImage: selectedImageSkin,
              onTap: onImageSkinSelected,
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            CameraContainer(
              text: "pig legs",
              icon: Icons.add_a_photo,
              selectedImage: selectedImageLegs,
              onTap: onImageLegsSelected,
            ),

            CameraContainer(
              text: "pig nose",
              icon: Icons.add_a_photo,
              selectedImage: selectedImageNose,
              onTap: onImageNoseSelected,
            ),
          ],
        ),
      ],
    );
  }
}