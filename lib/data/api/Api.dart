import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart' show Uint8List, debugPrint;
import 'package:http/http.dart' as http;
import 'dart:math';

import '../model/Prediction.dart';

class Api {
  final String apiKey = "luUCWZECagqz6ebDZ2FU";
  String workflowUrl = "";
  /*  final String imageUrl =
      "https://raw.githubusercontent.com/ultralytics/yolov5/master/data/images/bus.jpg";*/

  Future<List<Prediction>> sendImageToRoboflow(int part, {File? imageFile, Uint8List? webImage}) async {
    if (imageFile == null && webImage == null) {
      throw Exception('No image provided for analysis');
    }

    debugPrint('\n=== Sending Image to Roboflow ===');
    debugPrint('Part: ${part == 1 ? 'Body' : 'Ears'}');
    if (imageFile != null) {
      debugPrint('Image path: ${imageFile.path}');
      debugPrint('Image exists: ${imageFile.existsSync()}');
      debugPrint('Image size: ${await imageFile.length()} bytes');
      if (await imageFile.length() > 5 * 1024 * 1024) {
        throw Exception('Image size exceeds 5MB limit');
      }
    } else {
      debugPrint('Web image size: ${webImage!.length} bytes');
      if (webImage.length > 5 * 1024 * 1024) {
        throw Exception('Web image size exceeds 5MB limit');
      }
    }

    // Select workflow URL
    if (part == 1) {
      workflowUrl = "https://serverless.roboflow.com/infer/workflows/morshs-bfrdz/small-object-detection-sahi-6";
    } else {
      workflowUrl = "https://serverless.roboflow.com/infer/workflows/morshs-bfrdz/small-object-detection-sahi-4";
    }
    debugPrint('Workflow URL: $workflowUrl');

    // Read and encode image
    final base64image = imageFile != null
        ? base64Encode(await imageFile.readAsBytes())
        : base64Encode(webImage!);
    debugPrint('Base64 image length: ${base64image.length}');
    debugPrint('Base64 image snippet: ${base64image.substring(0, min(100, base64image.length))}...');

    // Prepare request
    final uri = Uri.parse(workflowUrl);
    final requestBody = json.encode({
      "api_key": apiKey,
      "inputs": {
        "image": {
          "type": "base64",
          "value": base64image,
        }
      }
    });
    debugPrint('Request body size: ${requestBody.length} bytes');

    // Send request
    try {
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: requestBody,
      );

      debugPrint('API Response Status: ${response.statusCode}');
      debugPrint('API Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        debugPrint('API Response Parsed: $data');

        // Check if predictions exist
        if (data['outputs'] != null &&
            data['outputs'].isNotEmpty &&
            data['outputs'][0]['predictions'] != null &&
            data['outputs'][0]['predictions']['predictions'] != null) {
          final List<dynamic> predictionJsonList = data['outputs'][0]['predictions']['predictions'];
          final List<Prediction> predictions =
          predictionJsonList.map((json) => Prediction.fromJSON(json)).toList();
          debugPrint('Predictions: ${predictions.map((p) => p.prediction).toList()}');
          return predictions;
        } else {
          debugPrint('No predictions found in response');
          return [];
        }
      } else {
        debugPrint('API Error: ${response.body}');
        throw Exception('Error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      debugPrint('API Request Failed: $e');
      throw Exception('Failed to connect to Roboflow API: $e');
    }
  }
}