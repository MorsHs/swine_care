import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:swine_care/feature/homepage/presentation/widget/AnswerAllQuestionsTextLabel.dart';
import 'package:swine_care/feature/homepage/presentation/widget/HomePageHeader.dart';
import 'package:swine_care/feature/homepage/presentation/widget/ImageGridView.dart';
import 'package:swine_care/feature/homepage/presentation/widget/ImagePickerUseCase.dart';
import 'package:swine_care/feature/homepage/presentation/widget/SymptomsChecker.dart';
import 'package:swine_care/feature/homepage/presentation/widget/SaveButton.dart';
import 'package:swine_care/colors/ArgieColors.dart';
import 'package:swine_care/colors/ArgieSizes.dart';
import 'package:swine_care/feature/homepage/presentation/widget/SymptomsChecklistLabelText.dart';
import 'package:swine_care/feature/homepage/presentation/widget/TakeClearPhotosTextLabel.dart';
import 'package:swine_care/feature/homepage/presentation/widget/UploadPigImagesTextLabel.dart';
import 'package:swine_care/data/api/Api.dart';
import 'package:swine_care/data/model/Prediction.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  final ImagePickerUseCase _imagePickerUseCase = ImagePickerUseCase();
  final Api _api = Api();

  // Image state variables
  File? selectedImageEars;
  File? selectedImageSkin;
  Uint8List? webImageEars;
  Uint8List? webImageSkin;

  // API results
  List<Prediction>? _earsPredictions;
  List<Prediction>? _skinPredictions;
  bool _isAnalyzing = false;

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

  // Keys and controllers
  final GlobalKey _symptomsSectionKey = GlobalKey();
  final GlobalKey _uploadSectionKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();

  // Image paths mapping
  final Map<String, String> _imagePaths = {
    'Ears': 'assets/images/pigparts/EarIconFinal.jpg',
    'Skin': 'assets/images/pigparts/SkinIconFinal.jpg',
  };

  // Debug strings for API responses
  String? _earsDebug;
  String? _skinDebug;

  Future<void> _analyzeImages() async {
    debugPrint('\n=== Starting Image Analysis ===');
    debugPrint('Ears image state: ${selectedImageEars != null ? 'Present' : 'Missing'}');
    debugPrint('Skin image state: ${selectedImageSkin != null ? 'Present' : 'Missing'}');

    if (selectedImageEars == null && selectedImageSkin == null) {
      debugPrint('ERROR: No images to analyze - both images are null');
      return;
    }

    setState(() {
      _isAnalyzing = true;
      _earsPredictions = null;
      _skinPredictions = null;
      _earsDebug = null;
      _skinDebug = null;
    });

    try {
      // Analyze ears image if present
      if (selectedImageEars != null) {
        debugPrint('\n=== Analyzing Ears Image ===');
        debugPrint('Ears image path: ${selectedImageEars!.path}');
        debugPrint('Ears image exists: ${selectedImageEars!.existsSync()}');
        debugPrint('Ears image size: ${await selectedImageEars!.length()} bytes');

        try {
          final predictions = await _api.sendImageToRoboflow(2, selectedImageEars!);
          debugPrint('Raw API Response for Ears: $predictions');

          if (predictions != null && predictions.isNotEmpty) {
            setState(() {
              _earsPredictions = predictions;
              double totalConfidence = 0;
              int validPredictions = 0;

              for (var prediction in predictions) {
                debugPrint('Ears Prediction: ${prediction.prediction} (${(prediction.confidence_score * 100).toStringAsFixed(1)}%)');
                if (prediction.confidence_score > 0) {
                  totalConfidence += prediction.confidence_score;
                  validPredictions++;
                }
              }

              double accuracy = validPredictions > 0 ? (totalConfidence / validPredictions) * 100 : 0;
              _earsDebug = predictions.map((p) =>
              '${p.prediction}: ${(p.confidence_score * 100).toStringAsFixed(1)}%'
              ).join(', ') + ' (Accuracy: ${accuracy.toStringAsFixed(1)}%)';
            });
            debugPrint('Ears Analysis Results: $_earsDebug');
          } else {
            setState(() {
              _earsPredictions = [];
              _earsDebug = 'No predictions found';
            });
            debugPrint('No predictions found in ears image');
          }
        } catch (e) {
          debugPrint('Error analyzing ears image: $e');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error analyzing ears image: $e')),
          );
          setState(() {
            _earsPredictions = [];
            _earsDebug = 'Error: Could not analyze image';
          });
        }
      }

      // Analyze skin image if present
      if (selectedImageSkin != null) {
        debugPrint('\n=== Analyzing Skin Image ===');
        debugPrint('Skin image path: ${selectedImageSkin!.path}');
        debugPrint('Skin image exists: ${selectedImageSkin!.existsSync()}');
        debugPrint('Skin image size: ${await selectedImageSkin!.length()} bytes');

        try {
          final predictions = await _api.sendImageToRoboflow(1, selectedImageSkin!);
          debugPrint('Raw API Response for Skin: $predictions');

          if (predictions != null && predictions.isNotEmpty) {
            setState(() {
              _skinPredictions = predictions;
              double totalConfidence = 0;
              int validPredictions = 0;

              for (var prediction in predictions) {
                debugPrint('Skin Prediction: ${prediction.prediction} (${(prediction.confidence_score * 100).toStringAsFixed(1)}%)');
                if (prediction.confidence_score > 0) {
                  totalConfidence += prediction.confidence_score;
                  validPredictions++;
                }
              }

              double accuracy = validPredictions > 0 ? (totalConfidence / validPredictions) * 100 : 0;
              _skinDebug = predictions.map((p) =>
              '${p.prediction}: ${(p.confidence_score * 100).toStringAsFixed(1)}%'
              ).join(', ') + ' (Accuracy: ${accuracy.toStringAsFixed(1)}%)';
            });
            debugPrint('Skin Analysis Results: $_skinDebug');
          } else {
            setState(() {
              _skinPredictions = [];
              _skinDebug = 'No predictions found';
            });
            debugPrint('No predictions found in skin image');
          }
        } catch (e) {
          debugPrint('Error analyzing skin image: $e');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error analyzing skin image: $e')),
          );
          setState(() {
            _skinPredictions = [];
            _skinDebug = 'Error: Could not analyze image';
          });
        }
      }

      _updateSymptomsBasedOnPredictions();
    } catch (e) {
      debugPrint('Error in image analysis: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error analyzing images: $e')),
      );
    } finally {
      setState(() => _isAnalyzing = false);
    }
  }

  void _updateSymptomsBasedOnPredictions() {
    if (_earsPredictions == null && _skinPredictions == null) return;

    setState(() {
      // Reset all symptoms
      _answers.updateAll((key, value) => false);

      // Check for ASF predictions in ears
      if (_earsPredictions != null && _earsPredictions!.isNotEmpty) {
        for (var prediction in _earsPredictions!) {
          if (prediction.prediction.toLowerCase().contains('asf')) {
            _answers["High temperature?"] = true;
            _answers["Loss of appetite?"] = true;
            break;
          }
        }
      }

      // Check for ASF predictions in skin
      if (_skinPredictions != null && _skinPredictions!.isNotEmpty) {
        for (var prediction in _skinPredictions!) {
          if (prediction.prediction.toLowerCase().contains('asf')) {
            _answers["Rapid breathing?"] = true;
            _answers["Clumsy movement?"] = true;
            break;
          }
        }
      }
    });
  }

  void _updateImage(String part, File? image, Uint8List? webImage) {
    debugPrint('\n=== Updating Image for $part ===');
    debugPrint('Image type: ${image != null ? 'File' : 'Web'}');
    if (image != null) {
      debugPrint('File path: ${image.path}');
      debugPrint('File exists: ${image.existsSync()}');
      debugPrint('File size: ${image.lengthSync()} bytes');
    }
    if (webImage != null) {
      debugPrint('Web image size: ${webImage.length} bytes');
    }

    setState(() {
      switch (part) {
        case 'Ears':
          selectedImageEars = image;
          webImageEars = webImage;
          _earsPredictions = null;
          _earsDebug = null;
          debugPrint('Updated Ears Image: ${image?.path ?? webImage?.length} bytes');
          break;
        case 'Skin':
          selectedImageSkin = image;
          webImageSkin = webImage;
          _skinPredictions = null;
          _skinDebug = null;
          debugPrint('Updated Skin Image: ${image?.path ?? webImage?.length} bytes');
          break;
      }
    });

    // Verify images are stored
    debugPrint('\n=== Verifying Image Storage ===');
    debugPrint('Ears image stored: ${selectedImageEars != null || webImageEars != null}');
    debugPrint('Skin image stored: ${selectedImageSkin != null || webImageSkin != null}');

    // Automatically analyze images when both ears and skin are uploaded
    if ((selectedImageEars != null || webImageEars != null) &&
        (selectedImageSkin != null || webImageSkin != null)) {
      debugPrint('\n=== Both images uploaded, triggering analysis ===');
      debugPrint('Ears image: ${selectedImageEars?.path ?? webImageEars?.length} bytes');
      debugPrint('Skin image: ${selectedImageSkin?.path ?? webImageSkin?.length} bytes');
      _analyzeImages();
    } else {
      debugPrint('\n=== Waiting for both images ===');
      debugPrint('Ears image: ${selectedImageEars != null || webImageEars != null ? 'Present' : 'Missing'}');
      debugPrint('Skin image: ${selectedImageSkin != null || webImageSkin != null ? 'Present' : 'Missing'}');
    }
  }

  Future<void> _pickImage(String part) async {
    try {
      debugPrint('\n=== Picking Image for $part ===');
      final result = await _imagePickerUseCase.pickImage(context);

      if (result != null) {
        debugPrint('Image picked successfully');
        if (kIsWeb) {
          final bytes = await result.readAsBytes();
          debugPrint('Web Image Selected for $part: ${bytes.length} bytes');
          setState(() {
            if (part == 'Ears') {
              webImageEars = bytes;
              selectedImageEars = null;
            } else if (part == 'Skin') {
              webImageSkin = bytes;
              selectedImageSkin = null;
            }
          });
          _updateImage(part, null, bytes);
        } else {
          final file = File(result.path);
          debugPrint('File Image Selected for $part: ${file.path}');
          debugPrint('File exists: ${await file.exists()}');
          debugPrint('File size: ${await file.length()} bytes');

          setState(() {
            if (part == 'Ears') {
              selectedImageEars = file;
              webImageEars = null;
            } else if (part == 'Skin') {
              selectedImageSkin = file;
              webImageSkin = null;
            }
          });

          _updateImage(part, file, null);
        }
      } else {
        debugPrint('No image selected for $part');
      }
    } catch (e) {
      debugPrint('Error uploading image for $part: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading image: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Image maps for the ImageGridView
    final Map<String, File?> selectedImages = {
      'Ears': selectedImageEars,
      'Skin': selectedImageSkin,
    };

    final Map<String, Uint8List?> webImages = {
      'Ears': webImageEars,
      'Skin': webImageSkin,
    };

    return Scaffold(
      backgroundColor: isDarkMode ? ArgieColors.dark : const Color(0xFFF8F9FA),
      body: Stack(
        children: [
          // Main Content
          SafeArea(
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                // Header
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
                        // Image upload section
                        Card(
                          key: _uploadSectionKey,
                          elevation: 2,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          color: isDarkMode ? Colors.grey.shade800 : Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                UploadPigImagesTextLabel(isDarkMode: isDarkMode),
                                const SizedBox(height: 16),
                                TakeClearPhotosTextLabel(isDarkMode: isDarkMode),
                                const SizedBox(height: 16),
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
                                if (_isAnalyzing)
                                  const Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: ArgieSizes.spaceBtwSections),
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
                                SymptomsChecklistLabelText(isDarkMode: isDarkMode),
                                const SizedBox(height: 16),
                                const AnswerAllQuestionsTextLabel(),
                                const SizedBox(height: 16),
                                SymptomsChecker(
                                  answers: _answers,
                                  onAnswerChanged: (question, answer) {
                                    debugPrint('Symptom updated: $question = $answer');
                                    setState(() {
                                      _answers[question] = answer;
                                    });
                                  },
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
                          },
                          webImages: {
                            'Ears': webImageEars,
                            'Skin': webImageSkin,
                          },
                          symptoms: _answers,
                          earsPredictions: _earsPredictions,
                          skinPredictions: _skinPredictions,
                        ),

                        // Debug Panel
                        if ((_earsDebug != null && _earsDebug!.isNotEmpty) || (_skinDebug != null && _skinDebug!.isNotEmpty))
                          Card(
                            color: Colors.black.withValues(alpha: 0.8),
                            margin: const EdgeInsets.only(top: 24),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('DEBUG: API Responses', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                  if (_earsDebug != null && _earsDebug!.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text('Ears: $_earsDebug', style: const TextStyle(color: Colors.white)),
                                    ),
                                  if (_skinDebug != null && _skinDebug!.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text('Skin: $_skinDebug', style: const TextStyle(color: Colors.white)),
                                    ),
                                ],
                              ),
                            ),
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