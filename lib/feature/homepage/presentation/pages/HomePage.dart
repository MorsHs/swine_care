import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swine_care/feature/homepage/presentation/widget/CameraGrid.dart';
import 'package:swine_care/feature/homepage/presentation/widget/CheckerButton.dart';
import 'package:swine_care/feature/homepage/presentation/widget/SaveButton.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.dehaze),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Home",
              style: GoogleFonts.concertOne(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Main Container
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
            SizedBox(height: 15),
            CheckerButton(),
            SizedBox(height: 20),
            SaveButton(),
            SizedBox(height: 2),
          ],


        ),
      ),
    );
  }
}