// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'assignment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Assignment _$AssignmentFromJson(Map<String, dynamic> json) {
  return _Assignment.fromJson(json);
}

/// @nodoc
mixin _$Assignment {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  AssignmentStatus get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'due_date')
  DateTime? get dueDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'subject_area')
  String? get subjectArea => throw _privateConstructorUsedError;
  @JsonKey(name: 'assignment_type')
  String? get assignmentType => throw _privateConstructorUsedError;
  @JsonKey(name: 'teacher_id')
  String? get teacherId => throw _privateConstructorUsedError;
  @JsonKey(name: 'classroom_id')
  String? get classroomId => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_points')
  int get totalPoints => throw _privateConstructorUsedError;
  @JsonKey(name: 'max_score')
  int? get maxScore => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;
  List<String> get attachments => throw _privateConstructorUsedError;
  @JsonKey(name: 'description_images')
  List<String> get descriptionImages => throw _privateConstructorUsedError;
  String? get instructions => throw _privateConstructorUsedError;

  /// Serializes this Assignment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Assignment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AssignmentCopyWith<Assignment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AssignmentCopyWith<$Res> {
  factory $AssignmentCopyWith(
          Assignment value, $Res Function(Assignment) then) =
      _$AssignmentCopyWithImpl<$Res, Assignment>;
  @useResult
  $Res call(
      {String id,
      String title,
      String? description,
      AssignmentStatus status,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'due_date') DateTime? dueDate,
      @JsonKey(name: 'subject_area') String? subjectArea,
      @JsonKey(name: 'assignment_type') String? assignmentType,
      @JsonKey(name: 'teacher_id') String? teacherId,
      @JsonKey(name: 'classroom_id') String? classroomId,
      @JsonKey(name: 'total_points') int totalPoints,
      @JsonKey(name: 'max_score') int? maxScore,
      @JsonKey(name: 'is_active') bool isActive,
      List<String> attachments,
      @JsonKey(name: 'description_images') List<String> descriptionImages,
      String? instructions});
}

/// @nodoc
class _$AssignmentCopyWithImpl<$Res, $Val extends Assignment>
    implements $AssignmentCopyWith<$Res> {
  _$AssignmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Assignment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? status = null,
    Object? createdAt = null,
    Object? dueDate = freezed,
    Object? subjectArea = freezed,
    Object? assignmentType = freezed,
    Object? teacherId = freezed,
    Object? classroomId = freezed,
    Object? totalPoints = null,
    Object? maxScore = freezed,
    Object? isActive = null,
    Object? attachments = null,
    Object? descriptionImages = null,
    Object? instructions = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AssignmentStatus,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dueDate: freezed == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      subjectArea: freezed == subjectArea
          ? _value.subjectArea
          : subjectArea // ignore: cast_nullable_to_non_nullable
              as String?,
      assignmentType: freezed == assignmentType
          ? _value.assignmentType
          : assignmentType // ignore: cast_nullable_to_non_nullable
              as String?,
      teacherId: freezed == teacherId
          ? _value.teacherId
          : teacherId // ignore: cast_nullable_to_non_nullable
              as String?,
      classroomId: freezed == classroomId
          ? _value.classroomId
          : classroomId // ignore: cast_nullable_to_non_nullable
              as String?,
      totalPoints: null == totalPoints
          ? _value.totalPoints
          : totalPoints // ignore: cast_nullable_to_non_nullable
              as int,
      maxScore: freezed == maxScore
          ? _value.maxScore
          : maxScore // ignore: cast_nullable_to_non_nullable
              as int?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      attachments: null == attachments
          ? _value.attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<String>,
      descriptionImages: null == descriptionImages
          ? _value.descriptionImages
          : descriptionImages // ignore: cast_nullable_to_non_nullable
              as List<String>,
      instructions: freezed == instructions
          ? _value.instructions
          : instructions // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AssignmentImplCopyWith<$Res>
    implements $AssignmentCopyWith<$Res> {
  factory _$$AssignmentImplCopyWith(
          _$AssignmentImpl value, $Res Function(_$AssignmentImpl) then) =
      __$$AssignmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String? description,
      AssignmentStatus status,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'due_date') DateTime? dueDate,
      @JsonKey(name: 'subject_area') String? subjectArea,
      @JsonKey(name: 'assignment_type') String? assignmentType,
      @JsonKey(name: 'teacher_id') String? teacherId,
      @JsonKey(name: 'classroom_id') String? classroomId,
      @JsonKey(name: 'total_points') int totalPoints,
      @JsonKey(name: 'max_score') int? maxScore,
      @JsonKey(name: 'is_active') bool isActive,
      List<String> attachments,
      @JsonKey(name: 'description_images') List<String> descriptionImages,
      String? instructions});
}

