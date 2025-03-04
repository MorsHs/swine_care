import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:swine_care/feature/advancedrawer/presentation/pages/AdvanceDrawer.dart';
import 'package:swine_care/feature/homepage/presentation/widget/CheckerButton.dart';
import 'package:swine_care/feature/homepage/presentation/widget/ImagePickerUseCase.dart';
import 'package:swine_care/feature/homepage/presentation/widget/ImageUploadButton.dart';
import 'package:swine_care/feature/homepage/presentation/widget/SaveButton.dart';
import 'package:swine_care/feature/homepage/presentation/widget/SymptomsChecker.dart';
import 'package:swine_care/feature/homepage/presentation/widget/TextLabel1.dart';
import 'package:swine_care/feature/homepage/presentation/widget/TextLabel2.dart';

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

  final _drawerController = AdvancedDrawerController();

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
              // Title
              TextLabel1(),
              const SizedBox(height: 20),

              // Instructions
              TextLabel2(),
              const SizedBox(height: 10),

              // Image Upload Section
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    ImageUploadButton(
                      label: 'Ears',
                      imagePath: 'assets/images/pigparts/earpig.png',
                      image: selectedImageEars,
                      onTap: () async {
                        final image = await _imagePickerUseCase.pickImage(context);
                        setState(() {
                          selectedImageEars = image;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    ImageUploadButton(
                      label: 'Skin',
                      imagePath: 'assets/images/pigparts/pigskin.jpg',
                      image: selectedImageSkin,
                      onTap: () async {
                        final image = await _imagePickerUseCase.pickImage(context);
                        setState(() {
                          selectedImageSkin = image;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    ImageUploadButton(
                      label: 'Legs',
                      imagePath: 'assets/images/pigparts/piglegs.png',
                      image: selectedImageLegs,
                      onTap: () async {
                        final image = await _imagePickerUseCase.pickImage(context);
                        setState(() {
                          selectedImageLegs = image;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    ImageUploadButton(
                      label: 'Nose',
                      imagePath: 'assets/images/pigparts/pignose.jpeg',
                      image: selectedImageNose,
                      onTap: () async {
                        final image = await _imagePickerUseCase.pickImage(context);
                        setState(() {
                          selectedImageNose = image;
                        });
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Detect ASF Button
              const CheckerButton(),

              const SizedBox(height: 10),

              // Symptoms Checker
              const SymptomsChecker(),

              const SizedBox(height: 50),

              // Save Button
              const SaveButton(),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}


