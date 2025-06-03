//import 'package:cloud_firestore/cloud_firestore.dart';
class Report {
  final String reporterId;
  final String reportedUserId;
  final String reason;
  final DateTime timestamp;

  Report({
    required this.reporterId,
    required this.reportedUserId,
    required this.reason,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
    'reporterId': reporterId,
    'reportedUserId': reportedUserId,
    'reason': reason,
    'timestamp': timestamp.toIso8601String(),
  };
}
