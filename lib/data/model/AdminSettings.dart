class AdminSettings {
  final List<RiskLabel> riskLabels;
  final List<RiskThreshold> riskThresholds;
  final double earsWeight;
  final double skinWeight;
  final double symptomsWeight;
  final List<SymptomChecklist> symptomsChecklist;
  final DateTime lastUpdated;

  AdminSettings({
    required this.riskLabels,
    required this.riskThresholds,
    required this.earsWeight,
    required this.skinWeight,
    required this.symptomsWeight,
    required this.symptomsChecklist,
    required this.lastUpdated,
  });

  // Default values
  factory AdminSettings.defaults() {
    return AdminSettings(
      riskLabels: [
        RiskLabel(label: 'High Risk'),
        RiskLabel(label: 'Medium Risk'),
        RiskLabel(label: 'Low Risk'),
      ],
      riskThresholds: [
        RiskThreshold(label: 'High Risk', value: 80),
        RiskThreshold(label: 'Medium Risk', value: 30),
        RiskThreshold(label: 'Low Risk', value: 0),
      ],
      earsWeight: 30.0,
      skinWeight: 30.0,
      symptomsWeight: 40.0,
      symptomsChecklist: [
        SymptomChecklist(
          question: 'High fever?',
          description: 'The pig has a high fever, with a body temperature ranging from 40°C to 42°C, which may indicate a severe infection or systemic illness.',
        ),
        SymptomChecklist(
          question: 'Milder fever?',
          description: 'The pig is experiencing a fluctuating mild fever, where the temperature rises and falls, potentially signaling an early or infection.',
        ),
        SymptomChecklist(
          question: 'Slight fever?',
          description: 'The pig has a slight fever, with body temperatures ranging between 37.5°C and 39°C, which could be a sign of a mild infection or stress response.',
        ),
        SymptomChecklist(
          question: 'Extreme tiredness?',
          description: 'The pig shows signs of extreme fatigue, which could be associated with systemic weakness.',
        ),
        SymptomChecklist(
          question: 'Loss of appetite?',
          description: 'The pig is refusing to eat, a common symptom that may indicate pain, illness, or digestive discomfort.',
        ),
        SymptomChecklist(
          question: 'Difficulty of breathing?',
          description: 'The pig is having trouble breathing, which may suggest respiratory tract infections, lung issues, or high fever.',
        ),
        SymptomChecklist(
          question: 'Difficulty on walking?',
          description: 'The pig has difficulty walking, which may result from joint pain, muscle weakness, neurological problems, or respiratory distress.',
        ),
        SymptomChecklist(
          question: 'Bloody feces?',
          description: 'The presence of blood in the pig\'s feces is a serious symptom that may point to internal bleeding, intestinal infections, or parasitic infestations.',
        ),
      ],
      lastUpdated: DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'riskLabels': riskLabels.map((label) => label.toMap()).toList(),
      'riskThresholds': riskThresholds.map((threshold) => threshold.toMap()).toList(),
      'earsWeight': earsWeight,
      'skinWeight': skinWeight,
      'symptomsWeight': symptomsWeight,
      'symptomsChecklist': symptomsChecklist.map((symptom) => symptom.toMap()).toList(),
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }

  factory AdminSettings.fromMap(Map<String, dynamic> map) {
    // Parse risk labels
    List<RiskLabel> riskLabels = [];
    if (map['riskLabels'] != null) {
      riskLabels = (map['riskLabels'] as List)
          .map((item) => RiskLabel.fromMap(item))
          .toList();
    }

    // Parse risk thresholds
    List<RiskThreshold> riskThresholds = [];
    if (map['riskThresholds'] != null) {
      riskThresholds = (map['riskThresholds'] as List)
          .map((item) => RiskThreshold.fromMap(item))
          .toList();
    }

    // Parse symptoms checklist
    List<SymptomChecklist> symptomsChecklist = [];
    if (map['symptomsChecklist'] != null) {
      symptomsChecklist = (map['symptomsChecklist'] as List)
          .map((item) => SymptomChecklist.fromMap(item))
          .toList();
    }

    return AdminSettings(
      riskLabels: riskLabels.isNotEmpty ? riskLabels : AdminSettings.defaults().riskLabels,
      riskThresholds: riskThresholds.isNotEmpty ? riskThresholds : AdminSettings.defaults().riskThresholds,
      earsWeight: (map['earsWeight'] ?? 30.0).toDouble(),
      skinWeight: (map['skinWeight'] ?? 30.0).toDouble(),
      symptomsWeight: (map['symptomsWeight'] ?? 40.0).toDouble(),
      symptomsChecklist: symptomsChecklist.isNotEmpty ? symptomsChecklist : AdminSettings.defaults().symptomsChecklist,
      lastUpdated: DateTime.parse(map['lastUpdated'] ?? DateTime.now().toIso8601String()),
    );
  }

  AdminSettings copyWith({
    List<RiskLabel>? riskLabels,
    List<RiskThreshold>? riskThresholds,
    double? earsWeight,
    double? skinWeight,
    double? symptomsWeight,
    List<SymptomChecklist>? symptomsChecklist,
  }) {
    return AdminSettings(
      riskLabels: riskLabels ?? this.riskLabels,
      riskThresholds: riskThresholds ?? this.riskThresholds,
      earsWeight: earsWeight ?? this.earsWeight,
      skinWeight: skinWeight ?? this.skinWeight,
      symptomsWeight: symptomsWeight ?? this.symptomsWeight,
      symptomsChecklist: symptomsChecklist ?? this.symptomsChecklist,
      lastUpdated: DateTime.now(),
    );
  }

  String getRiskLevel(double score) {
    // Sort thresholds by value in descending order (highest to lowest)
    final sortedThresholds = List<RiskThreshold>.from(riskThresholds)
      ..sort((a, b) => b.value.compareTo(a.value));
    
    // Find the appropriate risk level based on score
    for (final threshold in sortedThresholds) {
      if (score >= threshold.value) {
        return threshold.label;
      }
    }
    
    // If no threshold matches, return the lowest risk label
    if (sortedThresholds.isNotEmpty) {
      return sortedThresholds.last.label;
    }
    
    // Fallback to default
    return "Low Risk";
  }

  // Helper methods for backward compatibility
  double get highRiskThreshold {
    final highRisk = riskThresholds
        .where((t) => t.label.toLowerCase().contains('high'))
        .firstOrNull;
    return highRisk?.value ?? 80.0;
  }

  double get mediumRiskThreshold {
    final mediumRisk = riskThresholds
        .where((t) => t.label.toLowerCase().contains('medium'))
        .firstOrNull;
    return mediumRisk?.value ?? 30.0;
  }

  double get lowRiskThreshold {
    final lowRisk = riskThresholds
        .where((t) => t.label.toLowerCase().contains('low'))
        .firstOrNull;
    return lowRisk?.value ?? 0.0;
  }

  String get highRiskLabel {
    final highRisk = riskLabels
        .where((l) => l.label.toLowerCase().contains('high'))
        .firstOrNull;
    return highRisk?.label ?? "High Risk";
  }

  String get mediumRiskLabel {
    final mediumRisk = riskLabels
        .where((l) => l.label.toLowerCase().contains('medium'))
        .firstOrNull;
    return mediumRisk?.label ?? "Medium Risk";
  }

  String get lowRiskLabel {
    final lowRisk = riskLabels
        .where((l) => l.label.toLowerCase().contains('low'))
        .firstOrNull;
    return lowRisk?.label ?? "Low Risk";
  }
}

class RiskLabel {
  final String label;

  RiskLabel({required this.label});

  Map<String, dynamic> toMap() {
    return {
      'label': label,
    };
  }

  factory RiskLabel.fromMap(Map<String, dynamic> map) {
    return RiskLabel(
      label: map['label'] ?? '',
    );
  }
}

class RiskThreshold {
  final String label;
  final double value;

  RiskThreshold({required this.label, required this.value});

  Map<String, dynamic> toMap() {
    return {
      'label': label,
      'value': value,
    };
  }

  factory RiskThreshold.fromMap(Map<String, dynamic> map) {
    return RiskThreshold(
      label: map['label'] ?? '',
      value: (map['value'] ?? 0.0).toDouble(),
    );
  }
}

class SymptomChecklist {
  final String question;
  final String description;

  SymptomChecklist({required this.question, required this.description});

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'description': description,
    };
  }

  factory SymptomChecklist.fromMap(Map<String, dynamic> map) {
    return SymptomChecklist(
      question: map['question'] ?? '',
      description: map['description'] ?? '',
    );
  }
} 