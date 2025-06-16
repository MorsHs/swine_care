import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  final String apiKey = "luUCWZECagqz6ebDZ2FU";
  final String workflowUrl = "https://serverless.roboflow.com/infer/workflows/morshs-bfrdz/small-object-detection-sahi-4";
  final String imageUrl = "https://raw.githubusercontent.com/ultralytics/yolov5/master/data/images/bus.jpg";

  String result = "";

  Future<void> sendImageToRoboflow() async {
    final uri = Uri.parse(workflowUrl);

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        "api_key": apiKey,
        "inputs": {
          "image": {
            "type": "url",
            "value": imageUrl,
          }
        }
      }),
    );


  }
}