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
      await _repository.updateAdminSettings(
        highRiskThreshold: highRiskThreshold,
        mediumRiskThreshold: mediumRiskThreshold,
        lowRiskThreshold: lowRiskThreshold,
        highRiskLabel: highRiskLabel,
        mediumRiskLabel: mediumRiskLabel,
        lowRiskLabel: lowRiskLabel,
        earsWeight: earsWeight,
        skinWeight: skinWeight,
        symptomsWeight: symptomsWeight,
      );
      await refreshSettings();
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

  Future<(double highRisk, double mediumRisk, double lowRisk)> getThresholds() async {
    final settings = await getCurrentSettings();
    return (settings.highRiskThreshold, settings.mediumRiskThreshold, settings.lowRiskThreshold);
  }

  Future<(String highRisk, String mediumRisk, String lowRisk)> getLabels() async {
    final settings = await getCurrentSettings();
    return (settings.highRiskLabel, settings.mediumRiskLabel, settings.lowRiskLabel);
  }
} 