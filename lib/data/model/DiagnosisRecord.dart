import 'package:swine_care/data/model/Prediction.dart';

class DiagnosisRecord {
  final String id;
  final String pigId;
  final String date;
  final String diagnosis;
  final String status;
  final double finalScore;
  final Map<String, bool> symptoms;
  final List<Prediction> earsPredictions;
  final List<Prediction> skinPredictions;
  final List<String> recommendations;
  final String userId;

  DiagnosisRecord({
    required this.id,
    required this.pigId,
    required this.date,
    required this.diagnosis,
    required this.status,
    required this.finalScore,
    required this.symptoms,
    required this.earsPredictions,
    required this.skinPredictions,
    required this.recommendations,
    required this.userId,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'pigId': pigId,
      'date': date,
      'diagnosis': diagnosis,
      'status': status,
      'finalScore': finalScore,
      'symptoms': symptoms,
      'earsPredictions': earsPredictions.map((p) => p.toFirestore()).toList(),
      'skinPredictions': skinPredictions.map((p) => p.toFirestore()).toList(),
      'recommendations': recommendations,
      'userId': userId,
    };
  }

  factory DiagnosisRecord.fromFirestore(Map<String, dynamic> firestore) {
    return DiagnosisRecord(
      id: firestore['id'] as String,
      pigId: firestore['pigId'] as String,
      date: firestore['date'] as String,
      diagnosis: firestore['diagnosis'] as String,
      status: firestore['status'] as String,
      finalScore: (firestore['finalScore'] as num).toDouble(),
      symptoms: Map<String, bool>.from(firestore['symptoms']),
      earsPredictions: (firestore['earsPredictions'] as List)
          .map((p) => Prediction.fromFirestore(p as Map<String, dynamic>))
          .toList(),
      skinPredictions: (firestore['skinPredictions'] as List)
          .map((p) => Prediction.fromFirestore(p as Map<String, dynamic>))
          .toList(),
      recommendations: List<String>.from(firestore['recommendations']),
      userId: firestore['userId'] as String,
    );
  }
}