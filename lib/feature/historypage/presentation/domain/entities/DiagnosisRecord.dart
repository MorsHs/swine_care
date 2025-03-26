class DiagnosisRecord {
  final String id;
  final String pigId;
  final String date;
  final String diagnosis; // "Highly Likely", "Medium Likelihood", "Low Risk"
  final String status; // "Resolved", "Under Observation"

  DiagnosisRecord({
    required this.id,
    required this.pigId,
    required this.date,
    required this.diagnosis,
    required this.status,
  });
}