import 'package:swine_care/data/model/AdminSettings.dart';
import 'package:swine_care/data/repositories/AdminSettingsRepository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminSettingsService {
  static final AdminSettingsService _instance = AdminSettingsService._internal();
  factory AdminSettingsService() => _instance;
  AdminSettingsService._internal();

  final AdminSettingsRepository _repository = AdminSettingsRepository();
  AdminSettings? _cachedSettings;
  bool _isInitialized = false;

  Future<void> initialize() async {
    if (!_isInitialized) {
      try {
        _cachedSettings = await _repository.getAdminSettings();
        _isInitialized = true;
      } catch (e) {
        print('Error initializing AdminSettingsService: $e');
        _cachedSettings = AdminSettings.defaults();
        _isInitialized = true;
      }
    }
  }

  Future<AdminSettings> getCurrentSettings() async {
    if (!_isInitialized) {
      await initialize();
    }
    return _cachedSettings ?? AdminSettings.defaults();
  }

  Future<AdminSettings> refreshSettings() async {
    try {
      _cachedSettings = await _repository.getAdminSettings();
      return _cachedSettings!;
    } catch (e) {
      print('Error refreshing admin settings: $e');
      return _cachedSettings ?? AdminSettings.defaults();
    }
  }

  Future<void> updateSettings({
    List<RiskLabel>? riskLabels,
    List<RiskThreshold>? riskThresholds,
    double? earsWeight,
    double? skinWeight,
    double? symptomsWeight,
    List<SymptomChecklist>? symptomsChecklist,
  }) async {
    try {
      await _repository.updateAdminSettings(
        riskLabels: riskLabels,
        riskThresholds: riskThresholds,
        earsWeight: earsWeight,
        skinWeight: skinWeight,
        symptomsWeight: symptomsWeight,
        symptomsChecklist: symptomsChecklist,
      );
      await refreshSettings();
    } catch (e) {
      print('Error updating admin settings: $e');
      throw e;
    }
  }

  // Backward compatibility method
  Future<void> updateSettingsLegacy({
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
      final currentSettings = await getCurrentSettings();
      
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

      await updateSettings(
        riskLabels: updatedRiskLabels,
        riskThresholds: updatedRiskThresholds,
        earsWeight: earsWeight,
        skinWeight: skinWeight,
        symptomsWeight: symptomsWeight,
      );
    } catch (e) {
      print('Error updating admin settings: $e');
      throw e;
    }
  }

  Future<String> getRiskLevel(double score) async {
    final settings = await getCurrentSettings();
    return settings.getRiskLevel(score);
  }

  Future<(double earsWeight, double skinWeight, double symptomsWeight)> getWeights() async {
    final settings = await getCurrentSettings();
    return (settings.earsWeight, settings.skinWeight, settings.symptomsWeight);
  }

  // New methods for dynamic risk labels and thresholds
  Future<List<RiskLabel>> getRiskLabels() async {
    final settings = await getCurrentSettings();
    return settings.riskLabels;
  }

  Future<List<RiskThreshold>> getRiskThresholds() async {
    final settings = await getCurrentSettings();
    return settings.riskThresholds;
  }

  Future<List<SymptomChecklist>> getSymptomsChecklist() async {
    final settings = await getCurrentSettings();
    return settings.symptomsChecklist;
  }

  // Backward compatibility methods
  Future<(double highRisk, double mediumRisk, double lowRisk)> getThresholds() async {
    final settings = await getCurrentSettings();
    return (settings.highRiskThreshold, settings.mediumRiskThreshold, settings.lowRiskThreshold);
  }

  Future<(String highRisk, String mediumRisk, String lowRisk)> getLabels() async {
    final settings = await getCurrentSettings();
    return (settings.highRiskLabel, settings.mediumRiskLabel, settings.lowRiskLabel);
  }
} 