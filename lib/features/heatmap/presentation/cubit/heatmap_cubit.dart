import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../focus/domain/usecases/get_focus_history.dart';
import '../../../focus/domain/entities/focus_session.dart';
import 'heatmap_state.dart';

@injectable
class HeatmapCubit extends Cubit<HeatmapState> {
  final GetFocusHistory _getFocusHistory;

  HeatmapCubit(this._getFocusHistory) : super(const HeatmapState());

  Future<void> loadHeatmapData(String userId) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _getFocusHistory(userId);

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (history) {
        if (history.isEmpty) {
          emit(state.copyWith(isLoading: false));
          return;
        }

        final dailyMinutes = _calculateDailyMinutes(history);
        final totalFocusMinutes = _calculateTotalFocusMinutes(history);
        final dailyAverageMinutes = _calculateDailyAverage(dailyMinutes);
        final goldenHour = _calculateGoldenHour(history);
        final mostFocusedDay = _calculateMostFocusedDay(dailyMinutes);

        emit(
          state.copyWith(
            isLoading: false,
            dailyMinutes: dailyMinutes,
            totalFocusMinutes: totalFocusMinutes,
            dailyAverageMinutes: dailyAverageMinutes,
            goldenHour: goldenHour,
            mostFocusedDay: mostFocusedDay,
          ),
        );
      },
    );
  }

  Map<DateTime, int> _calculateDailyMinutes(List<FocusSessionEntity> history) {
    final Map<DateTime, int> daily = {};
    for (final session in history) {
      if (session.completedAt != null) {
        final date = DateTime(
          session.completedAt!.year,
          session.completedAt!.month,
          session.completedAt!.day,
        );
        daily[date] = (daily[date] ?? 0) + session.completedMinutes;
      }
    }
    return daily;
  }

  int _calculateTotalFocusMinutes(List<FocusSessionEntity> history) {
    return history.fold(0, (sum, session) => sum + session.completedMinutes);
  }

  double _calculateDailyAverage(Map<DateTime, int> dailyMinutes) {
    if (dailyMinutes.isEmpty) return 0.0;
    final total = dailyMinutes.values.fold(0, (sum, m) => sum + m);
    return total / dailyMinutes.length;
  }

  String _calculateGoldenHour(List<FocusSessionEntity> history) {
    if (history.isEmpty) return 'N/A';

    // Count focus minutes started in each hour
    final hourCounts = List.filled(24, 0);
    for (final session in history) {
      final hour = session.startedAt.toLocal().hour;
      hourCounts[hour] += session.completedMinutes;
    }

    // Find the 2-hour window with most focus
    int maxMinutes = -1;
    int bestStartHour = 0;

    for (int i = 0; i < 24; i++) {
      final currentWindow = hourCounts[i] + hourCounts[(i + 1) % 24];
      if (currentWindow > maxMinutes) {
        maxMinutes = currentWindow;
        bestStartHour = i;
      }
    }

    if (maxMinutes <= 0) return 'N/A';

    final endHour = (bestStartHour + 2) % 24;
    final startLabel = _formatHour(bestStartHour);
    final endLabel = _formatHour(endHour);

    return '$startLabel - $endLabel';
  }

  String _formatHour(int hour) {
    if (hour == 0) return '12 AM';
    if (hour == 12) return '12 PM';
    if (hour > 12) return '${hour - 12} PM';
    return '$hour AM';
  }

  String _calculateMostFocusedDay(Map<DateTime, int> dailyMinutes) {
    if (dailyMinutes.isEmpty) return 'N/A';

    final dayOfWeekTotals = List.filled(7, 0); // 0 = Monday, ..., 6 = Sunday
    for (final entry in dailyMinutes.entries) {
      final dayIndex = entry.key.weekday - 1; // 1 (Mon) - 7 (Sun) -> 0 - 6
      dayOfWeekTotals[dayIndex] += entry.value;
    }

    int maxMinutes = -1;
    int bestDayIndex = 0;
    for (int i = 0; i < 7; i++) {
      if (dayOfWeekTotals[i] > maxMinutes) {
        maxMinutes = dayOfWeekTotals[i];
        bestDayIndex = i;
      }
    }

    if (maxMinutes <= 0) return 'N/A';

    const days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    return days[bestDayIndex];
  }
}
