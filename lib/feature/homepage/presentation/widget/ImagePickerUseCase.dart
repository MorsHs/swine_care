import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class ImagePickerUseCase {
  final ImagePicker _picker = ImagePicker();

  Future<File?> pickImage(BuildContext context) async {
    return showDialog<File>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose Image Source'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.image, color: Colors.blueAccent),
              title: const Text('Upload from Gallery'),
              onTap: () async {
                Navigator.pop(context); // Close the dialog
                final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
                if (pickedFile != null) {
                  Navigator.pop(context, File(pickedFile.path)); // Return the File
                } else {
                  Navigator.pop(context, null); // Return null if no file is selected
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Colors.blueAccent),
              title: const Text('Take a Picture'),
              onTap: () async {
                Navigator.pop(context); // Close the dialog
                final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
                if (pickedFile != null) {
                  Navigator.pop(context, File(pickedFile.path)); // Return the File
                } else {
                  Navigator.pop(context, null); // Return null if no file is selected
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}