import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swine_care/feature/homepage/presentation/widget/CameraFloatingButton.dart';
import 'package:swine_care/feature/homepage/presentation/widget/CheckerButton.dart';
import 'package:swine_care/feature/homepage/presentation/widget/SaveButton.dart';
import 'package:swine_care/feature/homepage/presentation/widget/UploadImageGrid.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(
              child: IconButton(onPressed: (){},
                icon: const Icon(
                    Icons.dehaze
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.teal,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Home",
              style: GoogleFonts.concertOne(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                     Expanded(
                         child:UploadImageGrid()
                     ),
                      CheckerButton(),
                      SizedBox(height: 30)
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.bottomCenter,
              child: CameraFloatingButton(),
            ),
            const SizedBox(height: 20),
            const SaveButton(),
          ],
        ),
      ),
    );
  }
}
