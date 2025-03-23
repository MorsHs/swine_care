import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:swine_care/feature/homepage/presentation/widget/AnswerAllQuestionsTextLabel.dart';
import 'package:swine_care/feature/homepage/presentation/widget/CheckerButton.dart';
import 'package:swine_care/feature/homepage/presentation/widget/FeatureCard.dart';
import 'package:swine_care/feature/homepage/presentation/widget/HomePageHeader.dart';
import 'package:swine_care/feature/homepage/presentation/widget/ImageGridView.dart';
import 'package:swine_care/feature/homepage/presentation/widget/ImagePickerUseCase.dart';
import 'package:swine_care/feature/homepage/presentation/widget/InfoCard.dart';
import 'package:swine_care/feature/homepage/presentation/widget/ProgressIndicatorCard.dart';
import 'package:swine_care/feature/homepage/presentation/widget/SymptomsChecker.dart';
import 'package:swine_care/feature/homepage/presentation/widget/SaveButton.dart';
import 'package:swine_care/colors/ArgieColors.dart';
import 'package:swine_care/colors/ArgieSizes.dart';
import 'package:swine_care/feature/homepage/presentation/widget/SymptomsChecklistLabelText.dart';
import 'package:swine_care/feature/homepage/presentation/widget/TakeClearPhotosTextLabel.dart';
import 'package:swine_care/feature/homepage/presentation/widget/UploadPigImagesTextLabel.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  final ImagePickerUseCase _imagePickerUseCase = ImagePickerUseCase();

  // Image state variables
  File? selectedImageEars;
  File? selectedImageSkin;
  File? selectedImageLegs;
  File? selectedImageNose;
  Uint8List? webImageEars;
  Uint8List? webImageSkin;
  Uint8List? webImageLegs;
  Uint8List? webImageNose;

  // Symptom answers
  final Map<String, bool?> _answers = {
    "High temperature?": null,
    "Clumsy movement?": null,
    "Loss of appetite?": null,
    "Rapid breathing?": null,
    "Unusual vocalization?": null,
  };

  // UI state
  bool _isGridView = false;
  // bool _showWelcomeAnimation = true;
  //
  // // Animation controllers
  // late AnimationController _headerAnimationController;
  // late Animation<double> _headerAnimation;

  // Keys and controllers
  final GlobalKey _symptomsSectionKey = GlobalKey();
  final GlobalKey _uploadSectionKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();

  // Image paths mapping
  final Map<String, String> _imagePaths = {
    'Ears': 'assets/images/pigparts/earpig.png',
    'Skin': 'assets/images/pigparts/pigskin.jpg',
    'Legs': 'assets/images/pigparts/piglegs.png',
    'Nose': 'assets/images/pigparts/pignose.jpeg',
  };


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

  Future<void> _pickImage(String part) async {
    try {
      final result = await _imagePickerUseCase.pickImage(context);
      if (result != null) {
        if (kIsWeb) {
          final bytes = await result.readAsBytes();
          _updateImage(part, null, bytes);
        } else {
          _updateImage(part, File(result.path), null);
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading image: $e')),
      );
    }
  }

  // Calculate progress metrics
  int get _imagesUploaded {
    int count = 0;
    if (selectedImageEars != null || webImageEars != null) count++;
    if (selectedImageSkin != null || webImageSkin != null) count++;
    if (selectedImageLegs != null || webImageLegs != null) count++;
    if (selectedImageNose != null || webImageNose != null) count++;
    return count;
  }

  int get _questionsAnswered {
    int count = 0;
    for (var answer in _answers.values) {
      if (answer != null) count++;
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Prepare image maps for the ImageGridView
    final Map<String, File?> selectedImages = {
      'Ears': selectedImageEars,
      'Skin': selectedImageSkin,
      'Legs': selectedImageLegs,
      'Nose': selectedImageNose,
    };

    final Map<String, Uint8List?> webImages = {
      'Ears': webImageEars,
      'Skin': webImageSkin,
      'Legs': webImageLegs,
      'Nose': webImageNose,
    };

    return Scaffold(
      backgroundColor: isDarkMode ? ArgieColors.dark : Color(0xFFF8F9FA),
      body: Stack(
        children: [

          // Main Content
          SafeArea(
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                // Header - now using the extracted widget
                SliverToBoxAdapter(
                  child: HomeHeader(
                    uploadSectionKey: _uploadSectionKey,
                  ),
                  ),


                // Main Content
                SliverPadding(
                  padding: const EdgeInsets.all(ArgieSizes.paddingDefault).copyWith(bottom: 100.0),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Feature card
                        const FeatureCard(),

                        // Information card
                        const InfoCard(),

                        // Progress indicator
                        ProgressIndicatorCard(
                          imagesUploaded: _imagesUploaded,
                          totalImages: 4,
                          questionsAnswered: _questionsAnswered,
                          totalQuestions: _answers.length,
                        ),

                        // Image upload section
                        Card(
                          key: _uploadSectionKey, // Added key here for scrolling
                          elevation: 2,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          color: isDarkMode ? Colors.grey.shade800 : Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                //Text Label
                                UploadPigImagesTextLabel(isDarkMode: isDarkMode),

                                const SizedBox(height: 16),

                                //Text Label
                                TakeClearPhotosTextLabel(isDarkMode: isDarkMode),

                                const SizedBox(height: 16),

                                //Image Grid View
                                AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 300),
                                  transitionBuilder: (child, animation) {
                                    return FadeTransition(opacity: animation, child: child);
                                  },
                                  child: ImageGridView(
                                    imagePaths: _imagePaths,
                                    selectedImages: selectedImages,
                                    webImages: webImages,
                                    isGridView: _isGridView,
                                    onUpdateImage: _updateImage,
                                    onPickImage: _pickImage,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: ArgieSizes.spaceBtwSections),

                        // Checker button
                        Center(
                          child: CheckerButton(symptomsSectionKey: _symptomsSectionKey),
                        ),
                        const SizedBox(height: ArgieSizes.spaceBtwWidgets),

                        // Symptoms checker card
                        Card(
                          key: _symptomsSectionKey,
                          elevation: 2,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          color: isDarkMode ? Colors.grey.shade800 : Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                // Text Label
                                SymptomsChecklistLabelText(isDarkMode: isDarkMode),

                                const SizedBox(height: 16),

                                // Text Label
                                AnswerAllQuestionsTextLabel(),

                                const SizedBox(height: 16),

                                //Symptoms Checker
                                SymptomsChecker(
                                  answers: _answers,
                                  onAnswerChanged: (question, answer) => setState(() {
                                    _answers[question] = answer;
                                  }),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Save button
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


