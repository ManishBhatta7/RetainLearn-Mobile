// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AssignmentImpl _$$AssignmentImplFromJson(Map<String, dynamic> json) =>
    _$AssignmentImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      status: $enumDecode(_$AssignmentStatusEnumMap, json['status']),
      createdAt: DateTime.parse(json['created_at'] as String),
      dueDate: json['due_date'] == null
          ? null
          : DateTime.parse(json['due_date'] as String),
      subjectArea: json['subject_area'] as String?,
      assignmentType: json['assignment_type'] as String?,
      teacherId: json['teacher_id'] as String?,
      classroomId: json['classroom_id'] as String?,
      totalPoints: (json['total_points'] as num?)?.toInt() ?? 100,
      maxScore: (json['max_score'] as num?)?.toInt(),
      isActive: json['is_active'] as bool? ?? true,
      attachments: (json['attachments'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      descriptionImages: (json['description_images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      instructions: json['instructions'] as String?,
    );

Map<String, dynamic> _$$AssignmentImplToJson(_$AssignmentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'status': _$AssignmentStatusEnumMap[instance.status]!,
      'created_at': instance.createdAt.toIso8601String(),
      'due_date': instance.dueDate?.toIso8601String(),
      'subject_area': instance.subjectArea,
      'assignment_type': instance.assignmentType,
      'teacher_id': instance.teacherId,
      'classroom_id': instance.classroomId,
      'total_points': instance.totalPoints,
      'max_score': instance.maxScore,
      'is_active': instance.isActive,
      'attachments': instance.attachments,
      'description_images': instance.descriptionImages,
      'instructions': instance.instructions,
    };

const _$AssignmentStatusEnumMap = {
  AssignmentStatus.draft: 'draft',
  AssignmentStatus.published: 'published',
};

_$SubmissionImpl _$$SubmissionImplFromJson(Map<String, dynamic> json) =>
    _$SubmissionImpl(
      id: json['id'] as String,
      assignmentId: json['assignment_id'] as String,
      studentId: json['student_id'] as String,
      content: json['content'] as String,
      attachments: (json['attachments'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      submittedAt: DateTime.parse(json['submitted_at'] as String),
      feedback: json['feedback'] as String?,
      score: (json['score'] as num?)?.toInt(),
      status: json['status'] as String? ?? 'pending',
    );

Map<String, dynamic> _$$SubmissionImplToJson(_$SubmissionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'assignment_id': instance.assignmentId,
      'student_id': instance.studentId,
      'content': instance.content,
      'attachments': instance.attachments,
      'submitted_at': instance.submittedAt.toIso8601String(),
      'feedback': instance.feedback,
      'score': instance.score,
      'status': instance.status,
    };
