import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants/app_constants.dart';

/// TSR Health API Service
/// 
/// Handles communication with the TSR Health backend service
/// for Teacher-Student Relationship health monitoring.
class TsrHealthApiService {
  final http.Client _client;

  TsrHealthApiService({http.Client? client}) : _client = client ?? http.Client();

  /// Get the dashboard data for a teacher
  Future<TsrDashboardResponse> getTeacherDashboard(String teacherId) async {
    final url = '${AppConstants.tsrHealthBaseUrl}/api/v1/tsr/dashboard/$teacherId';
    
    try {
      final response = await _client.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      ).timeout(AppConstants.apiTimeout);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return TsrDashboardResponse.fromJson(json);
      } else {
        throw ApiException('Failed to load dashboard: ${response.statusCode}');
      }
    } catch (e) {
      throw ApiException('Network error: $e');
    }
  }

  /// Get health score for a specific student-teacher pair
  Future<TsrHealthScore> getHealthScore(String studentId, String teacherId) async {
    final url = '${AppConstants.tsrHealthBaseUrl}/api/v1/tsr/health/$studentId/$teacherId';
    
    try {
      final response = await _client.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      ).timeout(AppConstants.apiTimeout);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return TsrHealthScore.fromJson(json['data'] ?? json);
      } else {
        throw ApiException('Failed to load health score: ${response.statusCode}');
      }
    } catch (e) {
      throw ApiException('Network error: $e');
    }
  }

  /// Calculate health score with provided data
  Future<TsrHealthScore> calculateHealthScore({
    required String studentId,
    required String teacherId,
    required Map<String, dynamic> communication,
    required Map<String, dynamic> engagement,
    required Map<String, dynamic> interaction,
    required Map<String, dynamic> behavioral,
    required Map<String, dynamic> sentiment,
  }) async {
    final url = '${AppConstants.tsrHealthBaseUrl}/api/v1/tsr/health/calculate';
    
    try {
      final response = await _client.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'student_id': studentId,
          'teacher_id': teacherId,
          'communication': communication,
          'engagement': engagement,
          'interaction': interaction,
          'behavioral': behavioral,
          'sentiment': sentiment,
        }),
      ).timeout(AppConstants.apiTimeout);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return TsrHealthScore.fromJson(json['data'] ?? json);
      } else {
        throw ApiException('Failed to calculate health score: ${response.statusCode}');
      }
    } catch (e) {
      throw ApiException('Network error: $e');
    }
  }

  void dispose() {
    _client.close();
  }
}

/// API Exception
class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  @override
  String toString() => 'ApiException: $message';
}

/// Dashboard Response Model
class TsrDashboardResponse {
  final String status;
  final TsrDashboardData data;

  TsrDashboardResponse({required this.status, required this.data});

  factory TsrDashboardResponse.fromJson(Map<String, dynamic> json) {
    return TsrDashboardResponse(
      status: json['status'] ?? 'success',
      data: TsrDashboardData.fromJson(json['data'] ?? json),
    );
  }
}

/// Dashboard Data Model
class TsrDashboardData {
  final String teacherId;
  final int totalStudents;
  final double averageHealth;
  final Map<String, int> categoryBreakdown;
  final int atRiskCount;
  final List<StudentHealthSummary> students;

  TsrDashboardData({
    required this.teacherId,
    required this.totalStudents,
    required this.averageHealth,
    required this.categoryBreakdown,
    required this.atRiskCount,
    required this.students,
  });

  factory TsrDashboardData.fromJson(Map<String, dynamic> json) {
    return TsrDashboardData(
      teacherId: json['teacher_id'] ?? '',
      totalStudents: json['total_students'] ?? 0,
      averageHealth: (json['average_health'] ?? 0).toDouble(),
      categoryBreakdown: Map<String, int>.from(json['category_breakdown'] ?? {}),
      atRiskCount: json['at_risk_count'] ?? 0,
      students: (json['students'] as List<dynamic>?)
          ?.map((s) => StudentHealthSummary.fromJson(s))
          .toList() ?? [],
    );
  }
}

/// Student Health Summary Model
class StudentHealthSummary {
  final String studentId;
  final String studentName;
  final double overallHealth;
  final String healthCategory;
  final String trendDirection;
  final List<String> riskFactors;

  StudentHealthSummary({
    required this.studentId,
    required this.studentName,
    required this.overallHealth,
    required this.healthCategory,
    required this.trendDirection,
    required this.riskFactors,
  });

  factory StudentHealthSummary.fromJson(Map<String, dynamic> json) {
    return StudentHealthSummary(
      studentId: json['student_id'] ?? '',
      studentName: json['student_name'] ?? '',
      overallHealth: (json['overall_health'] ?? 0).toDouble(),
      healthCategory: json['health_category'] ?? 'good',
      trendDirection: json['trend_direction'] ?? 'stable',
      riskFactors: List<String>.from(json['risk_factors'] ?? []),
    );
  }
}

/// TSR Health Score Model
class TsrHealthScore {
  final String studentId;
  final String teacherId;
  final double communicationScore;
  final double engagementScore;
  final double interactionScore;
  final double behavioralScore;
  final double sentimentScore;
  final double overallHealth;
  final String healthCategory;
  final String trendDirection;
  final List<String> riskFactors;
  final List<String> recommendations;
  final String calculatedAt;

  TsrHealthScore({
    required this.studentId,
    required this.teacherId,
    required this.communicationScore,
    required this.engagementScore,
    required this.interactionScore,
    required this.behavioralScore,
    required this.sentimentScore,
    required this.overallHealth,
    required this.healthCategory,
    required this.trendDirection,
    required this.riskFactors,
    required this.recommendations,
    required this.calculatedAt,
  });

  factory TsrHealthScore.fromJson(Map<String, dynamic> json) {
    return TsrHealthScore(
      studentId: json['student_id'] ?? '',
      teacherId: json['teacher_id'] ?? '',
      communicationScore: (json['communication_score'] ?? 0).toDouble(),
      engagementScore: (json['engagement_score'] ?? 0).toDouble(),
      interactionScore: (json['interaction_score'] ?? 0).toDouble(),
      behavioralScore: (json['behavioral_score'] ?? 0).toDouble(),
      sentimentScore: (json['sentiment_score'] ?? 0).toDouble(),
      overallHealth: (json['overall_health'] ?? 0).toDouble(),
      healthCategory: json['health_category'] ?? 'good',
      trendDirection: json['trend_direction'] ?? 'stable',
      riskFactors: List<String>.from(json['risk_factors'] ?? []),
      recommendations: List<String>.from(json['recommendations'] ?? []),
      calculatedAt: json['calculated_at'] ?? '',
    );
  }
}
