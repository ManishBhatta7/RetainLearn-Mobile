import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants/app_constants.dart';
import 'tsr_health_api_service.dart';

/// Board Exam API Service
/// 
/// Handles communication with the Board Exam backend service
/// for CBSE/ICSE Class 8-12 exam preparation.
class BoardExamApiService {
  final http.Client _client;

  BoardExamApiService({http.Client? client}) : _client = client ?? http.Client();

  String get _baseUrl => 'http://${AppConstants.useLocalBackend ? "10.0.2.2" : "api.retainlearn.com"}:8005';

  /// Get current study mode based on exam proximity
  Future<StudyModeResponse> getStudyMode({
    required String studentId,
    required String board,
    required int classLevel,
    required DateTime examDate,
  }) async {
    final url = '$_baseUrl/api/v1/boards/mode/$studentId'
        '?board=$board&class_level=$classLevel&board_exam_date=${_formatDate(examDate)}';
    
    try {
      final response = await _client.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      ).timeout(AppConstants.apiTimeout);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return StudyModeResponse.fromJson(json);
      } else {
        throw ApiException('Failed to load study mode: ${response.statusCode}');
      }
    } catch (e) {
      throw ApiException('Network error: $e');
    }
  }

  /// Get cognitive load configuration for a student
  Future<CognitiveLoadConfig> getCognitiveLoadConfig({
    required String studentId,
    required int classLevel,
  }) async {
    final url = '$_baseUrl/api/v1/boards/cognitive-load/$studentId?class_level=$classLevel';
    
    try {
      final response = await _client.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      ).timeout(AppConstants.apiTimeout);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return CognitiveLoadConfig.fromJson(json['data'] ?? json);
      } else {
        throw ApiException('Failed to load cognitive config: ${response.statusCode}');
      }
    } catch (e) {
      throw ApiException('Network error: $e');
    }
  }

  /// Calculate board-aware review schedule
  Future<BoardReviewResult> calculateReview({
    required String studentId,
    required String board,
    required int classLevel,
    required DateTime examDate,
    required String chapterId,
    required int qualityRating,
    required double chapterWeightage,
    String priorityLevel = 'Medium',
    double currentRetention = 0.5,
    bool isWeakChapter = false,
  }) async {
    final queryParams = 'student_id=$studentId&board=$board'
        '&class_level=$classLevel&board_exam_date=${_formatDate(examDate)}';
    final url = '$_baseUrl/api/v1/boards/review/calculate?$queryParams';
    
    try {
      final response = await _client.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'chapter_id': chapterId,
          'quality_rating': qualityRating,
          'chapter_weightage': chapterWeightage,
          'priority_level': priorityLevel,
          'current_retention': currentRetention,
          'is_weak_chapter': isWeakChapter,
        }),
      ).timeout(AppConstants.apiTimeout);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return BoardReviewResult.fromJson(json['data'] ?? json);
      } else {
        throw ApiException('Failed to calculate review: ${response.statusCode}');
      }
    } catch (e) {
      throw ApiException('Network error: $e');
    }
  }

  /// Get student's chapter progress
  Future<StudentProgressResponse> getStudentProgress({
    required String studentId,
    required String board,
    required int classLevel,
  }) async {
    final url = '$_baseUrl/api/v1/boards/progress/$studentId?board=$board&class_level=$classLevel';
    
    try {
      final response = await _client.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      ).timeout(AppConstants.apiTimeout);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return StudentProgressResponse.fromJson(json);
      } else {
        throw ApiException('Failed to load progress: ${response.statusCode}');
      }
    } catch (e) {
      throw ApiException('Network error: $e');
    }
  }

  /// Get algorithm constants
  Future<Map<String, dynamic>> getConstants() async {
    final url = '$_baseUrl/api/v1/boards/constants';
    
    try {
      final response = await _client.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      ).timeout(AppConstants.apiTimeout);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return json['data'] ?? {};
      } else {
        throw ApiException('Failed to load constants: ${response.statusCode}');
      }
    } catch (e) {
      throw ApiException('Network error: $e');
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  void dispose() {
    _client.close();
  }
}

// =============================================================================
// RESPONSE MODELS
// =============================================================================

/// Study Mode Response
class StudyModeResponse {
  final String status;
  final StudyModeData data;

  StudyModeResponse({required this.status, required this.data});

  factory StudyModeResponse.fromJson(Map<String, dynamic> json) {
    return StudyModeResponse(
      status: json['status'] ?? 'success',
      data: StudyModeData.fromJson(json['data'] ?? {}),
    );
  }
}

class StudyModeData {
  final String studentId;
  final String board;
  final int classLevel;
  final int daysUntilExam;
  final String currentMode; // normal, prelims, crunch
  final Map<String, dynamic> modeConfig;

  StudyModeData({
    required this.studentId,
    required this.board,
    required this.classLevel,
    required this.daysUntilExam,
    required this.currentMode,
    required this.modeConfig,
  });

  factory StudyModeData.fromJson(Map<String, dynamic> json) {
    return StudyModeData(
      studentId: json['student_id'] ?? '',
      board: json['board'] ?? 'CBSE',
      classLevel: json['class_level'] ?? 10,
      daysUntilExam: json['days_until_exam'] ?? 0,
      currentMode: json['current_mode'] ?? 'normal',
      modeConfig: Map<String, dynamic>.from(json['mode_config'] ?? {}),
    );
  }

