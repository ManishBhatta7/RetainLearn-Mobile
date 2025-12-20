import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

/// User role enum - matches web application roles
enum UserRole {
  @JsonValue('student')
  student,
  @JsonValue('teacher')
  teacher,
  @JsonValue('parent')
  parent,
  @JsonValue('admin')
  admin,
  @JsonValue('school')
  school,
}

/// User model - represents the authenticated user
@freezed
class User with _$User {
  const factory User({
    required String id,
    required String email,
    String? name,
    @JsonKey(name: 'full_name') String? fullName,
    @Default(UserRole.student) UserRole role,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    String? school,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    UserPreferences? preferences,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

/// User preferences including onboarding data
@freezed
class UserPreferences with _$UserPreferences {
  const factory UserPreferences({
    @JsonKey(name: 'user_type') String? userType,
    String? board,
    String? subject,
    @Default('light') String theme,
    @Default(true) bool notifications,
    @Default('en') String language,
    @JsonKey(name: 'completed_at') DateTime? completedAt,
  }) = _UserPreferences;

  factory UserPreferences.fromJson(Map<String, dynamic> json) =>
      _$UserPreferencesFromJson(json);
}

/// Learning style type enum
enum LearningStyleType {
  visual,
  auditory,
  reading,
  kinesthetic,
}

/// Learning style assessment result
@freezed
class LearningStyle with _$LearningStyle {
  const factory LearningStyle({
    required LearningStyleType primary,
    LearningStyleType? secondary,
    @Default({}) Map<LearningStyleType, double> scores,
    @JsonKey(name: 'assessed_at') DateTime? assessedAt,
    @Default([]) List<String> recommendations,
  }) = _LearningStyle;

  factory LearningStyle.fromJson(Map<String, dynamic> json) =>
      _$LearningStyleFromJson(json);
}
