import 'package:injectable/injectable.dart';
import '../../features/focus/domain/entities/focus_session.dart';
import '../../features/urges/domain/entities/urge_report.dart';

@lazySingleton
class InsightService {
  /// Calculates the hour of the day (0-23) when the user has the most focus minutes.
  int? calculateGoldenHour(List<FocusSessionEntity> sessions) {
    if (sessions.isEmpty) return null;

    final Map<int, int> hourToMinutes = {};

    for (final session in sessions) {
      final hour = session.startedAt.hour;
      hourToMinutes[hour] =
          (hourToMinutes[hour] ?? 0) + session.completedMinutes;
    }

    if (hourToMinutes.isEmpty) return null;

    return hourToMinutes.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
  }

  /// Calculates the hour of the day (0-23) when the user reports the most urges.
  int? calculateDangerZone(List<UrgeReportEntity> reports) {
    if (reports.isEmpty) return null;

    final Map<int, int> hourToCounts = {};

    for (final report in reports) {
      final hour = report.reportedAt.hour;
      hourToCounts[hour] = (hourToCounts[hour] ?? 0) + 1;
    }

    if (hourToCounts.isEmpty) return null;

    return hourToCounts.entries.reduce((a, b) => a.value > b.value ? a : b).key;
  }

  /// Calculates focus efficiency compared to previous day/week.
  double calculateEfficiency(List<FocusSessionEntity> sessions) {
    if (sessions.length < 2) return 1.0;

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    int todayMinutes = 0;
    int yesterdayMinutes = 0;

    for (final session in sessions) {
      final sessionDate = DateTime(
        session.startedAt.year,
        session.startedAt.month,
        session.startedAt.day,
      );

      if (sessionDate.isAtSameMomentAs(today)) {
        todayMinutes += session.completedMinutes;
      } else if (sessionDate.isAtSameMomentAs(yesterday)) {
        yesterdayMinutes += session.completedMinutes;
      }
    }

    if (yesterdayMinutes == 0) return 1.0;
    return todayMinutes / yesterdayMinutes;
  }

  /// Generates a human-readable insight based on current stats and history.
  String generateInsight({
    required int? goldenHour,
    required int? dangerZone,
    required double efficiency,
    required int todayMinutes,
    required int todayUrges,
  }) {
    if (todayMinutes == 0 && todayUrges == 0) {
      return "Ready for a session? Your 'Monk Mode' is waiting for you.";
    }

    if (efficiency > 1.2) {
      return "You're on fire! Your focus is ${((efficiency - 1) * 100).toInt()}% higher than yesterday.";
    }

    if (dangerZone != null && DateTime.now().hour == dangerZone) {
      return "You're in your 'Danger Zone'. This is when you're most distracted. Take a deep breath!";
    }

    if (goldenHour != null && DateTime.now().hour == goldenHour) {
      return "It's your 'Golden Hour'! This is your peak focus time. Go deep!";
    }

    if (todayUrges > 3) {
      return "You've resisted $todayUrges distractions today. Your discipline is building!";
    }

    return "Keep going. Every minute of focus is a step toward your goals.";
  }

  String formatHour(int hour) {
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
    return "$displayHour $period";
  }
}
