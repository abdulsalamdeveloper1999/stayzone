import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/error/exceptions.dart';
import '../models/focus_session_model.dart';

abstract class FocusRemoteDataSource {
  Future<FocusSessionModel> createSession({
    required String userId,
    required String activityType,
    required int durationMinutes,
  });

  Future<FocusSessionModel> completeSession({
    required String sessionId,
    required int completedMinutes,
  });

  Future<int> getTodaysFocusMinutes(String userId);

  Future<int> getUserStreak(String userId);
}

@LazySingleton(as: FocusRemoteDataSource)
class FocusRemoteDataSourceImpl implements FocusRemoteDataSource {
  final SupabaseClient supabaseClient;

  FocusRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<FocusSessionModel> createSession({
    required String userId,
    required String activityType,
    required int durationMinutes,
  }) async {
    try {
      final response = await supabaseClient
          .from('focus_sessions')
          .insert({
            'user_id': userId,
            'activity_type': activityType,
            'duration_minutes': durationMinutes,
            'completed_minutes': 0,
            'started_at': DateTime.now().toIso8601String(),
            'was_completed': false,
          })
          .select()
          .single();

      return FocusSessionModel.fromJson(response);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<FocusSessionModel> completeSession({
    required String sessionId,
    required int completedMinutes,
  }) async {
    try {
      final response = await supabaseClient
          .from('focus_sessions')
          .update({
            'completed_minutes': completedMinutes,
            'completed_at': DateTime.now().toIso8601String(),
            'was_completed': true,
          })
          .eq('id', sessionId)
          .select()
          .single();

      return FocusSessionModel.fromJson(response);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<int> getTodaysFocusMinutes(String userId) async {
    try {
      final now = DateTime.now();
      final startOfDay = DateTime(now.year, now.month, now.day);
      final endOfDay = startOfDay.add(const Duration(days: 1));

      final response = await supabaseClient
          .from('focus_sessions')
          .select('completed_minutes')
          .eq('user_id', userId)
          .gte('completed_at', startOfDay.toIso8601String())
          .lt('completed_at', endOfDay.toIso8601String())
          .eq('was_completed', true);

      if (response.isEmpty) return 0;

      int total = 0;
      for (final session in response) {
        total += (session['completed_minutes'] as int?) ?? 0;
      }
      return total;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<int> getUserStreak(String userId) async {
    try {
      // Get all distinct dates with completed sessions, ordered DESC
      final response = await supabaseClient
          .from('focus_sessions')
          .select('completed_at')
          .eq('user_id', userId)
          .eq('was_completed', true)
          .order('completed_at', ascending: false);

      if (response.isEmpty) return 0;

      // Extract unique dates
      final Set<String> uniqueDates = {};
      final now = DateTime.now();

      for (final session in response) {
        final completedAt = DateTime.parse(session['completed_at'] as String);
        final dateOnly = DateTime(
          completedAt.year,
          completedAt.month,
          completedAt.day,
        );
        uniqueDates.add(dateOnly.toIso8601String().split('T')[0]);
      }

      // Convert to sorted list (newest first)
      final sortedDates = uniqueDates.toList()..sort((a, b) => b.compareTo(a));

      // Calculate streak
      int streak = 0;
      final today = DateTime(now.year, now.month, now.day);
      DateTime checkDate = today;

      for (final dateStr in sortedDates) {
        final sessionDate = DateTime.parse(dateStr);

        // Check if this date matches our expected date
        if (sessionDate.year == checkDate.year &&
            sessionDate.month == checkDate.month &&
            sessionDate.day == checkDate.day) {
          streak++;
          // Move to previous day
          checkDate = checkDate.subtract(const Duration(days: 1));
        } else {
          // Gap found, break streak
          break;
        }
      }

      return streak;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
