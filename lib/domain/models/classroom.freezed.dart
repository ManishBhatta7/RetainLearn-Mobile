// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'classroom.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Classroom _$ClassroomFromJson(Map<String, dynamic> json) {
  return _Classroom.fromJson(json);
}

/// @nodoc
mixin _$Classroom {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'teacher_id')
  String get teacherId => throw _privateConstructorUsedError;
  @JsonKey(name: 'join_code')
  String? get joinCode => throw _privateConstructorUsedError;
  String? get subject => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'student_ids')
  List<String> get studentIds => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;

  /// Serializes this Classroom to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Classroom
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClassroomCopyWith<Classroom> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClassroomCopyWith<$Res> {
  factory $ClassroomCopyWith(Classroom value, $Res Function(Classroom) then) =
      _$ClassroomCopyWithImpl<$Res, Classroom>;
  @useResult
  $Res call(
      {String id,
      String name,
      String? description,
      @JsonKey(name: 'teacher_id') String teacherId,
      @JsonKey(name: 'join_code') String? joinCode,
      String? subject,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'student_ids') List<String> studentIds,
      bool isActive});
}

/// @nodoc
class _$ClassroomCopyWithImpl<$Res, $Val extends Classroom>
    implements $ClassroomCopyWith<$Res> {
  _$ClassroomCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Classroom
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? teacherId = null,
    Object? joinCode = freezed,
    Object? subject = freezed,
    Object? createdAt = freezed,
    Object? studentIds = null,
    Object? isActive = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      teacherId: null == teacherId
          ? _value.teacherId
          : teacherId // ignore: cast_nullable_to_non_nullable
              as String,
      joinCode: freezed == joinCode
          ? _value.joinCode
          : joinCode // ignore: cast_nullable_to_non_nullable
              as String?,
      subject: freezed == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      studentIds: null == studentIds
          ? _value.studentIds
          : studentIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClassroomImplCopyWith<$Res>
    implements $ClassroomCopyWith<$Res> {
  factory _$$ClassroomImplCopyWith(
          _$ClassroomImpl value, $Res Function(_$ClassroomImpl) then) =
      __$$ClassroomImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String? description,
      @JsonKey(name: 'teacher_id') String teacherId,
      @JsonKey(name: 'join_code') String? joinCode,
      String? subject,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'student_ids') List<String> studentIds,
      bool isActive});
}

/// @nodoc
class __$$ClassroomImplCopyWithImpl<$Res>
    extends _$ClassroomCopyWithImpl<$Res, _$ClassroomImpl>
    implements _$$ClassroomImplCopyWith<$Res> {
  __$$ClassroomImplCopyWithImpl(
      _$ClassroomImpl _value, $Res Function(_$ClassroomImpl) _then)
      : super(_value, _then);

  /// Create a copy of Classroom
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? teacherId = null,
    Object? joinCode = freezed,
    Object? subject = freezed,
    Object? createdAt = freezed,
    Object? studentIds = null,
    Object? isActive = null,
  }) {
    return _then(_$ClassroomImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      teacherId: null == teacherId
          ? _value.teacherId
          : teacherId // ignore: cast_nullable_to_non_nullable
              as String,
      joinCode: freezed == joinCode
          ? _value.joinCode
          : joinCode // ignore: cast_nullable_to_non_nullable
              as String?,
      subject: freezed == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      studentIds: null == studentIds
          ? _value._studentIds
          : studentIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClassroomImpl implements _Classroom {
  const _$ClassroomImpl(
      {required this.id,
      required this.name,
      this.description,
      @JsonKey(name: 'teacher_id') required this.teacherId,
      @JsonKey(name: 'join_code') this.joinCode,
      this.subject,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'student_ids') final List<String> studentIds = const [],
      this.isActive = true})
      : _studentIds = studentIds;

  factory _$ClassroomImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClassroomImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? description;
  @override
  @JsonKey(name: 'teacher_id')
  final String teacherId;
  @override
  @JsonKey(name: 'join_code')
  final String? joinCode;
  @override
  final String? subject;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  final List<String> _studentIds;
  @override
  @JsonKey(name: 'student_ids')
  List<String> get studentIds {
    if (_studentIds is EqualUnmodifiableListView) return _studentIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_studentIds);
  }

  @override
  @JsonKey()
  final bool isActive;

  @override
  String toString() {
    return 'Classroom(id: $id, name: $name, description: $description, teacherId: $teacherId, joinCode: $joinCode, subject: $subject, createdAt: $createdAt, studentIds: $studentIds, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClassroomImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.teacherId, teacherId) ||
                other.teacherId == teacherId) &&
            (identical(other.joinCode, joinCode) ||
                other.joinCode == joinCode) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality()
                .equals(other._studentIds, _studentIds) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      teacherId,
      joinCode,
      subject,
      createdAt,
      const DeepCollectionEquality().hash(_studentIds),
      isActive);

  /// Create a copy of Classroom
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClassroomImplCopyWith<_$ClassroomImpl> get copyWith =>
      __$$ClassroomImplCopyWithImpl<_$ClassroomImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClassroomImplToJson(
      this,
    );
  }
}

abstract class _Classroom implements Classroom {
  const factory _Classroom(
      {required final String id,
      required final String name,
      final String? description,
      @JsonKey(name: 'teacher_id') required final String teacherId,
      @JsonKey(name: 'join_code') final String? joinCode,
      final String? subject,
      @JsonKey(name: 'created_at') final DateTime? createdAt,
      @JsonKey(name: 'student_ids') final List<String> studentIds,
      final bool isActive}) = _$ClassroomImpl;

