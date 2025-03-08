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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0).copyWith(bottom: 80.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextLabel1(
                isGridView: _isGridView,
                onToggleGridView: _toggleGridView,
              ),
              const SizedBox(height: 12),
              const TextLabel2(),
              const SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardTheme.color,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).shadowColor.withValues(alpha: 0.2),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: _isGridView ? _buildGridView() : _buildListView(),
              ),
              const SizedBox(height: 20),
              const CheckerButton(),
              const SizedBox(height: 10),
              SymptomsChecker(
                answers: _answers,
                onAnswerChanged: (question, answer) => setState(() {
                  _answers[question] = answer;
                }),
              ),
              const SizedBox(height: 50),
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
              const SizedBox(height: 20),
            ],
          ),
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
        const SizedBox(height: 10),
        _buildImageSection(
          label: 'Skin',
          imagePath: 'assets/images/pigparts/pigskin.jpg',
          selectedImage: selectedImageSkin,
          webImage: webImageSkin,
          isGridView: _isGridView,
        ),
        const SizedBox(height: 10),
        _buildImageSection(
          label: 'Legs',
          imagePath: 'assets/images/pigparts/piglegs.png',
          selectedImage: selectedImageLegs,
          webImage: webImageLegs,
          isGridView: _isGridView,
        ),
        const SizedBox(height: 10),
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
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
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
    return ImageUploadButton(
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
    );
  }
}