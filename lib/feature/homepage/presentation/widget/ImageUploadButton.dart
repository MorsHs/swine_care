import 'dart:io';
import 'package:flutter/foundation.dart' show Uint8List, kIsWeb;
import 'package:flutter/material.dart';

class ImageUploadButton extends StatelessWidget {
  final String label;
  final String imagePath;
  final File? image;
  final VoidCallback onTap;
  final VoidCallback? onRemove;
  final Uint8List? webImage;
  final bool isGridView;

  const ImageUploadButton({
    super.key,
    required this.label,
    required this.imagePath,
    required this.image,
    required this.onTap,
    this.onRemove,
    this.webImage,
    required this.isGridView,
  });

  void _showEnlargedImage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.6,
                padding: const EdgeInsets.all(16),
                color: Theme.of(context).cardTheme.color, // Use theme's card color
                child: kIsWeb
                    ? Image.memory(
                  webImage!,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(child: Icon(Icons.error, size: 50));
                  },
                )
                    : Image.file(
                  image!,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(child: Icon(Icons.error, size: 50));
                  },
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.red),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: (kIsWeb ? webImage != null : image != null) ? Colors.green : Colors.grey,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withValues(alpha: 0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: isGridView ? _buildGridLayout(context) : _buildListLayout(context),
      ),
    );
  }

  Widget _buildListLayout(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            imagePath,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                (kIsWeb ? webImage != null : image != null) ? 'Image Uploaded' : 'Tap to upload',
                style: TextStyle(
                  fontSize: 12,
                  color: (kIsWeb ? webImage != null : image != null) ? Colors.green : Theme.of(context).textTheme.bodyMedium!.color, // Use theme's secondary text color
                ),
              ),
            ],
          ),
        ),
        if (kIsWeb ? webImage != null : image != null)
          Stack(
            alignment: Alignment.topRight,
            children: [
              GestureDetector(
                onTap: () => _showEnlargedImage(context),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: kIsWeb
                        ? Image.memory(
                      webImage!,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 60,
                          height: 60,
                          color: Theme.of(context).dividerColor,
                          child: const Icon(Icons.error),
                        );
                      },
                    )
                        : Image.file(
                      image!,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 60,
                          height: 60,
                          color: Theme.of(context).dividerColor,
                          child: const Icon(Icons.error),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: GestureDetector(
                  onTap: onRemove,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(2),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildGridLayout(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: (kIsWeb ? webImage != null : image != null)
              ? GestureDetector(
            onTap: () => _showEnlargedImage(context),
            child: kIsWeb
                ? Image.memory(
              webImage!,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 80,
                  height: 80,
                  color: Theme.of(context).dividerColor,
                  child: const Icon(Icons.error),
                );
              },
            )
                : Image.file(
              image!,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 80,
                  height: 80,
                  color: Theme.of(context).dividerColor,
                  child: const Icon(Icons.error),
                );
              },
            ),
          )
              : Image.asset(
            imagePath,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.bodyLarge!.color,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          (kIsWeb ? webImage != null : image != null) ? 'Uploaded' : 'Tap to upload',
          style: TextStyle(
            fontSize: 10,
            color: (kIsWeb ? webImage != null : image != null) ? Colors.green : Theme.of(context).textTheme.bodyMedium!.color, // Use theme's secondary text color
          ),
          textAlign: TextAlign.center,
        ),
        if (kIsWeb ? webImage != null : image != null) ...[
          const SizedBox(height: 8),
          GestureDetector(
            onTap: onRemove,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(2),
              child: const Icon(
                Icons.close,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ],
      ],
    );
  }
}