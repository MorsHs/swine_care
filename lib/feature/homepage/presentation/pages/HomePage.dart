import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:swine_care/feature/homepage/presentation/widget/CheckerButton.dart';
import 'package:swine_care/feature/homepage/presentation/widget/ImagePickerUseCase.dart';
import 'package:swine_care/feature/homepage/presentation/widget/ImageUploadButton.dart';
import 'package:swine_care/feature/homepage/presentation/widget/SymptomsChecker.dart';
import 'package:swine_care/feature/homepage/presentation/widget/TextLabel1.dart';
import 'package:swine_care/feature/homepage/presentation/widget/TextLabel2.dart';
import 'package:swine_care/feature/homepage/presentation/widget/SaveButton.dart';
import 'package:swine_care/colors/ArgieColors.dart';
import 'package:swine_care/colors/ArgieSizes.dart';
import 'package:swine_care/global_widget/PrimaryHeader/PrimaryHeaderContainer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: PrimaryHeaderContainer(
                child: Padding(
                  padding: EdgeInsets.symmetric(
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
                      SizedBox(height: ArgieSizes.spaceBtwItems),
                      TextLabel2(),
                      SizedBox(height: ArgieSizes.spaceBtwSections),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(ArgieSizes.paddingDefault).copyWith(bottom: 80.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(ArgieSizes.paddingDefault),
                      decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? ArgieColors.dark
                            : ArgieColors.ligth,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.transparent,
                          width: 2,
                        ),
                        gradient: LinearGradient(
                          colors: [
                            ArgieColors.primary.withValues(alpha: 0.2),
                            ArgieColors.secondary.withValues(alpha: 0.1),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),

                      ),
                      child: _isGridView ? _buildGridView() : _buildListView(),
                    ),
                    SizedBox(height: ArgieSizes.spaceBtwSections),
                    const CheckerButton(),
                    SizedBox(height: ArgieSizes.spaceBtwWidgets),
                    SymptomsChecker(
                      answers: _answers,
                      onAnswerChanged: (question, answer) => setState(() {
                        _answers[question] = answer;
                      }),
                    ),
                    SizedBox(height: 50),
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
                    SizedBox(height: ArgieSizes.spaceBtwSections),
                  ],
                ),
              ),
            ),
          ],
        ),
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
        SizedBox(height: ArgieSizes.spaceBtwWidgets),
        _buildImageSection(
          label: 'Skin',
          imagePath: 'assets/images/pigparts/pigskin.jpg',
          selectedImage: selectedImageSkin,
          webImage: webImageSkin,
          isGridView: _isGridView,
        ),
        SizedBox(height: ArgieSizes.spaceBtwWidgets),
        _buildImageSection(
          label: 'Legs',
          imagePath: 'assets/images/pigparts/piglegs.png',
          selectedImage: selectedImageLegs,
          webImage: webImageLegs,
          isGridView: _isGridView,
        ),
        SizedBox(height: ArgieSizes.spaceBtwWidgets),
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

  Widget _buildImageSection({
    required String label,
    required String imagePath,
    required File? selectedImage,
    required Uint8List? webImage,
    required bool isGridView,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
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
}