import 'dart:io';
import 'package:flutter/foundation.dart' show Uint8List, kIsWeb;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swine_care/colors/ArgieColors.dart';

class ImageUploadButton extends StatefulWidget {
  final String label;
  final String imagePath;
  final File? image;
  final VoidCallback onTap;
  final VoidCallback? onRemove;
  final Uint8List? webImage;
  final bool isGridView;
  final bool isActive;

  const ImageUploadButton({
    super.key,
    required this.label,
    required this.imagePath,
    required this.image,
    required this.onTap,
    this.onRemove,
    this.webImage,
    required this.isGridView,
    this.isActive = true,
  });

  @override
  State<ImageUploadButton> createState() => _ImageUploadButtonState();
}

class _ImageUploadButtonState extends State<ImageUploadButton> {
  void _showEnlargedImage(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: isDarkMode ? ArgieColors.darkAccent : Colors.white,
          elevation: 10,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Main image container
              Container(
                width: MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.height * 0.6,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: isDarkMode ? ArgieColors.darkAccent : Colors.white,
                ),
                child: Column(
                  children: [
                    // Header with title
                    Row(
                      children: [
                        Icon(
                            widget.label.toLowerCase().contains('ears') ? Icons.hearing : Icons.medical_services,
                            color: ArgieColors.primary),
                        const SizedBox(width: 8),
                        Text(
                          "Pig ${widget.label} Image",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Image display
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: kIsWeb
                            ? Image.memory(
                          widget.webImage!,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            debugPrint('Error displaying web image for ${widget.label}: $error');
                            return Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                      Icons.error_outline,
                                      size: 50,
                                      color: Colors.red.shade400),
                                  const SizedBox(height: 16),
                                  Text(
                                    "Failed to load image",
                                    style: GoogleFonts.poppins(
                                        color: Colors.red.shade400),
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                            : Image.file(
                          widget.image!,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            debugPrint('Error displaying file image for ${widget.label}: $error');
                            return Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                      Icons.error_outline,
                                      size: 50,
                                      color: Colors.red.shade400),
                                  const SizedBox(height: 16),
                                  Text(
                                    "Failed to load image",
                                    style: GoogleFonts.poppins(
                                        color: Colors.red.shade400),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Close button
              Positioned(
                right: -10,
                top: -10,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.red.shade700 : Colors.red,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 5,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(8),
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
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool hasImage = kIsWeb ? widget.webImage != null : widget.image != null;
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: !widget.isActive ? null : widget.onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isDarkMode
              ? ArgieColors.darkAccent
              : (Theme.of(context).cardTheme.color ?? Colors.white),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: !widget.isActive
                ? (isDarkMode ? Colors.grey.shade700 : Colors.grey.withValues(alpha: 0.3))
                : (hasImage
                ? ArgieColors.primary.withValues(alpha: 0.8)
                : Colors.blue.withValues(alpha: 0.6)),
            width: widget.isActive ? 2.0 : 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: !widget.isActive
                  ? Colors.transparent
                  : (hasImage
                  ? ArgieColors.primary.withValues(alpha: isDarkMode ? 0.3 : 0.2)
                  : Colors.transparent),
              spreadRadius: 0,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: widget.isGridView
            ? _buildGridLayout(context, hasImage, isDarkMode)
            : _buildListLayout(context, hasImage, isDarkMode),
      ),
    );
  }

  Widget _buildListLayout(BuildContext context, bool hasImage, bool isDarkMode) {
    // Calculate responsive size based on screen width
    final double screenWidth = MediaQuery.of(context).size.width;
    final double imageSize = screenWidth < 400 ? 60 : 70;

    return Row(
      children: [
        // Left image
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: hasImage
                  ? _buildImagePreview(size: imageSize, hasImage: true, isDarkMode: isDarkMode)
                  : Stack(
                children: [

                  //diri mag upload and user og image

                  Image.asset(
                    widget.imagePath,
                    width: imageSize,
                    height: imageSize,
                    fit: BoxFit.cover,
                  ),
                  if (!widget.isActive)
                    Container(
                      width: imageSize,
                      height: imageSize,
                      color: Colors.black.withValues(alpha: 0.3),
                    ),
                ],
              ),
            ),
            if (!widget.isActive)
              const SizedBox()
            else if (!hasImage)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.add_a_photo,
                      color: Colors.white.withValues(alpha: 0.9),
                      size: imageSize * 0.3,
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(width: 8),

        // Middle text
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.label,
                style: GoogleFonts.poppins(
                  fontSize: screenWidth < 400 ? 14 : 16,
                  fontWeight: FontWeight.bold,
                  color: !widget.isActive
                      ? Theme.of(context).textTheme.bodyLarge!.color!.withValues(alpha: 0.5)
                      : (isDarkMode ? Colors.white : Theme.of(context).textTheme.bodyLarge!.color),
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(
                    hasImage ? Icons.check_circle : Icons.upload,
                    size: screenWidth < 400 ? 12 : 14,
                    color: hasImage
                        ? ArgieColors.primary
                        : isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      hasImage ? 'Successfully uploaded' : 'Tap to upload image',
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth < 400 ? 10 : 12,
                        color: hasImage
                            ? ArgieColors.primary
                            : isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Right uploaded image preview
        if (hasImage)
          Stack(
            alignment: Alignment.topRight,
            children: [
              // Preview image
              GestureDetector(
                onTap: () => _showEnlargedImage(context),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: ArgieColors.primary.withValues(alpha: 0.5),
                      width: 2,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: _buildImagePreview(size: imageSize, hasImage: true, isDarkMode: isDarkMode),
                  ),
                ),
              ),

              // Remove button
              if (widget.isActive && widget.onRemove != null)
                Positioned(
                  right: -5,
                  top: -5,
                  child: GestureDetector(
                    onTap: widget.onRemove,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            spreadRadius: 1,
                            blurRadius: 3,
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(4),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 14,
                      ),
                    ),
                  ),
                ),
            ],
          ),
      ],
    );
  }

  Widget _buildGridLayout(BuildContext context, bool hasImage, bool isDarkMode) {
    // Calculate responsive size based on screen width
    final double screenWidth = MediaQuery.of(context).size.width;
    final double containerSize = screenWidth < 400 ? 80 : (screenWidth < 600 ? 90 : 100);
    final double fontSize = screenWidth < 400 ? 12 : 14;
    final double statusFontSize = screenWidth < 400 ? 10 : 12;
    final double iconSize = screenWidth < 400 ? 24 : 28;

    return LayoutBuilder(
      builder: (context, constraints) {
        // Ensure the container size doesn't exceed the available width
        final double availableWidth = constraints.maxWidth;
        final double actualSize = availableWidth > containerSize ? containerSize : availableWidth - 16;

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image section
            Stack(
              alignment: Alignment.center,
              children: [
                // Main image container
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: hasImage
                      ? GestureDetector(
                    onTap: () => _showEnlargedImage(context),
                    child: Container(
                      width: actualSize,
                      height: actualSize,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: ArgieColors.primary.withValues(alpha: 0.5),
                          width: 2,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: _buildImagePreview(
                            size: actualSize,
                            hasImage: true,
                            isDarkMode: isDarkMode),
                      ),
                    ),
                  )
                      : Container(
                    width: actualSize,
                    height: actualSize,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: widget.isActive
                            ? Colors.blue.withValues(alpha: 0.5)
                            : (isDarkMode ? Colors.grey.shade700 : Colors.grey.withValues(alpha: 0.3)),
                        width: widget.isActive ? 2 : 1,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(
                            widget.imagePath,
                            fit: BoxFit.cover,
                          ),
                          if (!widget.isActive)
                            Container(
                              color: Colors.black.withValues(alpha: 0.3),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Overlay for upload indicator
                if (widget.isActive && !hasImage)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_photo_alternate_rounded,
                            color: Colors.white.withValues(alpha: 0.9),
                            size: iconSize,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Upload",
                            style: GoogleFonts.poppins(
                              color: Colors.white.withValues(alpha: 0.9),
                              fontSize: fontSize - 2,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                // Remove button for uploaded images
                if (hasImage && widget.isActive && widget.onRemove != null)
                  Positioned(
                    right: -6,
                    top: -6,
                    child: GestureDetector(
                      onTap: widget.onRemove,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.3),
                              spreadRadius: 1,
                              blurRadius: 3,
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(6),
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            // Label and status
            const SizedBox(height: 6),
            Text(
              widget.label,
              style: GoogleFonts.poppins(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: !widget.isActive
                    ? Theme.of(context).textTheme.bodyLarge!.color!.withValues(alpha: 0.6)
                    : (isDarkMode ? Colors.white : Theme.of(context).textTheme.bodyLarge!.color),
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: hasImage
                    ? ArgieColors.primary.withValues(alpha: isDarkMode ? 0.3 : 0.2)
                    : (!widget.isActive
                    ? (isDarkMode ? Colors.grey.shade800 : Colors.grey.withValues(alpha: 0.1))
                    : (isDarkMode ? Colors.blue.withValues(alpha: 0.3) : Colors.blue.withValues(alpha: 0.1))),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    hasImage ? Icons.check_circle : Icons.upload,
                    size: statusFontSize - 2,
                    color: hasImage
                        ? ArgieColors.primary
                        : (!widget.isActive
                        ? (isDarkMode ? Colors.grey.shade400 : Colors.grey)
                        : Colors.blue),
                  ),
                  const SizedBox(width: 2),
                  Text(
                    hasImage ? 'Uploaded' : 'Required',
                    style: GoogleFonts.poppins(
                      fontSize: statusFontSize - 2,
                      fontWeight: FontWeight.w500,
                      color: hasImage
                          ? ArgieColors.primary
                          : (!widget.isActive
                          ? (isDarkMode ? Colors.grey.shade400 : Colors.grey)
                          : Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildImagePreview({required double size, required bool hasImage, required bool isDarkMode}) {
    if (!hasImage) return const SizedBox();

    return kIsWeb
        ? Image.memory(
      widget.webImage!,
      width: size,
      height: size,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        debugPrint('Error displaying web image for ${widget.label}: $error');
        return Container(
          width: size,
          height: size,
          color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
          child: Icon(
            Icons.broken_image_rounded,
            color: isDarkMode ? Colors.grey.shade600 : Colors.grey.shade400,
            size: size / 3,
          ),
        );
      },
    )
        : Image.file(
      widget.image!,
      width: size,
      height: size,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        debugPrint('Error displaying file image for ${widget.label}: $error');
        return Container(
          width: size,
          height: size,
          color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
          child: Icon(
            Icons.broken_image_rounded,
            color: isDarkMode ? Colors.grey.shade600 : Colors.grey.shade400,
            size: size / 3,
          ),
        );
      },
    );
  }
}