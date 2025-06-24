import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:swine_care/feature/homepage/controller/image-loc-controller.dart';
import 'package:swine_care/data/model/Prediction.dart';

class DatabaseImageSender {

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> saveDiagnosticData({
    File? earsImage,
    File? skinImage,
    Uint8List? webEarsImage,
    Uint8List? webSkinImage,
    required List<Prediction>? earsPredictions,
    required List<Prediction>? skinPredictions,
    required String diagnosis,
    required double finalScore,
    required String pigId,
  }) async {
    try {
      Position? currentPosition;
      try {
        currentPosition = await ImageLocController().determinePosition();
      } catch (e) {
        currentPosition = null;
      }

      String? base64Ears;
      if (earsImage != null) {
        base64Ears = base64Encode(await earsImage.readAsBytes());
      } else if (webEarsImage != null) {
        base64Ears = base64Encode(webEarsImage);
      }

      String? base64Skin;
      if (skinImage != null) {
        base64Skin = base64Encode(await skinImage.readAsBytes());
      } else if (webSkinImage != null) {
        base64Skin = base64Encode(webSkinImage);
      }

      final diagnosticData = {
        'pigId': pigId,
        'riskLevel': _getRiskLevel(diagnosis),
        'ears': base64Ears,
        'skin': base64Skin,
        'earsPredictions': earsPredictions?.map((p) => p.toFirestore()).toList() ?? [],
        'skinPredictions': skinPredictions?.map((p) => p.toFirestore()).toList() ?? [],
        'lat': currentPosition?.latitude,
        'long': currentPosition?.longitude,
        'timestamp': FieldValue.serverTimestamp(),
        'date': DateTime.now().toIso8601String(),
        'finalScore': finalScore,
        'isActive': true,
      };

      await db.collection('users').doc(auth.currentUser!.uid).collection('results').doc().set(diagnosticData);
    } catch (e) {
      throw Exception('Failed to save diagnostic data: ${e.toString()}');
    }
  }

  Future<void> getImage(File ears, File skin) async {
    final base64Skin = base64Encode(await skin.readAsBytes());
    final base64Ears = base64Encode(await ears.readAsBytes());

    Position? currentPosition;

    try{
      currentPosition = await ImageLocController().determinePosition();
    }
    catch(e){
      currentPosition = null;
    }

    if(currentPosition != null) {
      await db.collection('users').doc(auth.currentUser!.uid).collection('results').doc().set({
        'ears' : base64Ears,
        'skin' : base64Skin,
        'lat' : currentPosition.latitude,
        'long' : currentPosition.longitude,
        'timestamp': FieldValue.serverTimestamp(),
        'date': DateTime.now().toIso8601String(),
      });
    }
    else{
      throw('Location not found');
    }
  }

  String _getRiskLevel(String diagnosis) {
    switch (diagnosis.toLowerCase()) {
      case 'highly risk':
        return 'HIGH';
      case 'medium risk':
        return 'MEDIUM';
      case 'low risk':
        return 'LOW';
      default:
        return 'UNKNOWN';
    }
  }

  Future<List<Map<String, dynamic>>> getUserDiagnosticRecords() async {
    try {
      final userId = auth.currentUser?.uid;
      if (userId == null) {
        throw Exception("User is not logged in.");
      }

      final snapshot = await db
          .collection('users')
          .doc(userId)
          .collection('results')
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      throw Exception('Failed to fetch user diagnostic records');
    }
  }

  Future<List<Map<String, dynamic>>> getAllDiagnosticRecords() async {
    try {
      final snapshot = await db
          .collectionGroup('results')
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      throw Exception('Failed to fetch all diagnostic records');
    }
  }
}