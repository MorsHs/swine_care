import 'package:flutter/material.dart';

class UploadImageGrid extends StatelessWidget {
  const UploadImageGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Titles for each container
    final List<String> containerTitles = [
      'Upload your image here,'
          ' pig ears',
      'Upload your image here,'
          ' pig skin',
      'Upload your image here, '
          'pig legs',
      'Upload your image here,'
          ' pig nose',
    ];

    return GridView.count(
      crossAxisCount: 2, // Two containers per row
      crossAxisSpacing: 10, // Horizontal spacing between containers
      mainAxisSpacing: 10, // Vertical spacing between containers
      padding: const EdgeInsets.all(10),
      children: List.generate(
        containerTitles.length, // Create one container for each title
            (index) => _buildUploadContainer(containerTitles[index]),
      ),
    );
  }

  Widget _buildUploadContainer(String title) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orangeAccent.withOpacity(0.2),
        border: Border.all(color: Colors.orange, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.cloud_upload,
              size: 40, // Increased size for better visibility
              color: Colors.orange,
            ),
            const SizedBox(height: 10),
            Text(
              title, // Display the title for each container
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