  factory _Classroom.fromJson(Map<String, dynamic> json) =
      _$ClassroomImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  @JsonKey(name: 'teacher_id')
  String get teacherId;
  @override
  @JsonKey(name: 'join_code')
  String? get joinCode;
  @override
  String? get subject;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'student_ids')
  List<String> get studentIds;
  @override
  bool get isActive;

  /// Create a copy of Classroom
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClassroomImplCopyWith<_$ClassroomImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Doubt _$DoubtFromJson(Map<String, dynamic> json) {
  return _Doubt.fromJson(json);
}

/// @nodoc
mixin _$Doubt {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'student_id')
  String get studentId => throw _privateConstructorUsedError;
  String get question => throw _privateConstructorUsedError;
  String? get answer => throw _privateConstructorUsedError;
  String? get subject => throw _privateConstructorUsedError;
  String get status =>
      throw _privateConstructorUsedError; // open, in_progress, solved
  String get priority =>
      throw _privateConstructorUsedError; // low, medium, high
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'answered_at')
  DateTime? get answeredAt => throw _privateConstructorUsedError;

  /// Serializes this Doubt to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Doubt
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DoubtCopyWith<Doubt> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DoubtCopyWith<$Res> {
  factory $DoubtCopyWith(Doubt value, $Res Function(Doubt) then) =
      _$DoubtCopyWithImpl<$Res, Doubt>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'student_id') String studentId,
      String question,
      String? answer,
      String? subject,
      String status,
      String priority,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'answered_at') DateTime? answeredAt});
}

/// @nodoc
class _$DoubtCopyWithImpl<$Res, $Val extends Doubt>
    implements $DoubtCopyWith<$Res> {
  _$DoubtCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Doubt
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? studentId = null,
    Object? question = null,
    Object? answer = freezed,
    Object? subject = freezed,
    Object? status = null,
    Object? priority = null,
    Object? createdAt = null,
    Object? answeredAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      studentId: null == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String,
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      answer: freezed == answer
          ? _value.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as String?,
      subject: freezed == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      answeredAt: freezed == answeredAt
          ? _value.answeredAt
          : answeredAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DoubtImplCopyWith<$Res> implements $DoubtCopyWith<$Res> {
  factory _$$DoubtImplCopyWith(
          _$DoubtImpl value, $Res Function(_$DoubtImpl) then) =
      __$$DoubtImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'student_id') String studentId,
      String question,
      String? answer,
      String? subject,
      String status,
      String priority,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'answered_at') DateTime? answeredAt});
}

/// @nodoc
class __$$DoubtImplCopyWithImpl<$Res>
    extends _$DoubtCopyWithImpl<$Res, _$DoubtImpl>
    implements _$$DoubtImplCopyWith<$Res> {
  __$$DoubtImplCopyWithImpl(
      _$DoubtImpl _value, $Res Function(_$DoubtImpl) _then)
      : super(_value, _then);

  /// Create a copy of Doubt
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? studentId = null,
    Object? question = null,
    Object? answer = freezed,
    Object? subject = freezed,
    Object? status = null,
    Object? priority = null,
    Object? createdAt = null,
    Object? answeredAt = freezed,
  }) {
    return _then(_$DoubtImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      studentId: null == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String,
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      answer: freezed == answer
          ? _value.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as String?,
      subject: freezed == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      answeredAt: freezed == answeredAt
          ? _value.answeredAt
          : answeredAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DoubtImpl implements _Doubt {
  const _$DoubtImpl(
      {required this.id,
      @JsonKey(name: 'student_id') required this.studentId,
      required this.question,
      this.answer,
      this.subject,
      this.status = 'open',
      this.priority = 'medium',
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'answered_at') this.answeredAt});

  factory _$DoubtImpl.fromJson(Map<String, dynamic> json) =>
      _$$DoubtImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'student_id')
  final String studentId;
  @override
  final String question;
  @override
  final String? answer;
  @override
  final String? subject;
  @override
  @JsonKey()
  final String status;
// open, in_progress, solved
  @override
  @JsonKey()
  final String priority;
// low, medium, high
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'answered_at')
  final DateTime? answeredAt;

  @override
  String toString() {
    return 'Doubt(id: $id, studentId: $studentId, question: $question, answer: $answer, subject: $subject, status: $status, priority: $priority, createdAt: $createdAt, answeredAt: $answeredAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DoubtImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.question, question) ||
                other.question == question) &&
            (identical(other.answer, answer) || other.answer == answer) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.answeredAt, answeredAt) ||
                other.answeredAt == answeredAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, studentId, question, answer,
      subject, status, priority, createdAt, answeredAt);

  /// Create a copy of Doubt
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DoubtImplCopyWith<_$DoubtImpl> get copyWith =>
      __$$DoubtImplCopyWithImpl<_$DoubtImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DoubtImplToJson(
      this,
    );
  }
}

abstract class _Doubt implements Doubt {
  const factory _Doubt(
      {required final String id,
      @JsonKey(name: 'student_id') required final String studentId,
      required final String question,
      final String? answer,
      final String? subject,
      final String status,
      final String priority,
      @JsonKey(name: 'created_at') required final DateTime createdAt,
      @JsonKey(name: 'answered_at') final DateTime? answeredAt}) = _$DoubtImpl;

  factory _Doubt.fromJson(Map<String, dynamic> json) = _$DoubtImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'student_id')
  String get studentId;
  @override
  String get question;
  @override
  String? get answer;
  @override
  String? get subject;
  @override
  String get status; // open, in_progress, solved
  @override
  String get priority; // low, medium, high
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'answered_at')
  DateTime? get answeredAt;

  /// Create a copy of Doubt
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DoubtImplCopyWith<_$DoubtImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
