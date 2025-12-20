import 'package:freezed_annotation/freezed_annotation.dart';

part 'classroom.freezed.dart';
part 'classroom.g.dart';

/// Classroom model for group management
@freezed
class Classroom with _$Classroom {
  const factory Classroom({
    required String id,
    required String name,
    String? description,
    @JsonKey(name: 'teacher_id') required String teacherId,
    @JsonKey(name: 'join_code') String? joinCode,
    String? subject,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'student_ids') @Default([]) List<String> studentIds,
    @Default(true) bool isActive,
  }) = _Classroom;

  factory Classroom.fromJson(Map<String, dynamic> json) =>
      _$ClassroomFromJson(json);
}

/// Doubt/Question model for Q&A system
@freezed
class Doubt with _$Doubt {
  const factory Doubt({
    required String id,
    @JsonKey(name: 'student_id') required String studentId,
    required String question,
    String? answer,
    String? subject,
    @Default('open') String status, // open, in_progress, solved
    @Default('medium') String priority, // low, medium, high
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'answered_at') DateTime? answeredAt,
  }) = _Doubt;

  factory Doubt.fromJson(Map<String, dynamic> json) => _$DoubtFromJson(json);
}
