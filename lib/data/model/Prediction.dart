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
  // Convert Prediction object to a Map for Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'width': width,
      'height': height,
      'x': x,
      'y': y,
      'confidence_score': confidence_score,
      'class_id': class_id,
      'prediction': prediction,
      'detection_id': detection_id,
      'parent_id': parent_id,
    };
  }
  // Create a Prediction object from a Firestore document
  factory Prediction.fromFirestore(Map<String, dynamic> firestore) {
    return Prediction(
      width: (firestore['width'] as num).toDouble(),
      height: (firestore['height'] as num).toDouble(),
      x: (firestore['x'] as num).toDouble(),
      y: (firestore['y'] as num).toDouble(),
      confidence_score: (firestore['confidence_score'] as num).toDouble(),
      class_id: (firestore['class_id'] as num).toDouble(),
      prediction: firestore['prediction'] as String,
      detection_id: firestore['detection_id'] as String,
      parent_id: firestore['parent_id'] as String,
    );
  }

  @override
  String toString() {
    return 'Prediction(prediction: $prediction, confidence: ${(confidence_score * 100).toStringAsFixed(1)}%, location: ($x, $y), size: ${width}x$height)';
  }

}
