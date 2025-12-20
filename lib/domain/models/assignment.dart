import 'package:freezed_annotation/freezed_annotation.dart';

part 'assignment.freezed.dart';
part 'assignment.g.dart';

/// Assignment status enum - matches the TypeScript interface
enum AssignmentStatus {
  @JsonValue('draft')
  draft,
  @JsonValue('published')
  published,
}

/// Assignment model - converted from TypeScript interface
/// 
/// TypeScript interface:
/// ```typescript
/// interface Assignment {
///   id: string; title: string; status: 'draft'|'published'; created_at: string;
/// }
/// ```
/// 
/// Extended with additional fields from the web application's Assignment type
@freezed
class Assignment with _$Assignment {
  const factory Assignment({
    required String id,
    required String title,
    String? description,
    required AssignmentStatus status,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'due_date') DateTime? dueDate,
    @JsonKey(name: 'subject_area') String? subjectArea,
    @JsonKey(name: 'assignment_type') String? assignmentType,
    @JsonKey(name: 'teacher_id') String? teacherId,
    @JsonKey(name: 'classroom_id') String? classroomId,
    @JsonKey(name: 'total_points') @Default(100) int totalPoints,
    @JsonKey(name: 'max_score') int? maxScore,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
    @Default([]) List<String> attachments,
    @JsonKey(name: 'description_images') @Default([]) List<String> descriptionImages,
    String? instructions,
  }) = _Assignment;

  factory Assignment.fromJson(Map<String, dynamic> json) =>
      _$AssignmentFromJson(json);
}

/// Submission model for assignment submissions
@freezed
class Submission with _$Submission {
  const factory Submission({
    required String id,
    @JsonKey(name: 'assignment_id') required String assignmentId,
    @JsonKey(name: 'student_id') required String studentId,
    required String content,
    @Default([]) List<String> attachments,
    @JsonKey(name: 'submitted_at') required DateTime submittedAt,
    String? feedback,
    int? score,
    @Default('pending') String status,
  }) = _Submission;

  factory Submission.fromJson(Map<String, dynamic> json) =>
      _$SubmissionFromJson(json);
}
