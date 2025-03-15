import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:swine_care/feature/homepage/presentation/widget/CheckerButton.dart';
import 'package:swine_care/feature/homepage/presentation/widget/HomePageHeader.dart';
import 'package:swine_care/feature/homepage/presentation/widget/ImagePickerUseCase.dart';
import 'package:swine_care/feature/homepage/presentation/widget/ImageUploadButton.dart';
import 'package:swine_care/feature/homepage/presentation/widget/SymptomsChecker.dart';
import 'package:swine_care/feature/homepage/presentation/widget/TextLabel1.dart';
import 'package:swine_care/feature/homepage/presentation/widget/TextLabel2.dart';
import 'package:swine_care/feature/homepage/presentation/widget/SaveButton.dart';
import 'package:swine_care/colors/ArgieColors.dart';
import 'package:swine_care/colors/ArgieSizes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  final ImagePickerUseCase _imagePickerUseCase = ImagePickerUseCase();
  File? selectedImageEars;
  File? selectedImageSkin;
  File? selectedImageLegs;
  File? selectedImageNose;
  Uint8List? webImageEars;
  Uint8List? webImageSkin;
  Uint8List? webImageLegs;
  Uint8List? webImageNose;

  final Map<String, bool?> _answers = {
    "High temperature?": null,
    "Clumsy movement?": null,
    "Loss of appetite?": null,
    "Rapid breathing?": null,
    "Unusual vocalization?": null,
  };

  bool _isGridView = false;

  late AnimationController _headerAnimationController;
  late Animation<double> _headerAnimation;

  @override
  void initState() {
    super.initState();
    _headerAnimationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _headerAnimation = Tween<double>(begin: 0.0, end: 0.1).animate(
      CurvedAnimation(parent: _headerAnimationController, curve: Curves.easeInOut),
    );
    _headerAnimationController.forward();
  }

  @override
  void dispose() {
    _headerAnimationController.dispose();
    super.dispose();
  }

  void _updateImage(String part, File? image, Uint8List? webImage) {
    setState(() {
      switch (part) {
        case 'Ears':
          selectedImageEars = image;
          webImageEars = webImage;
          break;
        case 'Skin':
          selectedImageSkin = image;
          webImageSkin = webImage;
          break;
        case 'Legs':
          selectedImageLegs = image;
          webImageLegs = webImage;
          break;
        case 'Nose':
          selectedImageNose = image;
          webImageNose = webImage;
          break;
      }
    });
  }

  void _toggleGridView() {
    setState(() {
      _isGridView = !_isGridView;
    });
  }

  Widget _buildImageSection({
    required String label,
    required String imagePath,
    required File? selectedImage,
    required Uint8List? webImage,
    required bool isGridView,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      child: ImageUploadButton(
        label: label,
        imagePath: imagePath,
        image: selectedImage,
        webImage: webImage,
        isGridView: isGridView,
        onTap: () async {
          try {
            final result = await _imagePickerUseCase.pickImage(context);
            if (result != null) {
              if (kIsWeb) {
                final bytes = await result.readAsBytes();
                _updateImage(label, null, bytes);
              } else {
                _updateImage(label, File(result.path), null);
              }
            }
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error uploading image: $e')),
            );
          }
        },
        onRemove: () => _updateImage(label, null, null),
      ),
    );
  }

  Widget _buildListView() {
    return Column(
      children: [
        _buildImageSection(
          label: 'Ears',
          imagePath: 'assets/images/pigparts/earpig.png',
          selectedImage: selectedImageEars,
          webImage: webImageEars,
          isGridView: _isGridView,
        ),
        const SizedBox(height: ArgieSizes.spaceBtwWidgets),
        _buildImageSection(
          label: 'Skin',
          imagePath: 'assets/images/pigparts/pigskin.jpg',
          selectedImage: selectedImageSkin,
          webImage: webImageSkin,
          isGridView: _isGridView,
        ),
        const SizedBox(height: ArgieSizes.spaceBtwWidgets),
        _buildImageSection(
          label: 'Legs',
          imagePath: 'assets/images/pigparts/piglegs.png',
          selectedImage: selectedImageLegs,
          webImage: webImageLegs,
          isGridView: _isGridView,
        ),
        const SizedBox(height: ArgieSizes.spaceBtwWidgets),
        _buildImageSection(
          label: 'Nose',
          imagePath: 'assets/images/pigparts/pignose.jpeg',
          selectedImage: selectedImageNose,
          webImage: webImageNose,
          isGridView: _isGridView,
        ),
      ],
    );
  }

  Widget _buildGridView() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: ArgieSizes.spaceBtwWidgets,
      mainAxisSpacing: ArgieSizes.spaceBtwWidgets,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 0.75,
      children: [
        _buildImageSection(
          label: 'Ears',
          imagePath: 'assets/images/pigparts/earpig.png',
          selectedImage: selectedImageEars,
          webImage: webImageEars,
          isGridView: _isGridView,
        ),
        _buildImageSection(
          label: 'Skin',
          imagePath: 'assets/images/pigparts/pigskin.jpg',
          selectedImage: selectedImageSkin,
          webImage: webImageSkin,
          isGridView: _isGridView,
        ),
        _buildImageSection(
          label: 'Legs',
          imagePath: 'assets/images/pigparts/piglegs.png',
          selectedImage: selectedImageLegs,
          webImage: webImageLegs,
          isGridView: _isGridView,
        ),
        _buildImageSection(
          label: 'Nose',
          imagePath: 'assets/images/pigparts/pignose.jpeg',
          selectedImage: selectedImageNose,
          webImage: webImageNose,
          isGridView: _isGridView,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? ArgieColors.dark : ArgieColors.ligth,
      body: Stack(
        children: [
          // Background Gradient
          // Container(
          //   decoration: BoxDecoration(
          //     gradient: LinearGradient(
          //       colors: [
          //         ArgieColors.primary.withValues(alpha: 0.1),
          //         ArgieColors.secondary.withValues(alpha: 0.5),
          //       ],
          //       begin: Alignment.topLeft,
          //       end: Alignment.bottomRight,
          //     ),
          //   ),
          // ),
          SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: HomePageHeader(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: ArgieSizes.paddingDefault,
                        vertical: ArgieSizes.spaceBtwItems,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextLabel1(
                            isGridView: _isGridView,
                            onToggleGridView: _toggleGridView,
                          ),
                          const SizedBox(height: ArgieSizes.spaceBtwItems / 2),
                          const TextLabel2(),
                          const SizedBox(height: ArgieSizes.spaceBtwSections),
                        ],
                      ),
                    ),
                  ),
                ),
                // Main Content
                SliverPadding(
                  padding: const EdgeInsets.all(ArgieSizes.paddingDefault).copyWith(bottom: 100.0),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          color: isDarkMode ? Colors.grey.shade800 : Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              transitionBuilder: (child, animation) {
                                return FadeTransition(opacity: animation, child: child);
                              },
                              child: _isGridView ? _buildGridView() : _buildListView(),
                            ),
                          ),
                        ),
                        const SizedBox(height: ArgieSizes.spaceBtwSections),
                        const Center(
                          child: CheckerButton(),
                        ),
                        const SizedBox(height: ArgieSizes.spaceBtwWidgets),
                        Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          color: isDarkMode ? Colors.grey.shade800 : Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: SymptomsChecker(
                              answers: _answers,
                              onAnswerChanged: (question, answer) => setState(() {
                                _answers[question] = answer;
                              }),
                            ),
                          ),
                        ),
                        const SizedBox(height: ArgieSizes.spaceBtwSections),
                        SaveButton(
                          uploadedImages: {
                            'Ears': selectedImageEars,
                            'Skin': selectedImageSkin,
                            'Legs': selectedImageLegs,
                            'Nose': selectedImageNose,
                          },
                          webImages: {
                            'Ears': webImageEars,
                            'Skin': webImageSkin,
                            'Legs': webImageLegs,
                            'Nose': webImageNose,
                          },
                          symptoms: _answers,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}