import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../model/Prediction.dart';

class Api {

  //hehehhehe wlay backend
  final String apiKey = "luUCWZECagqz6ebDZ2FU";
  String workflowUrl = "";
/*  final String imageUrl =
      "https://raw.githubusercontent.com/ultralytics/yolov5/master/data/images/bus.jpg";*/

  Future<List<Prediction>> sendImageToRoboflow(int part,File imageFile) async {
// 1 is body 2 is ears

  if(part == 1){ // BODY NI
    workflowUrl = "https://serverless.roboflow.com/infer/workflows/morshs-bfrdz/small-object-detection-sahi-6";
  }
  else { // EARS NI
    workflowUrl = "https://serverless.roboflow.com/infer/workflows/morshs-bfrdz/small-object-detection-sahi-4";
  }

    final bytes = await imageFile.readAsBytes();
    final base64image = base64Encode(bytes);

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
            "type": "base64",
            "value": base64image,
          }
        }
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> predictionJsonList =
          data['outputs'][0]['predictions']['predictions'];
      final List<Prediction> predictions =
          predictionJsonList.map((json) => Prediction.fromJSON(json)).toList();
      return predictions;
      // void testing purposes
      /*   print(predictions)
      for (var prediction in predictions) {
        print(prediction.prediction);
      }*/
    } else {
      throw ('Error : ${response.body}');
    }
  }
}
