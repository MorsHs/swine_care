class AdminSettings {
  final double highRiskThreshold;
  final double mediumRiskThreshold;
  final double lowRiskThreshold;
  final String highRiskLabel;
  final String mediumRiskLabel;
  final String lowRiskLabel;
  final double earsWeight;
  final double skinWeight;
  final double symptomsWeight;
  final DateTime lastUpdated;

  AdminSettings({
    required this.highRiskThreshold,
    required this.mediumRiskThreshold,
    required this.lowRiskThreshold,
    required this.highRiskLabel,
    required this.mediumRiskLabel,
    required this.lowRiskLabel,
    required this.earsWeight,
    required this.skinWeight,
    required this.symptomsWeight,
    required this.lastUpdated,
  });

  // Default values
  factory AdminSettings.defaults() {
    return AdminSettings(
      highRiskThreshold: 80.0,
      mediumRiskThreshold: 30.0,
      lowRiskThreshold: 0.0,
      highRiskLabel: "High Risk",
      mediumRiskLabel: "Medium Risk",
      lowRiskLabel: "Low Risk",
      earsWeight: 30.0,
      skinWeight: 30.0,
      symptomsWeight: 40.0,
      lastUpdated: DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'highRiskThreshold': highRiskThreshold,
      'mediumRiskThreshold': mediumRiskThreshold,
      'lowRiskThreshold': lowRiskThreshold,
      'highRiskLabel': highRiskLabel,
      'mediumRiskLabel': mediumRiskLabel,
      'lowRiskLabel': lowRiskLabel,
      'earsWeight': earsWeight,
      'skinWeight': skinWeight,
      'symptomsWeight': symptomsWeight,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }

  factory AdminSettings.fromMap(Map<String, dynamic> map) {
    return AdminSettings(
      highRiskThreshold: (map['highRiskThreshold'] ?? 80.0).toDouble(),
      mediumRiskThreshold: (map['mediumRiskThreshold'] ?? 30.0).toDouble(),
      lowRiskThreshold: (map['lowRiskThreshold'] ?? 0.0).toDouble(),
      highRiskLabel: map['highRiskLabel'] ?? "High Risk",
      mediumRiskLabel: map['mediumRiskLabel'] ?? "Medium Risk",
      lowRiskLabel: map['lowRiskLabel'] ?? "Low Risk",
      earsWeight: (map['earsWeight'] ?? 30.0).toDouble(),
      skinWeight: (map['skinWeight'] ?? 30.0).toDouble(),
      symptomsWeight: (map['symptomsWeight'] ?? 40.0).toDouble(),
      lastUpdated: DateTime.parse(map['lastUpdated'] ?? DateTime.now().toIso8601String()),
    );
  }

  AdminSettings copyWith({
    double? highRiskThreshold,
    double? mediumRiskThreshold,
    double? lowRiskThreshold,
    String? highRiskLabel,
    String? mediumRiskLabel,
    String? lowRiskLabel,
    double? earsWeight,
    double? skinWeight,
    double? symptomsWeight,
  }) {
    return AdminSettings(
      highRiskThreshold: highRiskThreshold ?? this.highRiskThreshold,
      mediumRiskThreshold: mediumRiskThreshold ?? this.mediumRiskThreshold,
      lowRiskThreshold: lowRiskThreshold ?? this.lowRiskThreshold,
      highRiskLabel: highRiskLabel ?? this.highRiskLabel,
      mediumRiskLabel: mediumRiskLabel ?? this.mediumRiskLabel,
      lowRiskLabel: lowRiskLabel ?? this.lowRiskLabel,
      earsWeight: earsWeight ?? this.earsWeight,
      skinWeight: skinWeight ?? this.skinWeight,
      symptomsWeight: symptomsWeight ?? this.symptomsWeight,
      lastUpdated: DateTime.now(),
    );
  }

  String getRiskLevel(double score) {
    if (score >= highRiskThreshold) {
      return highRiskLabel;
    } else if (score >= mediumRiskThreshold) {
      return mediumRiskLabel;
    } else {
      return lowRiskLabel;
    }
  }
} 