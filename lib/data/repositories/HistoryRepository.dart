import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:swine_care/data/model/Prediction.dart';
import 'package:swine_care/feature/historypage/presentation/widgets/DiagnosisRecord.dart';

class HistoryRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get the collection of history records for the current user
  CollectionReference<DiagnosisRecord> _getHistoryCollection() {
    final userId = _firebaseAuth.currentUser?.uid;
    if (userId == null) {
      throw Exception("User is not logged in.");
    }
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('history')
        .withConverter<DiagnosisRecord>(
      fromFirestore: (snapshot, _) => DiagnosisRecord.fromFirestore(snapshot.data()!),
      toFirestore: (record, _) => record.toFirestore(),
    );
  }

  // Get a real-time stream of records for the current user
  Stream<List<DiagnosisRecord>> getRecordsStream() {
    return _getHistoryCollection()
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  // Get all records for the current user
  Future<List<DiagnosisRecord>> getAllRecords() async {
    final snapshot = await _getHistoryCollection().orderBy('date', descending: true).get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  // Add a new record
  Future<void> addRecord(DiagnosisRecord record) async {
    await _getHistoryCollection().doc(record.id).set(record);
  }

  // Delete a record
  Future<void> deleteRecord(String id) async {
    await _getHistoryCollection().doc(id).delete();
  }

  // Create a new record from diagnostic data
  DiagnosisRecord createRecord({
    required String pigId,
    required String diagnosis,
    required double finalScore,
    required Map<String, bool> symptoms,
    required List<Prediction> earsPredictions,
    required List<Prediction> skinPredictions,
    required List<String> recommendations,
  }) {
    final String id = DateTime.now().millisecondsSinceEpoch.toString();
    final String date = DateTime.now().toIso8601String().split('T')[0];
    final String status = diagnosis == 'Low Risk' ? 'Resolved' : 'Under Observation';
    final String? userId = _firebaseAuth.currentUser?.uid;

    if (userId == null) {
      throw Exception("Cannot create record without a logged-in user.");
    }

    return DiagnosisRecord(
      id: id,
      pigId: pigId,
      date: date,
      diagnosis: diagnosis,
      status: status,
      finalScore: finalScore,
      symptoms: symptoms,
      earsPredictions: earsPredictions,
      skinPredictions: skinPredictions,
      recommendations: recommendations,
      userId: userId,
    );
  }

  // Get record by ID
  Future<DiagnosisRecord?> getRecordById(String id) async {
    final doc = await _getHistoryCollection().doc(id).get();
    return doc.data();
  }

  // Update record status
  Future<void> updateRecordStatus(String id, String newStatus) async {
    await _getHistoryCollection().doc(id).update({'status': newStatus});
  }

  // Get records by status
  List<DiagnosisRecord> getRecordsByStatus(String status) {
    throw UnimplementedError();
  }

  // Get records by diagnosis
  List<DiagnosisRecord> getRecordsByDiagnosis(String diagnosis) {
    throw UnimplementedError();
  }

  // Clear all records (for testing)
  void clearAllRecords() {
    throw UnimplementedError();
  }
}