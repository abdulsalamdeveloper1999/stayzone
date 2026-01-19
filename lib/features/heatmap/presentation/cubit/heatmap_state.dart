import 'package:freezed_annotation/freezed_annotation.dart';

part 'heatmap_state.freezed.dart';

@freezed
class HeatmapState with _$HeatmapState {
  const factory HeatmapState({
    @Default({}) Map<DateTime, int> dailyMinutes,
    @Default(0) int totalFocusMinutes,
    @Default(0.0) double dailyAverageMinutes,
    @Default('') String goldenHour,
    @Default('') String mostFocusedDay,
    @Default(false) bool isLoading,
    String? errorMessage,
  }) = _HeatmapState;
}