/// @nodoc
class __$$AssignmentImplCopyWithImpl<$Res>
    extends _$AssignmentCopyWithImpl<$Res, _$AssignmentImpl>
    implements _$$AssignmentImplCopyWith<$Res> {
  __$$AssignmentImplCopyWithImpl(
      _$AssignmentImpl _value, $Res Function(_$AssignmentImpl) _then)
      : super(_value, _then);

  /// Create a copy of Assignment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? status = null,
    Object? createdAt = null,
    Object? dueDate = freezed,
    Object? subjectArea = freezed,
    Object? assignmentType = freezed,
    Object? teacherId = freezed,
    Object? classroomId = freezed,
    Object? totalPoints = null,
    Object? maxScore = freezed,
    Object? isActive = null,
    Object? attachments = null,
    Object? descriptionImages = null,
    Object? instructions = freezed,
  }) {
    return _then(_$AssignmentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AssignmentStatus,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dueDate: freezed == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      subjectArea: freezed == subjectArea
          ? _value.subjectArea
          : subjectArea // ignore: cast_nullable_to_non_nullable
              as String?,
      assignmentType: freezed == assignmentType
          ? _value.assignmentType
          : assignmentType // ignore: cast_nullable_to_non_nullable
              as String?,
      teacherId: freezed == teacherId
          ? _value.teacherId
          : teacherId // ignore: cast_nullable_to_non_nullable
              as String?,
      classroomId: freezed == classroomId
          ? _value.classroomId
          : classroomId // ignore: cast_nullable_to_non_nullable
              as String?,
      totalPoints: null == totalPoints
          ? _value.totalPoints
          : totalPoints // ignore: cast_nullable_to_non_nullable
              as int,
      maxScore: freezed == maxScore
          ? _value.maxScore
          : maxScore // ignore: cast_nullable_to_non_nullable
              as int?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      attachments: null == attachments
          ? _value._attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<String>,
      descriptionImages: null == descriptionImages
          ? _value._descriptionImages
          : descriptionImages // ignore: cast_nullable_to_non_nullable
              as List<String>,
      instructions: freezed == instructions
          ? _value.instructions
          : instructions // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AssignmentImpl implements _Assignment {
  const _$AssignmentImpl(
      {required this.id,
      required this.title,
      this.description,
      required this.status,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'due_date') this.dueDate,
      @JsonKey(name: 'subject_area') this.subjectArea,
      @JsonKey(name: 'assignment_type') this.assignmentType,
      @JsonKey(name: 'teacher_id') this.teacherId,
      @JsonKey(name: 'classroom_id') this.classroomId,
      @JsonKey(name: 'total_points') this.totalPoints = 100,
      @JsonKey(name: 'max_score') this.maxScore,
      @JsonKey(name: 'is_active') this.isActive = true,
      final List<String> attachments = const [],
      @JsonKey(name: 'description_images')
      final List<String> descriptionImages = const [],
      this.instructions})
      : _attachments = attachments,
        _descriptionImages = descriptionImages;

  factory _$AssignmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$AssignmentImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String? description;
  @override
  final AssignmentStatus status;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'due_date')
  final DateTime? dueDate;
  @override
  @JsonKey(name: 'subject_area')
  final String? subjectArea;
  @override
  @JsonKey(name: 'assignment_type')
  final String? assignmentType;
  @override
  @JsonKey(name: 'teacher_id')
  final String? teacherId;
  @override
  @JsonKey(name: 'classroom_id')
  final String? classroomId;
  @override
  @JsonKey(name: 'total_points')
  final int totalPoints;
  @override
  @JsonKey(name: 'max_score')
  final int? maxScore;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;
  final List<String> _attachments;
  @override
  @JsonKey()
  List<String> get attachments {
    if (_attachments is EqualUnmodifiableListView) return _attachments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attachments);
  }

  final List<String> _descriptionImages;
  @override
  @JsonKey(name: 'description_images')
  List<String> get descriptionImages {
    if (_descriptionImages is EqualUnmodifiableListView)
      return _descriptionImages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_descriptionImages);
  }

  @override
  final String? instructions;

  @override
  String toString() {
    return 'Assignment(id: $id, title: $title, description: $description, status: $status, createdAt: $createdAt, dueDate: $dueDate, subjectArea: $subjectArea, assignmentType: $assignmentType, teacherId: $teacherId, classroomId: $classroomId, totalPoints: $totalPoints, maxScore: $maxScore, isActive: $isActive, attachments: $attachments, descriptionImages: $descriptionImages, instructions: $instructions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AssignmentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.subjectArea, subjectArea) ||
                other.subjectArea == subjectArea) &&
            (identical(other.assignmentType, assignmentType) ||
                other.assignmentType == assignmentType) &&
            (identical(other.teacherId, teacherId) ||
                other.teacherId == teacherId) &&
            (identical(other.classroomId, classroomId) ||
                other.classroomId == classroomId) &&
            (identical(other.totalPoints, totalPoints) ||
                other.totalPoints == totalPoints) &&
            (identical(other.maxScore, maxScore) ||
                other.maxScore == maxScore) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            const DeepCollectionEquality()
                .equals(other._attachments, _attachments) &&
            const DeepCollectionEquality()
                .equals(other._descriptionImages, _descriptionImages) &&
            (identical(other.instructions, instructions) ||
                other.instructions == instructions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      status,
      createdAt,
      dueDate,
      subjectArea,
      assignmentType,
      teacherId,
      classroomId,
      totalPoints,
      maxScore,
      isActive,
      const DeepCollectionEquality().hash(_attachments),
      const DeepCollectionEquality().hash(_descriptionImages),
      instructions);

  /// Create a copy of Assignment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AssignmentImplCopyWith<_$AssignmentImpl> get copyWith =>
      __$$AssignmentImplCopyWithImpl<_$AssignmentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AssignmentImplToJson(
      this,
    );
  }
}

