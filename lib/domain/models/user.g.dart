// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String?,
      fullName: json['full_name'] as String?,
      role: $enumDecodeNullable(_$UserRoleEnumMap, json['role']) ??
          UserRole.student,
      avatarUrl: json['avatar_url'] as String?,
      school: json['school'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      preferences: json['preferences'] == null
          ? null
          : UserPreferences.fromJson(
              json['preferences'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'full_name': instance.fullName,
      'role': _$UserRoleEnumMap[instance.role]!,
      'avatar_url': instance.avatarUrl,
      'school': instance.school,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'preferences': instance.preferences,
    };

const _$UserRoleEnumMap = {
  UserRole.student: 'student',
  UserRole.teacher: 'teacher',
  UserRole.parent: 'parent',
  UserRole.admin: 'admin',
  UserRole.school: 'school',
};

_$UserPreferencesImpl _$$UserPreferencesImplFromJson(
        Map<String, dynamic> json) =>
    _$UserPreferencesImpl(
      userType: json['user_type'] as String?,
      board: json['board'] as String?,
      subject: json['subject'] as String?,
      theme: json['theme'] as String? ?? 'light',
      notifications: json['notifications'] as bool? ?? true,
      language: json['language'] as String? ?? 'en',
      completedAt: json['completed_at'] == null
          ? null
          : DateTime.parse(json['completed_at'] as String),
    );

Map<String, dynamic> _$$UserPreferencesImplToJson(
        _$UserPreferencesImpl instance) =>
    <String, dynamic>{
      'user_type': instance.userType,
      'board': instance.board,
      'subject': instance.subject,
      'theme': instance.theme,
      'notifications': instance.notifications,
      'language': instance.language,
      'completed_at': instance.completedAt?.toIso8601String(),
    };

_$LearningStyleImpl _$$LearningStyleImplFromJson(Map<String, dynamic> json) =>
    _$LearningStyleImpl(
      primary: $enumDecode(_$LearningStyleTypeEnumMap, json['primary']),
      secondary:
          $enumDecodeNullable(_$LearningStyleTypeEnumMap, json['secondary']),
      scores: (json['scores'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry($enumDecode(_$LearningStyleTypeEnumMap, k),
                (e as num).toDouble()),
          ) ??
          const {},
      assessedAt: json['assessed_at'] == null
          ? null
          : DateTime.parse(json['assessed_at'] as String),
      recommendations: (json['recommendations'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$LearningStyleImplToJson(_$LearningStyleImpl instance) =>
    <String, dynamic>{
      'primary': _$LearningStyleTypeEnumMap[instance.primary]!,
      'secondary': _$LearningStyleTypeEnumMap[instance.secondary],
      'scores': instance.scores
          .map((k, e) => MapEntry(_$LearningStyleTypeEnumMap[k]!, e)),
      'assessed_at': instance.assessedAt?.toIso8601String(),
      'recommendations': instance.recommendations,
    };

const _$LearningStyleTypeEnumMap = {
  LearningStyleType.visual: 'visual',
  LearningStyleType.auditory: 'auditory',
  LearningStyleType.reading: 'reading',
  LearningStyleType.kinesthetic: 'kinesthetic',
};
