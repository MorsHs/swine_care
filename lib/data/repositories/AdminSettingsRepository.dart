import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swine_care/data/model/AdminSettings.dart';

class AdminSettingsRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName = 'admin_settings';

  Future<AdminSettings> getAdminSettings() async {
    try {
      final doc = await _firestore.collection(_collectionName).doc('current').get();
      if (doc.exists && doc.data() != null) {
        return AdminSettings.fromMap(doc.data()!);
      } else {
        final defaultSettings = AdminSettings.defaults();
        await saveAdminSettings(defaultSettings);
        return defaultSettings;
      }
    } catch (e) {
      print('Error getting admin settings: $e');
      return AdminSettings.defaults();
    }
  }

  Future<void> saveAdminSettings(AdminSettings settings) async {
    try {
      await _firestore.collection(_collectionName).doc('current').set(settings.toMap());
      await _firestore.collection(_collectionName).doc('history').collection('changes').add({
        ...settings.toMap(),
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error saving admin settings: $e');
      throw Exception('Failed to save admin settings: $e');
    }
  }

  Future<void> updateAdminSettings({
    List<RiskLabel>? riskLabels,
    List<RiskThreshold>? riskThresholds,
    double? earsWeight,
    double? skinWeight,
    double? symptomsWeight,
    List<SymptomChecklist>? symptomsChecklist,
  }) async {
    try {
      final currentSettings = await getAdminSettings();
      final updatedSettings = currentSettings.copyWith(
        riskLabels: riskLabels,
        riskThresholds: riskThresholds,
        earsWeight: earsWeight,
        skinWeight: skinWeight,
        symptomsWeight: symptomsWeight,
        symptomsChecklist: symptomsChecklist,
      );
      await saveAdminSettings(updatedSettings);
    } catch (e) {
      print('Error updating admin settings: $e');
      throw Exception('Failed to update admin settings: $e');
    }
  }

  // Backward compatibility method
  Future<void> updateAdminSettingsLegacy({
    double? highRiskThreshold,
    double? mediumRiskThreshold,
    double? lowRiskThreshold,
    String? highRiskLabel,
    String? mediumRiskLabel,
    String? lowRiskLabel,
    double? earsWeight,
    double? skinWeight,
    double? symptomsWeight,
  }) async {
    try {
      final currentSettings = await getAdminSettings();
      
      // Update risk labels if provided
      List<RiskLabel> updatedRiskLabels = List.from(currentSettings.riskLabels);
      if (highRiskLabel != null) {
        final index = updatedRiskLabels.indexWhere((l) => l.label.toLowerCase().contains('high'));
        if (index != -1) {
          updatedRiskLabels[index] = RiskLabel(label: highRiskLabel);
        }
      }
      if (mediumRiskLabel != null) {
        final index = updatedRiskLabels.indexWhere((l) => l.label.toLowerCase().contains('medium'));
        if (index != -1) {
          updatedRiskLabels[index] = RiskLabel(label: mediumRiskLabel);
        }
      }
      if (lowRiskLabel != null) {
        final index = updatedRiskLabels.indexWhere((l) => l.label.toLowerCase().contains('low'));
        if (index != -1) {
          updatedRiskLabels[index] = RiskLabel(label: lowRiskLabel);
        }
      }

      // Update risk thresholds if provided
      List<RiskThreshold> updatedRiskThresholds = List.from(currentSettings.riskThresholds);
      if (highRiskThreshold != null) {
        final index = updatedRiskThresholds.indexWhere((t) => t.label.toLowerCase().contains('high'));
        if (index != -1) {
          updatedRiskThresholds[index] = RiskThreshold(label: updatedRiskThresholds[index].label, value: highRiskThreshold);
        }
      }
      if (mediumRiskThreshold != null) {
        final index = updatedRiskThresholds.indexWhere((t) => t.label.toLowerCase().contains('medium'));
        if (index != -1) {
          updatedRiskThresholds[index] = RiskThreshold(label: updatedRiskThresholds[index].label, value: mediumRiskThreshold);
        }
      }
      if (lowRiskThreshold != null) {
        final index = updatedRiskThresholds.indexWhere((t) => t.label.toLowerCase().contains('low'));
        if (index != -1) {
          updatedRiskThresholds[index] = RiskThreshold(label: updatedRiskThresholds[index].label, value: lowRiskThreshold);
        }
      }

      final updatedSettings = currentSettings.copyWith(
        riskLabels: updatedRiskLabels,
        riskThresholds: updatedRiskThresholds,
        earsWeight: earsWeight,
        skinWeight: skinWeight,
        symptomsWeight: symptomsWeight,
      );
      await saveAdminSettings(updatedSettings);
    } catch (e) {
      print('Error updating admin settings: $e');
      throw Exception('Failed to update admin settings: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getSettingsHistory() async {
    try {
      final querySnapshot = await _firestore.collection(_collectionName).doc('history').collection('changes').orderBy('timestamp', descending: true).limit(10).get();
      return querySnapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print('Error getting settings history: $e');
      return [];
    }
  }

  Future<void> resetToDefaults() async {
    try {
      final defaultSettings = AdminSettings.defaults();
      await saveAdminSettings(defaultSettings);
    } catch (e) {
      print('Error resetting to defaults: $e');
      throw Exception('Failed to reset to defaults: $e');
    }
  }
} 