abstract class _Assignment implements Assignment {
  const factory _Assignment(
      {required final String id,
      required final String title,
      final String? description,
      required final AssignmentStatus status,
      @JsonKey(name: 'created_at') required final DateTime createdAt,
      @JsonKey(name: 'due_date') final DateTime? dueDate,
      @JsonKey(name: 'subject_area') final String? subjectArea,
      @JsonKey(name: 'assignment_type') final String? assignmentType,
      @JsonKey(name: 'teacher_id') final String? teacherId,
      @JsonKey(name: 'classroom_id') final String? classroomId,
      @JsonKey(name: 'total_points') final int totalPoints,
      @JsonKey(name: 'max_score') final int? maxScore,
      @JsonKey(name: 'is_active') final bool isActive,
      final List<String> attachments,
      @JsonKey(name: 'description_images') final List<String> descriptionImages,
      final String? instructions}) = _$AssignmentImpl;

  factory _Assignment.fromJson(Map<String, dynamic> json) =
      _$AssignmentImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String? get description;
  @override
  AssignmentStatus get status;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'due_date')
  DateTime? get dueDate;
  @override
  @JsonKey(name: 'subject_area')
  String? get subjectArea;
  @override
  @JsonKey(name: 'assignment_type')
  String? get assignmentType;
  @override
  @JsonKey(name: 'teacher_id')
  String? get teacherId;
  @override
  @JsonKey(name: 'classroom_id')
  String? get classroomId;
  @override
  @JsonKey(name: 'total_points')
  int get totalPoints;
  @override
  @JsonKey(name: 'max_score')
  int? get maxScore;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;
  @override
  List<String> get attachments;
  @override
  @JsonKey(name: 'description_images')
  List<String> get descriptionImages;
  @override
  String? get instructions;

  /// Create a copy of Assignment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AssignmentImplCopyWith<_$AssignmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Submission _$SubmissionFromJson(Map<String, dynamic> json) {
  return _Submission.fromJson(json);
}

/// @nodoc
mixin _$Submission {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'assignment_id')
  String get assignmentId => throw _privateConstructorUsedError;
  @JsonKey(name: 'student_id')
  String get studentId => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  List<String> get attachments => throw _privateConstructorUsedError;
  @JsonKey(name: 'submitted_at')
  DateTime get submittedAt => throw _privateConstructorUsedError;
  String? get feedback => throw _privateConstructorUsedError;
  int? get score => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;

  /// Serializes this Submission to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Submission
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubmissionCopyWith<Submission> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubmissionCopyWith<$Res> {
  factory $SubmissionCopyWith(
          Submission value, $Res Function(Submission) then) =
      _$SubmissionCopyWithImpl<$Res, Submission>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'assignment_id') String assignmentId,
      @JsonKey(name: 'student_id') String studentId,
      String content,
      List<String> attachments,
      @JsonKey(name: 'submitted_at') DateTime submittedAt,
      String? feedback,
      int? score,
      String status});
}

/// @nodoc
class _$SubmissionCopyWithImpl<$Res, $Val extends Submission>
    implements $SubmissionCopyWith<$Res> {
  _$SubmissionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Submission
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? assignmentId = null,
    Object? studentId = null,
    Object? content = null,
    Object? attachments = null,
    Object? submittedAt = null,
    Object? feedback = freezed,
    Object? score = freezed,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      assignmentId: null == assignmentId
          ? _value.assignmentId
          : assignmentId // ignore: cast_nullable_to_non_nullable
              as String,
      studentId: null == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      attachments: null == attachments
          ? _value.attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<String>,
      submittedAt: null == submittedAt
          ? _value.submittedAt
          : submittedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      feedback: freezed == feedback
          ? _value.feedback
          : feedback // ignore: cast_nullable_to_non_nullable
              as String?,
      score: freezed == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SubmissionImplCopyWith<$Res>
    implements $SubmissionCopyWith<$Res> {
  factory _$$SubmissionImplCopyWith(
          _$SubmissionImpl value, $Res Function(_$SubmissionImpl) then) =
      __$$SubmissionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'assignment_id') String assignmentId,
      @JsonKey(name: 'student_id') String studentId,
      String content,
      List<String> attachments,
      @JsonKey(name: 'submitted_at') DateTime submittedAt,
      String? feedback,
      int? score,
      String status});
}

