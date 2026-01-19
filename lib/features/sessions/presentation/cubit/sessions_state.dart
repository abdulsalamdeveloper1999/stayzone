import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../focus/domain/entities/focus_session.dart';

part 'sessions_state.freezed.dart';

@freezed
class SessionsState with _$SessionsState {
  const factory SessionsState({
    @Default([]) List<FocusSessionEntity> sessions,
    @Default(false) bool isLoading,
    String? errorMessage,
  }) = _SessionsState;
}
