// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'focus_session_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FocusSessionModel _$FocusSessionModelFromJson(Map<String, dynamic> json) {
  return _FocusSessionModel.fromJson(json);
}

/// @nodoc
mixin _$FocusSessionModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'activity_type')
  String get activityType => throw _privateConstructorUsedError;
  @JsonKey(name: 'duration_minutes')
  int get durationMinutes => throw _privateConstructorUsedError;
  @JsonKey(name: 'completed_minutes')
  int get completedMinutes => throw _privateConstructorUsedError;
  @JsonKey(name: 'started_at')
  DateTime get startedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'completed_at')
  DateTime? get completedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'was_completed')
  bool get wasCompleted => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FocusSessionModelCopyWith<FocusSessionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FocusSessionModelCopyWith<$Res> {
  factory $FocusSessionModelCopyWith(
          FocusSessionModel value, $Res Function(FocusSessionModel) then) =
      _$FocusSessionModelCopyWithImpl<$Res, FocusSessionModel>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'activity_type') String activityType,
      @JsonKey(name: 'duration_minutes') int durationMinutes,
      @JsonKey(name: 'completed_minutes') int completedMinutes,
      @JsonKey(name: 'started_at') DateTime startedAt,
      @JsonKey(name: 'completed_at') DateTime? completedAt,
      @JsonKey(name: 'was_completed') bool wasCompleted});
}

/// @nodoc
class _$FocusSessionModelCopyWithImpl<$Res, $Val extends FocusSessionModel>
    implements $FocusSessionModelCopyWith<$Res> {
  _$FocusSessionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? activityType = null,
    Object? durationMinutes = null,
    Object? completedMinutes = null,
    Object? startedAt = null,
    Object? completedAt = freezed,
    Object? wasCompleted = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      activityType: null == activityType
          ? _value.activityType
          : activityType // ignore: cast_nullable_to_non_nullable
              as String,
      durationMinutes: null == durationMinutes
          ? _value.durationMinutes
          : durationMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      completedMinutes: null == completedMinutes
          ? _value.completedMinutes
          : completedMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      startedAt: null == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      wasCompleted: null == wasCompleted
          ? _value.wasCompleted
          : wasCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FocusSessionModelImplCopyWith<$Res>
    implements $FocusSessionModelCopyWith<$Res> {
  factory _$$FocusSessionModelImplCopyWith(_$FocusSessionModelImpl value,
          $Res Function(_$FocusSessionModelImpl) then) =
      __$$FocusSessionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'activity_type') String activityType,
      @JsonKey(name: 'duration_minutes') int durationMinutes,
      @JsonKey(name: 'completed_minutes') int completedMinutes,
      @JsonKey(name: 'started_at') DateTime startedAt,
      @JsonKey(name: 'completed_at') DateTime? completedAt,
      @JsonKey(name: 'was_completed') bool wasCompleted});
}

/// @nodoc
class __$$FocusSessionModelImplCopyWithImpl<$Res>
    extends _$FocusSessionModelCopyWithImpl<$Res, _$FocusSessionModelImpl>
    implements _$$FocusSessionModelImplCopyWith<$Res> {
  __$$FocusSessionModelImplCopyWithImpl(_$FocusSessionModelImpl _value,
      $Res Function(_$FocusSessionModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? activityType = null,
    Object? durationMinutes = null,
    Object? completedMinutes = null,
    Object? startedAt = null,
    Object? completedAt = freezed,
    Object? wasCompleted = null,
  }) {
    return _then(_$FocusSessionModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      activityType: null == activityType
          ? _value.activityType
          : activityType // ignore: cast_nullable_to_non_nullable
              as String,
      durationMinutes: null == durationMinutes
          ? _value.durationMinutes
          : durationMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      completedMinutes: null == completedMinutes
          ? _value.completedMinutes
          : completedMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      startedAt: null == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      wasCompleted: null == wasCompleted
          ? _value.wasCompleted
          : wasCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FocusSessionModelImpl extends _FocusSessionModel {
  const _$FocusSessionModelImpl(
      {required this.id,
      @JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'activity_type') required this.activityType,
      @JsonKey(name: 'duration_minutes') required this.durationMinutes,
      @JsonKey(name: 'completed_minutes') required this.completedMinutes,
      @JsonKey(name: 'started_at') required this.startedAt,
      @JsonKey(name: 'completed_at') this.completedAt,
      @JsonKey(name: 'was_completed') this.wasCompleted = false})
      : super._();

  factory _$FocusSessionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FocusSessionModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'activity_type')
  final String activityType;
  @override
  @JsonKey(name: 'duration_minutes')
  final int durationMinutes;
  @override
  @JsonKey(name: 'completed_minutes')
  final int completedMinutes;
  @override
  @JsonKey(name: 'started_at')
  final DateTime startedAt;
  @override
  @JsonKey(name: 'completed_at')
  final DateTime? completedAt;
  @override
  @JsonKey(name: 'was_completed')
  final bool wasCompleted;

  @override
  String toString() {
    return 'FocusSessionModel(id: $id, userId: $userId, activityType: $activityType, durationMinutes: $durationMinutes, completedMinutes: $completedMinutes, startedAt: $startedAt, completedAt: $completedAt, wasCompleted: $wasCompleted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FocusSessionModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.activityType, activityType) ||
                other.activityType == activityType) &&
            (identical(other.durationMinutes, durationMinutes) ||
                other.durationMinutes == durationMinutes) &&
            (identical(other.completedMinutes, completedMinutes) ||
                other.completedMinutes == completedMinutes) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.wasCompleted, wasCompleted) ||
                other.wasCompleted == wasCompleted));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, activityType,
      durationMinutes, completedMinutes, startedAt, completedAt, wasCompleted);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FocusSessionModelImplCopyWith<_$FocusSessionModelImpl> get copyWith =>
      __$$FocusSessionModelImplCopyWithImpl<_$FocusSessionModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FocusSessionModelImplToJson(
      this,
    );
  }
}

abstract class _FocusSessionModel extends FocusSessionModel {
  const factory _FocusSessionModel(
      {required final String id,
      @JsonKey(name: 'user_id') required final String userId,
      @JsonKey(name: 'activity_type') required final String activityType,
      @JsonKey(name: 'duration_minutes') required final int durationMinutes,
      @JsonKey(name: 'completed_minutes') required final int completedMinutes,
      @JsonKey(name: 'started_at') required final DateTime startedAt,
      @JsonKey(name: 'completed_at') final DateTime? completedAt,
      @JsonKey(name: 'was_completed')
      final bool wasCompleted}) = _$FocusSessionModelImpl;
  const _FocusSessionModel._() : super._();

  factory _FocusSessionModel.fromJson(Map<String, dynamic> json) =
      _$FocusSessionModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  @JsonKey(name: 'activity_type')
  String get activityType;
  @override
  @JsonKey(name: 'duration_minutes')
  int get durationMinutes;
  @override
  @JsonKey(name: 'completed_minutes')
  int get completedMinutes;
  @override
  @JsonKey(name: 'started_at')
  DateTime get startedAt;
  @override
  @JsonKey(name: 'completed_at')
  DateTime? get completedAt;
  @override
  @JsonKey(name: 'was_completed')
  bool get wasCompleted;
  @override
  @JsonKey(ignore: true)
  _$$FocusSessionModelImplCopyWith<_$FocusSessionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