/// @nodoc
class __$$SubmissionImplCopyWithImpl<$Res>
    extends _$SubmissionCopyWithImpl<$Res, _$SubmissionImpl>
    implements _$$SubmissionImplCopyWith<$Res> {
  __$$SubmissionImplCopyWithImpl(
      _$SubmissionImpl _value, $Res Function(_$SubmissionImpl) _then)
      : super(_value, _then);

  /// Create a copy of Submission
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? assignmentId = null,
    Object? studentId = null,
    Object? content = null,
    Object? attachments = null,
    Object? submittedAt = null,
    Object? feedback = freezed,
    Object? score = freezed,
    Object? status = null,
  }) {
    return _then(_$SubmissionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      assignmentId: null == assignmentId
          ? _value.assignmentId
          : assignmentId // ignore: cast_nullable_to_non_nullable
              as String,
      studentId: null == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      attachments: null == attachments
          ? _value._attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<String>,
      submittedAt: null == submittedAt
          ? _value.submittedAt
          : submittedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      feedback: freezed == feedback
          ? _value.feedback
          : feedback // ignore: cast_nullable_to_non_nullable
              as String?,
      score: freezed == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SubmissionImpl implements _Submission {
  const _$SubmissionImpl(
      {required this.id,
      @JsonKey(name: 'assignment_id') required this.assignmentId,
      @JsonKey(name: 'student_id') required this.studentId,
      required this.content,
      final List<String> attachments = const [],
      @JsonKey(name: 'submitted_at') required this.submittedAt,
      this.feedback,
      this.score,
      this.status = 'pending'})
      : _attachments = attachments;

  factory _$SubmissionImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubmissionImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'assignment_id')
  final String assignmentId;
  @override
  @JsonKey(name: 'student_id')
  final String studentId;
  @override
  final String content;
  final List<String> _attachments;
  @override
  @JsonKey()
  List<String> get attachments {
    if (_attachments is EqualUnmodifiableListView) return _attachments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attachments);
  }

  @override
  @JsonKey(name: 'submitted_at')
  final DateTime submittedAt;
  @override
  final String? feedback;
  @override
  final int? score;
  @override
  @JsonKey()
  final String status;

  @override
  String toString() {
    return 'Submission(id: $id, assignmentId: $assignmentId, studentId: $studentId, content: $content, attachments: $attachments, submittedAt: $submittedAt, feedback: $feedback, score: $score, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubmissionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.assignmentId, assignmentId) ||
                other.assignmentId == assignmentId) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.content, content) || other.content == content) &&
            const DeepCollectionEquality()
                .equals(other._attachments, _attachments) &&
            (identical(other.submittedAt, submittedAt) ||
                other.submittedAt == submittedAt) &&
            (identical(other.feedback, feedback) ||
                other.feedback == feedback) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      assignmentId,
      studentId,
      content,
      const DeepCollectionEquality().hash(_attachments),
      submittedAt,
      feedback,
      score,
      status);

  /// Create a copy of Submission
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubmissionImplCopyWith<_$SubmissionImpl> get copyWith =>
      __$$SubmissionImplCopyWithImpl<_$SubmissionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SubmissionImplToJson(
      this,
    );
  }
}

abstract class _Submission implements Submission {
  const factory _Submission(
      {required final String id,
      @JsonKey(name: 'assignment_id') required final String assignmentId,
      @JsonKey(name: 'student_id') required final String studentId,
      required final String content,
      final List<String> attachments,
      @JsonKey(name: 'submitted_at') required final DateTime submittedAt,
      final String? feedback,
      final int? score,
      final String status}) = _$SubmissionImpl;

  factory _Submission.fromJson(Map<String, dynamic> json) =
      _$SubmissionImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'assignment_id')
  String get assignmentId;
  @override
  @JsonKey(name: 'student_id')
  String get studentId;
  @override
  String get content;
  @override
  List<String> get attachments;
  @override
  @JsonKey(name: 'submitted_at')
  DateTime get submittedAt;
  @override
  String? get feedback;
  @override
  int? get score;
  @override
  String get status;

  /// Create a copy of Submission
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubmissionImplCopyWith<_$SubmissionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
