// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classroom.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClassroomImpl _$$ClassroomImplFromJson(Map<String, dynamic> json) =>
    _$ClassroomImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      teacherId: json['teacher_id'] as String,
      joinCode: json['join_code'] as String?,
      subject: json['subject'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      studentIds: (json['student_ids'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      isActive: json['isActive'] as bool? ?? true,
    );

Map<String, dynamic> _$$ClassroomImplToJson(_$ClassroomImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'teacher_id': instance.teacherId,
      'join_code': instance.joinCode,
      'subject': instance.subject,
      'created_at': instance.createdAt?.toIso8601String(),
      'student_ids': instance.studentIds,
      'isActive': instance.isActive,
    };

_$DoubtImpl _$$DoubtImplFromJson(Map<String, dynamic> json) => _$DoubtImpl(
      id: json['id'] as String,
      studentId: json['student_id'] as String,
      question: json['question'] as String,
      answer: json['answer'] as String?,
      subject: json['subject'] as String?,
      status: json['status'] as String? ?? 'open',
      priority: json['priority'] as String? ?? 'medium',
      createdAt: DateTime.parse(json['created_at'] as String),
      answeredAt: json['answered_at'] == null
          ? null
          : DateTime.parse(json['answered_at'] as String),
    );

Map<String, dynamic> _$$DoubtImplToJson(_$DoubtImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'student_id': instance.studentId,
      'question': instance.question,
      'answer': instance.answer,
      'subject': instance.subject,
      'status': instance.status,
      'priority': instance.priority,
      'created_at': instance.createdAt.toIso8601String(),
      'answered_at': instance.answeredAt?.toIso8601String(),
    };
