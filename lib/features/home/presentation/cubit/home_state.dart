import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(25 * 60) int remainingSeconds,
    @Default(25 * 60) int totalSeconds,
    @Default(false) bool isPaused,
    @Default(false) bool isRunning,
    @Default(0) int todayTotalMinutes,
    @Default(0) int userStreak,
    @Default(0) int todayUrgesCount,
    @Default(0) int monkActiveCount,
    @Default([]) List<String> monkRecentTitles,
    @Default("Ready for a session?") String dailyInsight,
    String? goldenHour,
    String? dangerZone,
    String? currentSessionId,
    String? currentActivity,
  }) = _HomeState;
}
