// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'urge_report_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UrgeReportModel _$UrgeReportModelFromJson(Map<String, dynamic> json) {
  return _UrgeReportModel.fromJson(json);
}

/// @nodoc
mixin _$UrgeReportModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'intervention_type')
  String get interventionType => throw _privateConstructorUsedError;
  @JsonKey(name: 'reported_at')
  DateTime get reportedAt => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UrgeReportModelCopyWith<UrgeReportModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UrgeReportModelCopyWith<$Res> {
  factory $UrgeReportModelCopyWith(
          UrgeReportModel value, $Res Function(UrgeReportModel) then) =
      _$UrgeReportModelCopyWithImpl<$Res, UrgeReportModel>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'intervention_type') String interventionType,
      @JsonKey(name: 'reported_at') DateTime reportedAt,
      String? content});
}

/// @nodoc
class _$UrgeReportModelCopyWithImpl<$Res, $Val extends UrgeReportModel>
    implements $UrgeReportModelCopyWith<$Res> {
  _$UrgeReportModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? interventionType = null,
    Object? reportedAt = null,
    Object? content = freezed,
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
      interventionType: null == interventionType
          ? _value.interventionType
          : interventionType // ignore: cast_nullable_to_non_nullable
              as String,
      reportedAt: null == reportedAt
          ? _value.reportedAt
          : reportedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UrgeReportModelImplCopyWith<$Res>
    implements $UrgeReportModelCopyWith<$Res> {
  factory _$$UrgeReportModelImplCopyWith(_$UrgeReportModelImpl value,
          $Res Function(_$UrgeReportModelImpl) then) =
      __$$UrgeReportModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'intervention_type') String interventionType,
      @JsonKey(name: 'reported_at') DateTime reportedAt,
      String? content});
}

/// @nodoc
class __$$UrgeReportModelImplCopyWithImpl<$Res>
    extends _$UrgeReportModelCopyWithImpl<$Res, _$UrgeReportModelImpl>
    implements _$$UrgeReportModelImplCopyWith<$Res> {
  __$$UrgeReportModelImplCopyWithImpl(
      _$UrgeReportModelImpl _value, $Res Function(_$UrgeReportModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? interventionType = null,
    Object? reportedAt = null,
    Object? content = freezed,
  }) {
    return _then(_$UrgeReportModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      interventionType: null == interventionType
          ? _value.interventionType
          : interventionType // ignore: cast_nullable_to_non_nullable
              as String,
      reportedAt: null == reportedAt
          ? _value.reportedAt
          : reportedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UrgeReportModelImpl extends _UrgeReportModel {
  const _$UrgeReportModelImpl(
      {required this.id,
      @JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'intervention_type') required this.interventionType,
      @JsonKey(name: 'reported_at') required this.reportedAt,
      this.content})
      : super._();

  factory _$UrgeReportModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UrgeReportModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'intervention_type')
  final String interventionType;
  @override
  @JsonKey(name: 'reported_at')
  final DateTime reportedAt;
  @override
  final String? content;

  @override
  String toString() {
    return 'UrgeReportModel(id: $id, userId: $userId, interventionType: $interventionType, reportedAt: $reportedAt, content: $content)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UrgeReportModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.interventionType, interventionType) ||
                other.interventionType == interventionType) &&
            (identical(other.reportedAt, reportedAt) ||
                other.reportedAt == reportedAt) &&
            (identical(other.content, content) || other.content == content));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, userId, interventionType, reportedAt, content);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UrgeReportModelImplCopyWith<_$UrgeReportModelImpl> get copyWith =>
      __$$UrgeReportModelImplCopyWithImpl<_$UrgeReportModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UrgeReportModelImplToJson(
      this,
    );
  }
}

abstract class _UrgeReportModel extends UrgeReportModel {
  const factory _UrgeReportModel(
      {required final String id,
      @JsonKey(name: 'user_id') required final String userId,
      @JsonKey(name: 'intervention_type')
      required final String interventionType,
      @JsonKey(name: 'reported_at') required final DateTime reportedAt,
      final String? content}) = _$UrgeReportModelImpl;
  const _UrgeReportModel._() : super._();

  factory _UrgeReportModel.fromJson(Map<String, dynamic> json) =
      _$UrgeReportModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  @JsonKey(name: 'intervention_type')
  String get interventionType;
  @override
  @JsonKey(name: 'reported_at')
  DateTime get reportedAt;
  @override
  String? get content;
  @override
  @JsonKey(ignore: true)
  _$$UrgeReportModelImplCopyWith<_$UrgeReportModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
