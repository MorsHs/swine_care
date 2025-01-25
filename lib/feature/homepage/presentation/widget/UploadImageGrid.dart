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
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      padding: const EdgeInsets.all(10),
      children: List.generate(
        containerTitles.length,
            (index) => _buildUploadContainer(containerTitles[index]),
      ),
    );
  }

  Widget _buildUploadContainer(String title) {
    return GestureDetector(
      onTap: (){

      },
      child: Container(
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
                size: 40,
                color: Colors.orange,
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
