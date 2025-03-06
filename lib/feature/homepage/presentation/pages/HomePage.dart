import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:swine_care/feature/advancedrawer/presentation/pages/AdvanceDrawer.dart';
import 'package:swine_care/feature/homepage/presentation/widget/CheckerButton.dart';
import 'package:swine_care/feature/homepage/presentation/widget/ImagePickerUseCase.dart';
import 'package:swine_care/feature/homepage/presentation/widget/ImageUploadButton.dart';
import 'package:swine_care/feature/homepage/presentation/widget/SymptomsChecker.dart';
import 'package:swine_care/feature/homepage/presentation/widget/TextLabel1.dart';
import 'package:swine_care/feature/homepage/presentation/widget/TextLabel2.dart';
import '../widget/SaveButton.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ImagePickerUseCase _imagePickerUseCase = ImagePickerUseCase();
  File? selectedImageEars; //jpeg, png
  File? selectedImageSkin;
  File? selectedImageLegs;
  File? selectedImageNose;
  Uint8List? webImageEars; //basin mag upload og web na mga image icon,webm
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

  final _drawerController = AdvancedDrawerController();

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

  @override
  Widget build(BuildContext context) {
    return DrawerMenu(
      drawerController: _drawerController,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextLabel1(),
              const SizedBox(height: 20),
              TextLabel2(),
              const SizedBox(height: 10),

              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    _buildImageSection(
                      label: 'Ears',
                      imagePath: 'assets/images/pigparts/earpig.png',
                      selectedImage: selectedImageEars,
                      webImage: webImageEars,
                    ),
                    const SizedBox(height: 10),
                    _buildImageSection(
                      label: 'Skin',
                      imagePath: 'assets/images/pigparts/pigskin.jpg',
                      selectedImage: selectedImageSkin,
                      webImage: webImageSkin,
                    ),
                    const SizedBox(height: 10),
                    _buildImageSection(
                      label: 'Legs',
                      imagePath: 'assets/images/pigparts/piglegs.png',
                      selectedImage: selectedImageLegs,
                      webImage: webImageLegs,
                    ),
                    const SizedBox(height: 10),
                    _buildImageSection(
                      label: 'Nose',
                      imagePath: 'assets/images/pigparts/pignose.jpeg',
                      selectedImage: selectedImageNose,
                      webImage: webImageNose,
                    ),
                  ],
                ),
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
                symptoms: _answers,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection({
    required String label,
    required String imagePath,
    required File? selectedImage,
    required Uint8List? webImage,
  }) {
    return ImageUploadButton(
      label: label,
      imagePath: imagePath,
      image: selectedImage,
      webImage: webImage,
      onTap: () async {
        try {
          final result = await _imagePickerUseCase.pickImage(context);
          if (result != null) {
            if (kIsWeb) {
              final bytes = await result.readAsBytes();
              _updateImage(label, null, bytes);
            } else {
              _updateImage(label, File(result.path), null); // Convert XFile to File here
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