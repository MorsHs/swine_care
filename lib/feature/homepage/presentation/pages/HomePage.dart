import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swine_care/feature/homepage/presentation/widget/CameraGrid.dart';
import 'package:swine_care/feature/homepage/presentation/widget/CheckerButton.dart';
import 'package:swine_care/feature/homepage/presentation/widget/HomeLabel.dart';
import 'package:swine_care/feature/homepage/presentation/widget/SaveButton.dart';
import 'package:swine_care/global_widget/AdvanceDrawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ImagePicker picker = ImagePicker();
  File? selectedImageEars;
  File? selectedImageSkin;
  File? selectedImageLegs;
  File? selectedImageNose;

  Future<void> getImage(ImageSource source, Function(File) setImage) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        setImage(File(pickedFile.path));
      });
    } else {
      print("No image selected.");
    }
  }

  final _drawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    return DrawerMenu(
      drawerController: _drawerController,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const HomeLabel(),
            const SizedBox(height: 16),

            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: CameraGrid(
                selectedImageEars: selectedImageEars,
                selectedImageSkin: selectedImageSkin,
                selectedImageLegs: selectedImageLegs,
                selectedImageNose: selectedImageNose,
                onImageEarsSelected: () async {
                  await getImage(ImageSource.gallery, (image) {
                    setState(() {
                      selectedImageEars = image;
                    });
                  });
                },
                onImageSkinSelected: () async {
                  await getImage(ImageSource.gallery, (image) {
                    setState(() {
                      selectedImageSkin = image;
                    });
                  });
                },
                onImageLegsSelected: () async {
                  await getImage(ImageSource.gallery, (image) {
                    setState(() {
                      selectedImageLegs = image;
                    });
                  });
                },
                onImageNoseSelected: () async {
                  await getImage(ImageSource.gallery, (image) {
                    setState(() {
                      selectedImageNose = image;
                    });
                  });
                },
              ),
            ),
            const SizedBox(height: 15),
            const CheckerButton(),
            const SizedBox(height: 50),
            const SaveButton(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
