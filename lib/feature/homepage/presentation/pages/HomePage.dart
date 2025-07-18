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
import 'package:cloud_firestore/cloud_firestore.dart';

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
  List<Map<String, String>> _symptomsChecklist = [];
  Map<String, bool?> _answers = {};

  @override
  void initState() {
    super.initState();
    _fetchSymptomsChecklist();
  }

  Future<void> _fetchSymptomsChecklist() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('admin_settings')
          .doc('current')
          .get();
      final data = doc.data();
      if (data != null && data['symptomsChecklist'] != null && (data['symptomsChecklist'] as List).isNotEmpty) {
        final List<dynamic> checklist = data['symptomsChecklist'];
        setState(() {
          _symptomsChecklist = checklist
              .map<Map<String, String>>((item) => {
                    'question': item['question'] as String,
                    'description': item['description'] as String,
                  })
              .toList();
          _answers = { for (var s in _symptomsChecklist) s['question']!: null };
        });
      } else {
        // No checklist in Firestore, use default and write it to Firestore
        await FirebaseFirestore.instance
            .collection('admin_settings')
            .doc('current')
            .set({'symptomsChecklist': defaultSymptomsChecklist}, SetOptions(merge: true));
        setState(() {
          _symptomsChecklist = List<Map<String, String>>.from(defaultSymptomsChecklist);
          _answers = { for (var s in _symptomsChecklist) s['question']!: null };
        });
      }
    } catch (e) {
      print('Failed to fetch symptoms checklist: $e');
      // Fallback to default if error
      setState(() {
        _symptomsChecklist = List<Map<String, String>>.from(defaultSymptomsChecklist);
        _answers = { for (var s in _symptomsChecklist) s['question']!: null };
      });
    }
  }

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

  // Debuggg for API responses kay wa nako kasabot
  String? _earsDebug;
  String? _skinDebug;

  Future<void> _analyzeImages() async {
    debugPrint('\n=== Starting Image Analysis ===');
    debugPrint('Ears image state: ${selectedImageEars != null ? 'Present (${selectedImageEars!.path})' : 'Missing'}');
    debugPrint('Skin image state: ${selectedImageSkin != null ? 'Present (${selectedImageSkin!.path})' : 'Missing'}');
    debugPrint('Web Ears image state: ${webImageEars != null ? 'Present (${webImageEars!.length} bytes)' : 'Missing'}');
    debugPrint('Web Skin image state: ${webImageSkin != null ? 'Present (${webImageSkin!.length} bytes)' : 'Missing'}');

    if ((selectedImageEars == null && webImageEars == null) && (selectedImageSkin == null && webImageSkin == null)) {
      debugPrint('ERROR: No images to analyze - both images are null');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No images selected for analysis')),
      );
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
      if (selectedImageEars != null || webImageEars != null) {
        debugPrint('\n=== Analyzing Ears Image ===');
        try {
          final predictions = await _api.sendImageToRoboflow(
            2,
            imageFile: selectedImageEars,
            webImage: webImageEars,
          );
          debugPrint('Raw API Response for Ears: $predictions');

          if (predictions.isNotEmpty) {
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
              _earsDebug = predictions
                  .map((p) => '${p.prediction}: ${(p.confidence_score * 100).toStringAsFixed(1)}%')
                  .join(', ') +
                  ' (Accuracy: ${accuracy.toStringAsFixed(1)}%)';
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
      if (selectedImageSkin != null || webImageSkin != null) {
        debugPrint('\n=== Analyzing Skin Image ===');
        try {
          final predictions = await _api.sendImageToRoboflow(
            1,
            imageFile: selectedImageSkin,
            webImage: webImageSkin,
          );
          debugPrint('Raw API Response for Skin: $predictions');

          if (predictions.isNotEmpty) {
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
              _skinDebug = predictions
                  .map((p) => '${p.prediction}: ${(p.confidence_score * 100).toStringAsFixed(1)}%')
                  .join(', ') +
                  ' (Accuracy: ${accuracy.toStringAsFixed(1)}%)';
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
    } catch (e) {
      debugPrint('Error in image analysis: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to analyze images. Please check your internet connection.'),
          action: SnackBarAction(
            label: 'Retry',
            onPressed: () => _analyzeImages(),
          ),
        ),
      );
    } finally {
      setState(() => _isAnalyzing = false);
    }
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
          debugPrint('After setState - Ears Image: ${selectedImageEars?.path ?? webImageEars?.length}');
          break;
        case 'Skin':
          selectedImageSkin = image;
          webImageSkin = webImage;
          _skinPredictions = null;
          _skinDebug = null;
          debugPrint('Updated Skin Image: ${image?.path ?? webImage?.length} bytes');
          debugPrint('After setState - Skin Image: ${selectedImageSkin?.path ?? webImageSkin?.length}');
          break;
      }
    });

    // Verify images are stored
    debugPrint('\n=== Verifying Image Storage ===');
    debugPrint('Ears image stored: ${selectedImageEars != null || webImageEars != null}');
    debugPrint('Skin image stored: ${selectedImageSkin != null || webImageSkin != null}');

    // Delay analysis to ensure state is updated
    if ((selectedImageEars != null || webImageEars != null) &&
        (selectedImageSkin != null || webImageSkin != null)) {
      debugPrint('\n=== Both images uploaded, triggering analysis after delay ===');
      debugPrint('Ears image: ${selectedImageEars?.path ?? webImageEars?.length} bytes');
      debugPrint('Skin image: ${selectedImageSkin?.path ?? webImageSkin?.length} bytes');
      Future.delayed(Duration(milliseconds: 100), () {
        if (mounted) _analyzeImages();
      });
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

    if (_symptomsChecklist.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

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
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CircularProgressIndicator(),
                                          Text('It takes 4 to 8 seconds to diagnose these images.',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
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
                                  questionsWithDescriptions: _symptomsChecklist,
                                  answers: _answers,
                                  onChanged: (question, value) {
                                    setState(() {
                                      _answers[question] = value;
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
                          symptoms: _answers,
                          uploadedImages: {
                            'Ears': selectedImageEars,
                            'Skin': selectedImageSkin,
                          },
                          webImages: {
                            'Ears': webImageEars,
                            'Skin': webImageSkin,
                          },
                          earsPredictions: _earsPredictions,
                          skinPredictions: _skinPredictions,
                          enabled: !_isAnalyzing,
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

const List<Map<String, String>> defaultSymptomsChecklist = [
  {
    "question": "High fever?",
    "description": "The pig has a high fever, with a body temperature ranging from 40°C to 42°C, which may indicate a severe infection or systemic illness."
  },
  {
    "question": "Milder fever?",
    "description": "The pig is experiencing a fluctuating mild fever, where the temperature rises and falls, potentially signaling an early or infection."
  },
  {
    "question": "Slight fever?",
    "description": "The pig has a slight fever, with body temperatures ranging between 37.5°C and 39°C, which could be a sign of a mild infection or stress response."
  },
  {
    "question": "Extreme tiredness?",
    "description": "The pig shows signs of extreme fatigue, which could be associated with systemic weakness."
  },
  {
    "question": "Loss of appetite?",
    "description": "The pig is refusing to eat, a common symptom that may indicate pain, illness, or digestive discomfort."
  },
  {
    "question": "Difficulty of breathing?",
    "description": "The pig is having trouble breathing, which may suggest respiratory tract infections, lung issues, or high fever."
  },
  {
    "question": "Difficulty on walking?",
    "description": "The pig has difficulty walking, which may result from joint pain, muscle weakness, neurological problems, or respiratory distress."
  },
  {
    "question": "Bloody feces?",
    "description": "The presence of blood in the pig's feces is a serious symptom that may point to internal bleeding, intestinal infections, or parasitic infestations."
  },
];