  String get modeLabel {
    switch (currentMode) {
      case 'crunch':
        return 'Crunch Mode';
      case 'prelims':
        return 'Prelims Focus';
      default:
        return 'Learning Mode';
    }
  }

  String get modeDescription {
    return modeConfig['description'] ?? '';
  }
}

/// Cognitive Load Configuration
class CognitiveLoadConfig {
  final String studentId;
  final int classLevel;
  final double workingMemorySlots;
  final Map<String, double> optimalSessionDuration;
  final int breakFrequencyMinutes;

  CognitiveLoadConfig({
    required this.studentId,
    required this.classLevel,
    required this.workingMemorySlots,
    required this.optimalSessionDuration,
    required this.breakFrequencyMinutes,
  });

  factory CognitiveLoadConfig.fromJson(Map<String, dynamic> json) {
    return CognitiveLoadConfig(
      studentId: json['student_id'] ?? '',
      classLevel: json['class_level'] ?? 10,
      workingMemorySlots: (json['working_memory_slots'] ?? 4.0).toDouble(),
      optimalSessionDuration: Map<String, double>.from(
        (json['optimal_session_duration'] ?? {}).map(
          (k, v) => MapEntry(k, (v as num).toDouble()),
        ),
      ),
      breakFrequencyMinutes: json['recommended_break_frequency_minutes'] ?? 30,
    );
  }
}

/// Board Review Result
class BoardReviewResult {
  final String chapterId;
  final String nextReviewDate;
  final int newInterval;
  final double newEasiness;
  final double predictedRetention;
  final String studyMode;
  final int daysUntilExam;
  final double priorityBoost;
  final bool formulaReviewNeeded;
  final bool isCrunchMode;
  final String recommendedSession;

  BoardReviewResult({
    required this.chapterId,
    required this.nextReviewDate,
    required this.newInterval,
    required this.newEasiness,
    required this.predictedRetention,
    required this.studyMode,
    required this.daysUntilExam,
    required this.priorityBoost,
    required this.formulaReviewNeeded,
    required this.isCrunchMode,
    required this.recommendedSession,
  });

  factory BoardReviewResult.fromJson(Map<String, dynamic> json) {
    return BoardReviewResult(
      chapterId: json['chapter_id'] ?? '',
      nextReviewDate: json['next_review_date'] ?? '',
      newInterval: json['new_interval'] ?? 1,
      newEasiness: (json['new_easiness'] ?? 2.5).toDouble(),
      predictedRetention: (json['predicted_retention'] ?? 0.5).toDouble(),
      studyMode: json['study_mode'] ?? 'normal',
      daysUntilExam: json['days_until_exam'] ?? 0,
      priorityBoost: (json['priority_boost'] ?? 1.0).toDouble(),
      formulaReviewNeeded: json['formula_review_needed'] ?? false,
      isCrunchMode: json['is_crunch_mode'] ?? false,
      recommendedSession: json['recommended_session'] ?? 'study',
    );
  }
}

/// Student Progress Response
class StudentProgressResponse {
  final String status;
  final String studentId;
  final String board;
  final int classLevel;
  final StudyModeData studyMode;
  final List<ChapterProgress> chapters;

  StudentProgressResponse({
    required this.status,
    required this.studentId,
    required this.board,
    required this.classLevel,
    required this.studyMode,
    required this.chapters,
  });

  factory StudentProgressResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? json;
    return StudentProgressResponse(
      status: json['status'] ?? 'success',
      studentId: data['student_id'] ?? '',
      board: data['board'] ?? 'CBSE',
      classLevel: data['class_level'] ?? 10,
      studyMode: StudyModeData.fromJson(data['study_mode'] ?? {}),
      chapters: (data['chapters'] as List<dynamic>?)
          ?.map((c) => ChapterProgress.fromJson(c))
          .toList() ?? [],
    );
  }
}

/// Chapter Progress
class ChapterProgress {
  final String chapterId;
  final String chapterName;
  final int chapterNumber;
  final String subject;
  final double weightage;
  final String priorityLevel;
  final double masteryScore;
  final double retentionScore;
  final String status;
  final double predictedMarks;

  ChapterProgress({
    required this.chapterId,
    required this.chapterName,
    required this.chapterNumber,
    required this.subject,
    required this.weightage,
    required this.priorityLevel,
    required this.masteryScore,
    required this.retentionScore,
    required this.status,
    required this.predictedMarks,
  });

  factory ChapterProgress.fromJson(Map<String, dynamic> json) {
    return ChapterProgress(
      chapterId: json['chapter_id'] ?? '',
      chapterName: json['chapter_name'] ?? '',
      chapterNumber: json['chapter_number'] ?? 0,
      subject: json['subject'] ?? '',
      weightage: (json['weightage'] ?? 0).toDouble(),
      priorityLevel: json['priority_level'] ?? 'Medium',
      masteryScore: (json['mastery_score'] ?? 0).toDouble(),
      retentionScore: (json['retention_score'] ?? 0).toDouble(),
      status: json['status'] ?? 'not_started',
      predictedMarks: (json['predicted_marks'] ?? 0).toDouble(),
    );
  }

  /// Priority score = Weightage × (1 - Retention)
  double get priorityScore => weightage * (1 - retentionScore);
}
