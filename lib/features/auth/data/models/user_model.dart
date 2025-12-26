import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entities/user.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel implements UserEntity {
  const factory UserModel({
    required String id,
    required String email,
    String? name,
    @Default(0) @JsonKey(name: 'total_focus_minutes') int totalFocusMinutes,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  factory UserModel.fromSupabaseUser(
    User user, {
    Map<String, dynamic>? profileData,
  }) {
    return UserModel(
      id: user.id,
      email: user.email ?? '',
      name: profileData?['name'] ?? user.userMetadata?['name'],
      totalFocusMinutes:
          (profileData?['total_focus_minutes'] as int?) ??
          (user.userMetadata?['total_focus_minutes'] as int?) ??
          0,
    );
  }
}
