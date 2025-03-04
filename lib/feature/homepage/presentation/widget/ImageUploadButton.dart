import 'dart:io';
import 'package:flutter/material.dart';

class ImageUploadButton extends StatelessWidget {
  final String label;
  final String imagePath;
  final File? image;
  final VoidCallback onTap;

  const ImageUploadButton({
    super.key,
    required this.label,
    required this.imagePath,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          children: [
            // Image
            Padding(
              padding: const EdgeInsets.all(10),
              child: Image.asset(
                imagePath,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),

            // Label and Image Preview
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  if (image != null)
                    Text(
                      'Uploaded',
                      style: TextStyle(fontSize: 12, color: Colors.green),
                    )
                  else
                    const Text(
                      'Tap to upload',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                ],
              ),
            ),

            // Uploaded Image Preview
            if (image != null)
              Padding(
                padding: const EdgeInsets.all(10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.file(
                    image!,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}