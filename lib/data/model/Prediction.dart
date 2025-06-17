class Prediction {
  final double width;
  final double height;
  final double x;
  final double y;
  final double confidence_score;
  final double class_id;
  final String prediction;
  final String detection_id;
  final String parent_id;

  Prediction({
    required this.width,
    required this.height,
    required this.x,
    required this.y,
    required this.confidence_score,
    required this.class_id,
    required this.prediction,
    required this.detection_id,
    required this.parent_id,
  });

  factory Prediction.fromJSON(Map<String, dynamic> prediction) {
    return Prediction(
        width: prediction['width'],
        height: prediction['height'],
        x: prediction['x'],
        y: prediction['y'],
        confidence_score: prediction['confidence'],
        class_id: prediction['class_id'],
        prediction: prediction['class'],
        detection_id: prediction['detection_id'],
        parent_id: prediction['parent_id']);
  }
}
