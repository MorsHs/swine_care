import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:swine_care/colors/ArgieSizes.dart';
import 'package:swine_care/feature/homepage/presentation/widget/ImageUploadButton.dart';

class ImageGridView extends StatelessWidget {
  final Map<String, String> imagePaths;
  final Map<String, File?> selectedImages;
  final Map<String, Uint8List?> webImages;
  final bool isGridView; // This will be ignored as we'll always use grid view
  final Function(String, File?, Uint8List?) onUpdateImage;
  final Function(String) onPickImage;

  const ImageGridView({
    Key? key,
    required this.imagePaths,
    required this.selectedImages,
    required this.webImages,
    required this.isGridView, // Keep for backward compatibility
    required this.onUpdateImage,
    required this.onPickImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get screen width to determine layout
    final double screenWidth = MediaQuery.of(context).size.width;

    // For very small screens, use a single column layout
    if (screenWidth < 360) {
      return _buildSingleColumnLayout(context);
    }

    // Otherwise use the 2x2 grid layout
    return _buildGridView(context);
  }

  Widget _buildSingleColumnLayout(BuildContext context) {
    // Create a list of keys from imagePaths
    final List<String> keys = imagePaths.keys.toList();

    return Column(
      children: [
        for (int i = 0; i < keys.length; i++)
          Padding(
            padding: EdgeInsets.only(
              bottom: i < keys.length - 1 ? ArgieSizes.spaceBtwWidgets / 2 : 0,
            ),
            child: _buildImageSection(
              context: context,
              label: keys[i],
              imagePath: imagePaths[keys[i]]!,
              selectedImage: selectedImages[keys[i]],
              webImage: webImages[keys[i]],
            ),
          ),
      ],
    );
  }

  Widget _buildGridView(BuildContext context) {
    // Create a list of keys from imagePaths
    final List<String> keys = imagePaths.keys.toList();

    // Split the keys into two rows to ensure proper layout
    final List<String> firstRow = keys.length >= 2 ? keys.sublist(0, 2) : keys;
    final List<String> secondRow = keys.length > 2 ? keys.sublist(2) : [];

    // Calculate spacing based on screen size
    final double screenWidth = MediaQuery.of(context).size.width;
    final double spacing = screenWidth < 400 ? ArgieSizes.spaceBtwWidgets / 2 : ArgieSizes.spaceBtwWidgets;

    return Column(
      children: [
        // First row
        Row(
          children: [
            for (int i = 0; i < firstRow.length; i++)
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: i < firstRow.length - 1 ? spacing : 0,
                  ),
                  child: _buildImageSection(
                    context: context,
                    label: firstRow[i],
                    imagePath: imagePaths[firstRow[i]]!,
                    selectedImage: selectedImages[firstRow[i]],
                    webImage: webImages[firstRow[i]],
                  ),
                ),
              ),
          ],
        ),

        // Add spacing between rows
        if (secondRow.isNotEmpty)
          SizedBox(height: spacing),

        // Second row
        if (secondRow.isNotEmpty)
          Row(
            children: [
              for (int i = 0; i < secondRow.length; i++)
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: i < secondRow.length - 1 ? spacing : 0,
                    ),
                    child: _buildImageSection(
                      context: context,
                      label: secondRow[i],
                      imagePath: imagePaths[secondRow[i]]!,
                      selectedImage: selectedImages[secondRow[i]],
                      webImage: webImages[secondRow[i]],
                    ),
                  ),
                ),

              // If there's only one item in the second row, add an empty spacer
              if (secondRow.length == 1)
                Expanded(child: SizedBox()),
            ],
          ),
      ],
    );
  }

  Widget _buildImageSection({
    required BuildContext context,
    required String label,
    required String imagePath,
    required File? selectedImage,
    required Uint8List? webImage,
  }) {
    // Calculate responsive aspect ratio based on screen size
    final double screenWidth = MediaQuery.of(context).size.width;
    final double aspectRatio = screenWidth < 400 ? 0.95 : (screenWidth < 600 ? 0.9 : 0.85);

    return AspectRatio(
      aspectRatio: aspectRatio,
      child: ImageUploadButton(
        label: label,
        imagePath: imagePath,
        image: selectedImage,
        webImage: webImage,
        isGridView: true, // Always use grid layout for the button
        onTap: () => onPickImage(label),
        onRemove: () => onUpdateImage(label, null, null),
      ),
    );
  }
}