import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants/app_constants.dart';
import 'tsr_health_api_service.dart';

/// Spaced Repetition API Service
/// 
/// Handles communication with the Spaced Repetition backend service
/// for adaptive learning and review scheduling.
class SpacedRepetitionApiService {
  final http.Client _client;

  SpacedRepetitionApiService({http.Client? client}) : _client = client ?? http.Client();

  /// Get scheduled reviews for a student
  Future<ReviewScheduleResponse> getScheduledReviews(String studentId) async {
    final url = '${AppConstants.spacedRepetitionBaseUrl}/api/v1/reviews/schedule/$studentId';
    
    try {
      final response = await _client.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      ).timeout(AppConstants.apiTimeout);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return ReviewScheduleResponse.fromJson(json);
      } else {
        throw ApiException('Failed to load scheduled reviews: ${response.statusCode}');
      }
    } catch (e) {
      throw ApiException('Network error: $e');
    }
  }

  /// Submit a review
  Future<ReviewResultResponse> submitReview({
    required String studentId,
    required String conceptId,
    required int qualityRating,
    required int responseTimeMs,
    required double fatigueLevel,
  }) async {
    final url = '${AppConstants.spacedRepetitionBaseUrl}/api/v1/reviews/submit';
    
    try {
      final response = await _client.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'student_id': studentId,
          'concept_id': conceptId,
          'quality_rating': qualityRating,
          'response_time_ms': responseTimeMs,
          'fatigue_level': fatigueLevel,
        }),
      ).timeout(AppConstants.apiTimeout);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return ReviewResultResponse.fromJson(json);
      } else {
        throw ApiException('Failed to submit review: ${response.statusCode}');
      }
    } catch (e) {
      throw ApiException('Network error: $e');
    }
  }

  void dispose() {
    _client.close();
  }
}

/// Review Schedule Response Model
class ReviewScheduleResponse {
  final String status;
  final List<ScheduledReview> reviews;

  ReviewScheduleResponse({required this.status, required this.reviews});

  factory ReviewScheduleResponse.fromJson(Map<String, dynamic> json) {
    return ReviewScheduleResponse(
      status: json['status'] ?? 'success',
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((r) => ScheduledReview.fromJson(r))
          .toList() ?? [],
    );
  }
}

/// Scheduled Review Model
class ScheduledReview {
  final String conceptId;
  final String conceptName;
  final String description;
  final String subject;
  final int difficulty;
  final double retentionProbability;
  final String recommendedMethod;
  final String nextReviewDate;
  final ReviewContent content;

  ScheduledReview({
    required this.conceptId,
    required this.conceptName,
    required this.description,
    required this.subject,
    required this.difficulty,
    required this.retentionProbability,
    required this.recommendedMethod,
    required this.nextReviewDate,
    required this.content,
  });

  factory ScheduledReview.fromJson(Map<String, dynamic> json) {
    return ScheduledReview(
      conceptId: json['id'] ?? json['concept_id'] ?? '',
      conceptName: json['name'] ?? json['concept_name'] ?? '',
      description: json['description'] ?? '',
      subject: json['subject'] ?? '',
      difficulty: json['difficulty'] ?? 5,
      retentionProbability: (json['retention_probability'] ?? 0.5).toDouble(),
      recommendedMethod: json['recommended_method'] ?? 'text',
      nextReviewDate: json['next_review_date'] ?? '',
      content: ReviewContent.fromJson(json['content'] ?? {}),
    );
  }
}

/// Review Content Model
class ReviewContent {
  final String? visual;
  final String? text;
  final PracticeQuestion? practice;

  ReviewContent({this.visual, this.text, this.practice});

  factory ReviewContent.fromJson(Map<String, dynamic> json) {
    return ReviewContent(
      visual: json['visual'],
      text: json['text'],
      practice: json['practice'] != null 
          ? PracticeQuestion.fromJson(json['practice']) 
          : null,
    );
  }
}

/// Practice Question Model
class PracticeQuestion {
  final String question;
  final List<String> options;
  final int correctIndex;

  PracticeQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
  });

  factory PracticeQuestion.fromJson(Map<String, dynamic> json) {
    return PracticeQuestion(
      question: json['question'] ?? '',
      options: List<String>.from(json['options'] ?? []),
      correctIndex: json['correct_index'] ?? json['correctIndex'] ?? 0,
    );
  }
}

/// Review Result Response Model
class ReviewResultResponse {
  final String status;
  final ReviewResult data;

  ReviewResultResponse({required this.status, required this.data});

  factory ReviewResultResponse.fromJson(Map<String, dynamic> json) {
    return ReviewResultResponse(
      status: json['status'] ?? 'success',
      data: ReviewResult.fromJson(json['data'] ?? json),
    );
  }
}

/// Review Result Model
class ReviewResult {
  final String conceptId;
  final String nextReviewDate;
  final double newRetention;
  final double easinessFactor;
  final int interval;

  ReviewResult({
    required this.conceptId,
    required this.nextReviewDate,
    required this.newRetention,
    required this.easinessFactor,
    required this.interval,
  });

  factory ReviewResult.fromJson(Map<String, dynamic> json) {
    return ReviewResult(
      conceptId: json['concept_id'] ?? '',
      nextReviewDate: json['next_review_date'] ?? '',
      newRetention: (json['new_retention'] ?? 0).toDouble(),
      easinessFactor: (json['easiness_factor'] ?? 2.5).toDouble(),
      interval: json['interval'] ?? 1,
    );
  }
}
